import 'dart:async';
import 'dart:convert';
import 'package:music/models/track_list_model.dart';
import 'package:http/http.dart' as http;

class TrackListProvider{

  final _api = 'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=2e8cefda1b323c37dc336ff4b7aa4a10';

  Future<TrackListModel> fetchTrackList()async{
    print('fetched track list');
    http.Response response = await http.get(_api);
    print(response.body.toString());
    if(response.statusCode==200){
      return TrackListModel.fromJson(json.decode(response.body));
    }
    else{
      throw Exception('Failed to load track list');
    }
  }

}