import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/task.dart';

class DBHelper{
  static Database? _db;
  static final int _version=1;
  static final String _tablename="task";
  static Future<void>initDb()async{
    if(_db !=null)
    {
      return ;
    }
    try {
      String _path=await getDatabasesPath()+'task.db';
      _db=await openDatabase(
          _path,
        version: _version,
        onCreate: (db,version){
            print("Creating a new one");
            return db.execute(
              "CREATE TABLE $_tablename(""id INTEGER PRIMARY Key AUTOINCREMENT,"
               "title STRING,note TEXT,date STRING,startTime STRING,endTime STRING,"
                "remind INTEGER,repeat STRING,"
                  "color INTEGER,"
                  "isCompleted INTEGER)",
            );
        }
      );
    }catch(e)
    {
      print(e);
    }
  }
  static Future<int> insert (Task? task)async{
    print("insert funtion called");
    return await _db?.insert(_tablename, task!.toJson())??1;
  }
  static Future<List<Map<String,dynamic>>>query()async
  {
    print("Query function calles");
    return await _db!.query(_tablename);
  }
  static delete(Task task)async
  {
 return await _db!.delete(_tablename,where: "id=?",whereArgs: [task.id]);
  }
  static update(int id)async
  {
    return await _db!.rawUpdate('''   
    UPDATE task
    SET isCompleted = ?
    WHERE id= ?
    ''',[1,id]);
    print("Query Run");
  }
}