//import 'package:music/ui/bookmark.dart';

class BookmarkListModel{
  List<BookmarkModel> _bookmarkList = [];

// TrackListModel.fromJson(Map<String,dynamic> parsedJson){
//   //message.body.track_list[0].track
//   var index = parsedJson['message']['body']['track_list'];
//   print(index.length);
//   List<_Track> temp = [];
//   for(int i=0;i<index.length;i++){
//     _Track track = _Track(index[i]['track']);
//     temp.add(track);
//   }
//   _trackList = temp;
// }

BookmarkListModel.formMapListOject(List<Map<String,dynamic>> map){
  List<BookmarkModel> temp = [];
  for(int i=0;i<map.length;i++){
    BookmarkModel bookmarkModel = BookmarkModel(map[i]);
    temp.add(bookmarkModel);
  }
  _bookmarkList = temp;

}
// insertBookmark(int trackId,String name){
//   var map = Map<String,dynamic>();
//   map['name']=name;
//   map['trackId']=trackId;
//   BookmarkModel bookmarkModel = BookmarkModel(map);
//   _bookmarkList.add(bookmarkModel);
// }

List<BookmarkModel> get bookmarkList => _bookmarkList;
}



class BookmarkModel{

  //int id;
  String _name;
  int _trackId;
  // BookmarkModel({this.name,this.trackId});

  // BookmarkModel.withId({this.id,this.name,this.trackId});
// 
  BookmarkModel(bookmarkModel){
    _name = bookmarkModel['name'];
    _trackId = bookmarkModel['trackId'];

  }

  String get name=> _name;
  int get trackId => _trackId;

  Map<String,dynamic> toMap(int id,String tname){
    var map = Map<String,dynamic>();
    // if(_id!=null)
    // map['id'] = id;

    map['trackId']=id;
    map['name']=tname;
    return map;
  } 

  // BookmarkModel.fromMapObject(Map<String,dynamic> map){
  //   this.id = map['id'];
  //   this.name = map['name'];
  //   this.trackId = map['trackId'];

  // }


}