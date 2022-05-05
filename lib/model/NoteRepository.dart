import 'package:login_ui/model/Note.dart';
import 'package:sqflite/sqflite.dart';

import 'MyDatabase.dart';

class NoteRepository extends Note{

  Future<void> insertNote(Note note) async {
    //get reference to the database
    final db = await MyDatabase.database;

    //Insert the note into the correct table. you can also specify the
    //conflictAlgorithm to use in case the same note is inserted twice
    await db.insert(
        'notes',
        note.toMmap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> updateNote(Note note) async{
    //get reference to the database
    final db = await MyDatabase.database;
    //update the given note
    await db.update(
        'notes',
        note.toMmap(),
        //ensure that note has a matching id
        where: "id = ?",
        whereArgs: [note.id]
    );
  }

  Future<void> deleteNote(int id) async {
    //get a reference to the database
    final db = await MyDatabase.database;
    //remove the note
    db.delete(
        'notes',
        where: "id = ?",
        whereArgs: [id]
    );
  }

  Future<List<Note>> queryNotes() async {
    //Get a reference to the database
    final Database db = await MyDatabase.database;

    //query the table for all Notes
    final List<Map<String, dynamic>> maps = await db.query('notes');
    //convert the List<Map<String, dynamic>> into a List<Notes>
    return List.generate(maps.length, (index) {
      return Note(id: maps[index]['id'], caption: maps[index]['caption'], enteredNote: maps[index]['enteredNote']);
    });
  }
}