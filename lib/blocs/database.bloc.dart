import 'dart:io';
import 'dart:developer';

import 'package:b/blocs/database.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseBloc extends Cubit<DatabaseState> {
  DatabaseBloc() : super(InitDatabaseState());

  get database => null;

  initDatabase() {}
}

Database? database;

Future<void> initDatabase() async {
  final databasePath = await getDatabasesPath();
  // print(databasePath);
  final path = p.join(databasePath, 'todo.db');
  if (await Directory(p.dirname(path)).exists()) {
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY, name TEXT)');
    });
    emit(LoadDatabaseState());
  } else {
    try {
      await Directory(p.dirname(path)).create(recursive: true);
      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db
            .execute('CREATE TABLE todo (id INTEGER PRIMARY KEY, name TEXT)');
      });
      emit(LoadDatabaseState());
    } catch (e) {
      log(e.toString());
    }
  }
}

void emit(LoadDatabaseState loadDatabaseState) {}
