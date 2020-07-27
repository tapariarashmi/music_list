import 'dart:async';
import 'dart:convert';
import 'package:music/models/lyrics_model.dart';
import 'package:http/http.dart' as http;

class LyricsProvider{
  //final int trackId;
  final apiKey = '2e8cefda1b323c37dc336ff4b7aa4a10';

  Future<LyricsModel> fetchLyrics(int trackId)async{
    print('fetched lyrics');
    print(trackId);
    http.Response response = await http.get('https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$apiKey');
    print(response.body.toString());
    if(response.statusCode==200){
      return LyricsModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load track list');
    }
  }

}