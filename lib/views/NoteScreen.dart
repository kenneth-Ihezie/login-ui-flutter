import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/model/Note.dart';
import 'package:flutter/services.dart';

class NoteScreen extends StatefulWidget {
  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  var noteEditingController = TextEditingController();
  var captionEditingController = TextEditingController();
  bool _buttonState = false;
  Widget _actionBarButton = Icon(
    Icons.check,
    color: Colors.blueAccent[400],
  );
  int autoId;
  //platform specific code to open camera in android
  //The client and host sides of a channel are connected through a channel
  // name passed in the channel constructor.
  // All channel names used in a single app must be unique;
  // prefix the channel name with a unique ‘domain prefix’,
  //samples.flutter.dev/camera
  static const platform = const MethodChannel('samples.flutter.dev/camera');
  //Next, invoke a method on the method channel, specifying the concrete method
  // to call using the String identifier startCamera.
  // The call might fail—for example if the platform does not support the
  // platform API (such as when running in a simulator)—so wrap the
  // invokeMethod call in a try-catch statement.
  var image = "images/img.jpeg";
  String imageIn;
  Future<void> _startCamera() async{
    try{
      imageIn = await platform.invokeMethod('startCamera');
      print(imageIn);
  } on PlatformException catch(e){
      "failed to start camera ${e.message}";
    }

    setState(() {
      image = imageIn;
    });
}
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
              controller: captionEditingController,
              onChanged: (String text) {
                setState(() {
                  captionEditingController.text;
                });
              },
              decoration: InputDecoration(hintText: "Caption"),
            ),
            Padding(padding: EdgeInsets.only(top: 16.0)),
            TextField(
              controller: noteEditingController,
              minLines: 2,
              maxLines: 10,
              onChanged: (String text) {
                setState(() {
                  noteEditingController.text;
                  if (text.length > 0) {
                    _buttonState = true;
                    _actionBarButton = IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      onPressed: _buttonState ? () =>   insertNote(_autoIncrementId, autoId, captionEditingController.text, noteEditingController.text) : null,
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

            Image(
              image: AssetImage(image),
              width: 150,
              height: 200,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startCamera,
        child: Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }

  Future<void> _autoIncrementId() async{
   /* var list = await Note().queryNotes();
    autoId = list.last.id;
    setState(() {
      autoId++;
    });*/
  }

   Future<void> insertNote(_autoIncrementId(), id, caption, note) async {
    /*var noteEnter = Note(id: id, caption: caption, enteredNote: note);
    noteEnter.insertNote(noteEnter);
    print(await Note().queryNotes());
    Navigator.of(context).pushNamed('/homeScreen');*/
  }
}


