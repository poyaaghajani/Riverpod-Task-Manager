import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:task_manager/core/models/task_model.dart';

class DbHelper {
  static Future<void> createTables(sql.Database db) async {
    await db.execute(
      "CREATE TABLE todos("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title STRING, desc TEXT, date STRING, "
      "startTime STRING, endTime STRING, "
      "remind INTEGER, repeat STRING, "
      "isCompleted INTEGER)",
    );

    await db.execute(
      "CREATE TABLE user("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "isVerified INTEGER DEFAULT 0)",
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'taskmanager',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createTables(db);
      },
    );
  }

  static Future<int> createItem(TaskModel task) async {
    final db = await DbHelper.db();

    final id = await db.insert(
      "todos",
      task.toJson(),
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DbHelper.db();

    final data = {
      'id': 1,
      'isVerified': isVerified,
    };

    final id = await db.insert(
      "user",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DbHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DbHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DbHelper.db();
    return db.query('todos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem({
    required int id,
    required String title,
    required String desc,
    required int isCompleted,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    final db = await DbHelper.db();

    final data = {
      "title": title,
      "desc": desc,
      "isCompleted": isCompleted,
      "date": date,
      "startTime": startTime,
      "endTime": endTime,
    };

    final result =
        await db.update("todos", data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DbHelper.db();
    try {
      await db.delete("todos", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      debugPrint('Unable to delete $e');
    }
  }
}
