import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/model/Note.dart';

TextEditingController updateNoteEditingController;
TextEditingController updateCaptionEditingController;
int id;

class UpdateNoteScreen extends StatefulWidget {
  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  bool _buttonState = false;
  Widget _actionBarButton = Icon(
    Icons.check,
    color: Colors.blueAccent[400],
  );
  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note Gallery"),
        actions: [_actionBarButton],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: updateCaptionEditingController,
              onChanged: (String text) {
                setState(() {
                  updateCaptionEditingController.text;
                });
              },
              decoration: InputDecoration(hintText: "Caption"),
            ),
            Padding(padding: EdgeInsets.only(top: 16.0)),
            TextField(
              controller: updateNoteEditingController,
              onChanged: (String text) {
                setState(() {
                  updateNoteEditingController.text;
                  if (text.length > 0) {
                    _buttonState = true;
                    _actionBarButton = IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: _buttonState ? () =>   _updateNote(id, updateCaptionEditingController.text, updateNoteEditingController.text) : null,
                    );
                  } else {
                    _actionBarButton = Icon(
                      Icons.hourglass_empty,
                      color: Colors.white,
                    );
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "Note something down",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }

  _updateNote(id, caption, note){
   /* var noteUpdate = Note(id: id, caption: caption, enteredNote: note);
    noteUpdate.updateNote(noteUpdate);
    Navigator.of(context).pushNamed('/homeScreen');*/
  }
}
