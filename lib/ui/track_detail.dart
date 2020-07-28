import 'package:flutter/material.dart';
import 'package:music/models/track_model.dart';
import 'package:music/bloc/track_bloc.dart';
import 'package:music/models/lyrics_model.dart';
import 'package:music/bloc/lyrics_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:music/bloc/connectivity.dart';
import 'package:music/bloc/bookmark_bloc.dart';


const kTitleStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);
const kSubtitleStyle = TextStyle(
  color: Colors.black,
  fontSize: 22.0,
  //fontWeight: FontWeight.w200,
);

class TrackDetail extends StatefulWidget {
  final int trackId;
  final String name;
  
  TrackDetail({this.trackId,this.name});

  @override
  _TrackDetailState createState() => _TrackDetailState();
}

class _TrackDetailState extends State<TrackDetail> {
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
  
  }

  @override
  Widget build(BuildContext context) {
        if(_source.keys.toList()[0]==ConnectivityResult.none){
        return Scaffold(
          appBar: AppBar(
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        
        title:Text('Track Details',style: TextStyle(color:Colors.black),),
        ),
      body:Center(child: Text('No Internet Connection')),
        );
    }
    else{
    trackBloc.fetchTrackDetail(widget.trackId);
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:Text('Track Details',style: TextStyle(color:Colors.black),),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}),
        actions: <Widget>[
         
          IconButton(
            splashColor: Colors.blue,
            icon: Icon(Icons.bookmark,color: bookmarkColor,), 
            onPressed: (){
              setState(() {
                bookmarkColor = Colors.blue;
              });
              bookmarkBloc.addBookmark(widget.trackId,widget.name);
            }
            )

        ],
        ),
      body: ListView(
            children: [
      StreamBuilder(
          stream: trackBloc.trackDetail,
          builder: (context,AsyncSnapshot<TrackModel> snapshot){
            lyricsBloc.fetchLyrics(widget.trackId);
             if (snapshot.hasData) {
          return trackDetailView(snapshot);
            } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());

            }),
      //  Expanded(
      //                   child: 
      //  ),

            ],
          ),
    );
    }
  }
}

Widget trackDetailView(AsyncSnapshot<TrackModel> snapshot){
  String explicit = snapshot.data.explicit==1? 'True':'False';
  
  return Column(
    mainAxisSize: MainAxisSize.min,
    
    children: [
      DetailTile(title: 'Name',subtitle: snapshot.data.name,),
      DetailTile(title: 'Artist',subtitle: snapshot.data.artistName),
      DetailTile(title: 'Album Name',subtitle: snapshot.data.albumName,),
      DetailTile(title: 'Explicit',subtitle: explicit,),
      DetailTile(title: 'Rating',subtitle: snapshot.data.rating.toString(),),
      Flexible(
        
        //print('hereeeeeeeeeeeee'),
        fit: FlexFit.loose,
      child: StreamBuilder(
              stream: lyricsBloc.lyrics,
              builder: (context,AsyncSnapshot<LyricsModel> lsnapshot){
              if (lsnapshot.hasData) {
          return lyricsView(lsnapshot);
             } else if (lsnapshot.hasError) {
          return Text(lsnapshot.error.toString());
             }
             return Center(child: CircularProgressIndicator());

             }),
      ),
    ],

  );

}
Widget lyricsView(AsyncSnapshot<LyricsModel> snapshot){
    return DetailTile(title: 'Lyrics',subtitle: snapshot.data.lyrics,);

}

class DetailTile extends StatelessWidget {
  final String title;
  final String subtitle;
  DetailTile({this.title,this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: kTitleStyle,),
      subtitle: Text(subtitle,style: kSubtitleStyle,),
    );
  }
}