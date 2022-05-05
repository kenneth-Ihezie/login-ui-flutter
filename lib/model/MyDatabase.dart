import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static Future<Database> database;
  Future<Database> nOpenDatabase() async {
     database = openDatabase(
      //set the path to the database. Note: Using the join function from the path
      //path package is best practice to ensure the path is correctly constructed for each platform
      join(await getDatabasesPath(), 'notes_database.db'),
      // When the database is first created, create a table to store notes.
      onCreate: (db, version){
        //Run the CREATE TABLE statement on the database
        return db.execute("CREATE TABLE notes(id INTEGER PRIMARY KEY, caption TEXT, enteredNote TEXT)");
      },
      version: 1,
    );
    return database;
  }
}
