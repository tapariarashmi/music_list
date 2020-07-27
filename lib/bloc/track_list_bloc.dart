import 'package:music/resources/repository.dart';
import 'package:music/models/track_list_model.dart';
import 'package:rxdart/rxdart.dart';

class TrackListBloc{

  final _repository = Repository();

  final _trackListFetcher = PublishSubject<TrackListModel>();

  Stream<TrackListModel> get trackList => _trackListFetcher.stream;

  fetchTrackList()async{
    TrackListModel trackListModel = await _repository.fetchTrackList();
    _trackListFetcher.sink.add(trackListModel);
  }

  dispose(){
    _trackListFetcher.close();
  }

}
final bloc = TrackListBloc();