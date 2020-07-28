import 'package:music/resources/repository.dart';
import 'package:music/models/bookmark_model.dart';
import 'package:rxdart/rxdart.dart';

class BookmarkBloc{

  final _repository = Repository();

  final _bookmarkListFetcher = PublishSubject<BookmarkListModel>();

  Stream<BookmarkListModel> get bookmarkList => _bookmarkListFetcher.stream;

  fetchBookmarkList()async{
    _bookmarkListFetcher.add(await _repository.getBookmarkList());

  }

  addBookmark(int trackId,String name)async{
    await _repository.insertBookmark(trackId,name);
    //fetchBookmarkList();
  }

  deleteBookmark(int trackId)async{
    await _repository.deleteBookmark(trackId);
    fetchBookmarkList();
  }

  dispose(){
    _bookmarkListFetcher.close();
  }

}
final bookmarkBloc = BookmarkBloc();