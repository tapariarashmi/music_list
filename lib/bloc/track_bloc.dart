import 'package:music/resources/repository.dart';
import 'package:music/models/track_model.dart';
import 'package:rxdart/rxdart.dart';

class TrackBloc{

  final _repository = Repository();

  final _trackFetcher = PublishSubject<TrackModel>();

  Stream<TrackModel> get trackDetail => _trackFetcher.stream;

  fetchTrackDetail(int trackId)async{
    TrackModel trackModel = await _repository.fetchTrackDetail(trackId);
    _trackFetcher.sink.add(trackModel);
  }

  dispose(){
    _trackFetcher.close();
  }

}
final trackBloc = TrackBloc();