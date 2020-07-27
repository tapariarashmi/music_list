import 'dart:async';
import 'dart:convert';
import 'package:music/models/track_model.dart';
import 'package:http/http.dart' as http;

class TrackProvider{
  //final int trackId;
  final apiKey = '2e8cefda1b323c37dc336ff4b7aa4a10';

  Future<TrackModel> fetchTrackDetail(int trackId)async{
    print('fetched track details');
    print(trackId);
    http.Response response = await http.get('https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackId&apikey=$apiKey');
    print(response.body.toString());
    if(response.statusCode==200){
      return TrackModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load track list');
    }
  }

}