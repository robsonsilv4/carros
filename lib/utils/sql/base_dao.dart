import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';
import 'entity.dart';

abstract class BaseDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  String get tableName;

  T fromJson(Map<String, dynamic> map);

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<T>> query(String sql, [List<dynamic> arguments]) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(sql);

    return list.map<T>((json) => fromJson(json)).toList();
  }

  Future<List<T>> findAll() {
    return query('select * from $tableName');
  }

  Future<T> findById(int id) async {
    final list = await query('select * from $tableName where id = ?', [id]);
    return list.length > 0 ? list.first : null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('delete from $tableName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }
}
