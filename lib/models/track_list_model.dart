class TrackListModel{

List<_Track> _trackList = [];

TrackListModel.fromJson(Map<String,dynamic> parsedJson){
  //message.body.track_list[0].track
  var index = parsedJson['message']['body']['track_list'];
  print(index.length);
  List<_Track> temp = [];
  for(int i=0;i<index.length;i++){
    _Track track = _Track(index[i]['track']);
    temp.add(track);
  }
  _trackList = temp;
}

List<_Track> get trackList => _trackList;

}

class _Track{
  String _trackName;
  String _albumName;
  String _artistName;
  int _id;

  _Track(track){
    _trackName = track['track_name'];
    _albumName = track['album_name'];
    _artistName = track['artist_name'];
    _id = track['track_id'];
  }

  String get trackName =>_trackName;
  String get albumName =>_albumName;
  String get artistName =>_artistName;
  int get id => _id;
}