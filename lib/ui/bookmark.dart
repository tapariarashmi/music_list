import 'package:flutter/material.dart';
import 'package:music/bloc/bookmark_bloc.dart';
import 'package:music/models/bookmark_model.dart';
import 'track_detail.dart';
import 'package:connectivity/connectivity.dart';
import 'package:music/bloc/connectivity.dart';

class BookmarkList extends StatefulWidget {
  @override
  _BookmarkListState createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
     Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  Color bookmarkColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }
  @override
  void dispose() {
    super.dispose();
    //bookmarkBloc.dispose();
  }
  @override
  Widget build(BuildContext context) {
        if(_source.keys.toList()[0]==ConnectivityResult.none){
        return Scaffold(
          appBar: AppBar(
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:Text('Bookmarked',style: TextStyle(color:Colors.black),),
        ),
      body:Center(child: Text('No Internet Connection')),
        );
    }
    else{
    bookmarkBloc.fetchBookmarkList();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 5.0,
          title: Text('Bookmarked',style: TextStyle(color: Colors.black),),
        ),
          body: StreamBuilder(
            stream: bookmarkBloc.bookmarkList,
        builder: (context,AsyncSnapshot<BookmarkListModel> snapshot){
           if (snapshot.hasData) {
             print('has data');
              return buildBookmarkList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());

      }),
    );
    }
  }
}

Widget buildBookmarkList(AsyncSnapshot<BookmarkListModel> snapshot){
  
   if(snapshot.data.bookmarkList.length==0){
        print('here');
        return Center(child: Text('Bookmark your favourite Songs!',style: TextStyle(fontSize: 20.0),));
      }
else{
  print('list builder');
  return ListView.builder(
    itemCount: snapshot.data.bookmarkList.length,
    itemBuilder: (context,index){
        print('length');
        print(snapshot.data.bookmarkList.length);
      return GestureDetector(
         onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>TrackDetail(trackId: snapshot.data.bookmarkList[index].trackId,name: snapshot.data.bookmarkList[index].name,)
                )
                );
            },
              child: Card(
          elevation: 5.0,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
            leading: Icon(Icons.library_music),
            trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
              bookmarkBloc.deleteBookmark(snapshot.data.bookmarkList[index].trackId);
            }),
            title: Text(snapshot.data.bookmarkList[index].name,style:TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
),),
          ),
                ),
        ),
      );

    
    }
    );
}
    

}