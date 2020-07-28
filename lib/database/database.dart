import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
String tableName = 'BookmarkTable';

class DatabaseHelper{
  static DatabaseHelper databaseHelper = DatabaseHelper();
  static Database _database;
  

  Future<Database> get database async{

    if(_database == null){
      _database = await initialiseDatabase();
    }
    return _database;

  }

  Future<Database> initialiseDatabase()async{
    print('database initialised');
      return openDatabase(
        join(await getDatabasesPath(),'bookmark.db'),
        onCreate: (db,version)async{
          db.execute(
            ''' CREATE TABLE $tableName(
              trackId INTEGER PRIMARY KEY ,name STRING
            )'''
          );
        },
        version: 1,
      );
  }

  

}