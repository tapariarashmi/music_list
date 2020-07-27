class TrackModel{
  String _name;
  String _artistName;
  String _albumName;
  int _explicit;
  int _rating;

  TrackModel.fromJson(Map<String,dynamic> parsedJson){
   // message.body.track
    var index = parsedJson['message']['body']['track'];
    _name = index['track_name'];
    _artistName = index['artist_name'];
    _albumName = index['album_name'];
    _explicit = index['explicit'];
    _rating = index['track_rating'];
  }

  String get name => _name;
  String get artistName => _artistName;
  String get albumName => _albumName;
  int get explicit => _explicit;
  int get rating => _rating;
}

