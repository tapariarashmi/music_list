import 'package:music/resources/repository.dart';
import 'package:music/models/lyrics_model.dart';
import 'package:rxdart/rxdart.dart';

class LyricsBloc{

  final _repository = Repository();

  final _lyricsFetcher = PublishSubject<LyricsModel>();

  Stream<LyricsModel> get lyrics => _lyricsFetcher.stream;

  fetchLyrics(int trackId)async{
    LyricsModel lyricsModel = await _repository.fetchLyrics(trackId);
    _lyricsFetcher.sink.add(lyricsModel);
  }

  dispose(){
    _lyricsFetcher.close();
  }

}
final lyricsBloc = LyricsBloc();