class LyricsModel{
  String _lyrics;
  

  LyricsModel.fromJson(Map<String,dynamic> parsedJson){
    // message.body.lyrics.lyrics_body
  //  message.body.lyrics
    var index = parsedJson['message']['body']['lyrics'];
    _lyrics = index['lyrics_body'];
    //print(_lyrics);
  }

  String get lyrics => _lyrics;
 
}

