import 'package:music/database/database.dart';
import 'package:music/models/bookmark_model.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkDao{

  DatabaseHelper databaseHelper = DatabaseHelper.databaseHelper;

  Future<int> insertData(int trackId,String name)async{
    var map = Map<String,dynamic>();
    map['trackId']=trackId;
    map['name']=name;
    print('inserted');
    Database db = await databaseHelper.database;
    int result = await db.insert(tableName, map);
    print(result);
    return result;
  }

  Future<List<Map<String,dynamic>>> getBookmarkMapList() async{
    Database db = await databaseHelper.database;
    var result = await db.query(tableName);
    //print(result);
    return result;
  
  }

  Future<int> deleteBookmark(int trackId)async{
    Database db = await databaseHelper.database;
    var result = await db.rawDelete('DELETE FROM $tableName WHERE trackId = $trackId');
    print(result);
    return result;
  }

  Future<BookmarkListModel> getBookmarkList() async{
    print('list fetched');
    var bookmarkMapList = await getBookmarkMapList();
    return BookmarkListModel.formMapListOject(bookmarkMapList);
    // int count = bookmarkMapList.length;
    // List<BookmarkModel> bookmarkList = List<BookmarkModel>();
    // for(int i=0;i<count;i++){
    //   bookmarkList.add(BookmarkModel.fromMapObject(bookmarkMapList[i]));
    // }
    

  }



}