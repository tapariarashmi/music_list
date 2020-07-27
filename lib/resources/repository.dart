import 'package:music/resources/track_provider.dart';

import 'track_list_provider.dart';
import 'package:music/models/track_list_model.dart';
import 'package:music/models/track_model.dart';
import 'package:music/models/lyrics_model.dart';
import 'track_provider.dart';
import 'lyrics_provider.dart';
import 'package:music/models/bookmark_model.dart';
import 'package:music/dao/bookmark_dao.dart';

class Repository{
  
  TrackListProvider trackListProvider = TrackListProvider();
  Future<TrackListModel> fetchTrackList() => trackListProvider.fetchTrackList();

  TrackProvider trackProvider = TrackProvider();
  Future<TrackModel> fetchTrackDetail(int trackId) => trackProvider.fetchTrackDetail(trackId);

  LyricsProvider lyricsProvider = LyricsProvider();
  Future<LyricsModel> fetchLyrics(int trackId) => lyricsProvider.fetchLyrics(trackId);

  BookmarkDao bookmarkDao = BookmarkDao();
  Future<int> insertBookmark(int trackId,String name) => bookmarkDao.insertData(trackId,name);

  Future<BookmarkListModel> getBookmarkList() => bookmarkDao.getBookmarkList();

}