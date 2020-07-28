import 'package:flutter/material.dart';
import 'package:music/bloc/lyrics_bloc.dart';
import 'package:music/models/track_list_model.dart';
import 'package:music/bloc/track_list_bloc.dart';
import 'track_detail.dart';
import 'package:music/bloc/connectivity.dart';
import 'package:connectivity/connectivity.dart';
import 'bookmark.dart';
import 'package:music/bloc/track_bloc.dart';
import 'package:music/bloc/bookmark_bloc.dart';

class TrackList extends StatefulWidget {
  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
   // bookmarkBloc.fetchBookmarkList();
  }
  @override
  void dispose() {
    
    super.dispose();
    bloc.dispose();
    trackBloc.dispose();
    lyricsBloc.dispose();
    _connectivity.disposeStream();
    bookmarkBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_source.keys.toList()[0]==ConnectivityResult.none){
        return Scaffold(
           appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5.0,
          title: Text('Trending',style: TextStyle(color: Colors.black),),
        ),
                  body: Center(
            child:Text('No Internet Connection'),
          ),
        );
    }
    else{
      bloc.fetchTrackList();
    return Scaffold(
       appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 5.0,
          title: Text('Trending',style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(
              icon: Icon(Icons.bookmark,color: Colors.black,), 
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookmarkList()));
            })
          ],
        ),
          body: StreamBuilder(
          stream: bloc.trackList,
          builder: (context,AsyncSnapshot<TrackListModel> snapshot){
              if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }
          ),
    );
      
    }
  }
}

Widget buildList(AsyncSnapshot<TrackListModel> snapshot){
  return ListView.builder(
    itemCount: snapshot.data.trackList.length,
    itemBuilder: (BuildContext context,int index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>TrackDetail(trackId: snapshot.data.trackList[index].id,name: snapshot.data.trackList[index].trackName,)
                )
                );
            },
            child: Card(
                child: Container(
                  height: 85,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        
                        child: SingleChildScrollView(
                                                child: listTile(
                            title: snapshot.data.trackList[index].trackName,
                            subtitle: snapshot.data.trackList[index].albumName,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                     // Padding(padding: EdgeInsets.only(right: 15.0)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        snapshot.data.trackList[index].artistName,
                         style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),

                      ))),
                    ],
                  ),
                ),
            ),
          );
    }
    );
}

Widget listTile ({String title,String subtitle}){
  return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              Icon(Icons.library_music),
              Padding(padding: EdgeInsets.only(left: 20.0)),
              Expanded(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            ),
                    Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                              //fontWeight: FontWeight.bold,
                            ),
                            ),
                  ],
                ),
              ),
              
                ],
              );
}

//   Widget buildList(AsyncSnapshot<TrackModel> snapshot) {
//     return GridView.builder(
//         itemCount: snapshot.data.trackList.length,
//         gridDelegate:
//             new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (BuildContext context, int index) {
//           return Image.network(
//             'https://image.tmdb.org/t/p/w185${snapshot.data
//                 .results[index].poster_path}',
//             fit: BoxFit.cover,
//           );
//         });
//   }
// }