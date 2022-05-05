import 'package:login_ui/model/MyDatabase.dart';

class Note extends MyDatabase{
  final String enteredNote;
  final String caption;
  final int id;
  Note({this.id, this.caption, this.enteredNote});
  //convert the note to map
  Map<String, dynamic> toMmap(){
    return {
      'id': id,
      'caption':caption,
      'enteredNote':enteredNote
    };
  }
    @override
    String toString(){
      return 'Note{id: $id, caption: $caption, enteredNote: $enteredNote}';
    }
}