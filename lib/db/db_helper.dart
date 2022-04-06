import 'package:my_to_do_app/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

//инициализация базы данных
class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "task";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("Create a new one");
          return db.execute( //создание таблицы
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, "
                "repeat STRING, "
                "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  //функция вставки
  static Future<int> insert(Task? task) async {
    print("Insert function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    //обновить таблицу
    return await _db!.rawUpdate('''  
      UPDATE task
      SET isCompleted = ?
      WHERE id = ?     
    ''', [1, id]);
  }


  //-----------
  /*static Future<int> update_my_task(Task? task) async {
    print("update_my_task function called");
    return await _db!.rawUpdate('''
      UPDATE task
      SET id = ?, title =?, note = ?, date = ?, startTime = ?, repeat  =?, isCompleted = ?
      WHERE id = ?     
    ''', [1, task!.id]);*/
   // return await _db?.update(_tableName, task!.toJson()) ?? 1;

  static update_my_task(String title, String note, String date, String repeat, String startTime, int id) async {
    print("update_my_task function called");
    return await _db!.rawUpdate('''
      UPDATE task
      SET title =?, note = ?, date = ?, repeat  =?, startTime = ?, isCompleted = ?
      WHERE id = ?     
    ''', [title, note, date, repeat, startTime, 0, id]);
  }


}