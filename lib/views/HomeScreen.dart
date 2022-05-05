import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_ui/bloc/homescreen/home_screen_bloc.dart';
import 'package:login_ui/bloc/homescreen/home_screen_event.dart';
import 'package:login_ui/bloc/homescreen/home_screen_state.dart';
import 'package:login_ui/model/Note.dart';
import 'package:login_ui/views/UpdateNoteScreen.dart';


String userName;
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final note = Note();
  bool _trackButtonState = false;
  Widget _actionBarButton = Icon(
    Icons.delete,
    color: Colors.blueAccent[400],
  );
  List<Note> list = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text("Home Screen"),
            actions: [_actionBarButton],
          ),
          body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text("Welcome " + userName),
                  Flexible(
                    child: _myListBuilder(state),
                  ),
                ],
              )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToNoteScreen,
            child: Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  _navigateToNoteScreen(){
    Navigator.of(context).pushNamed('/noteScreen');
  }
  Future<void> _noteList(state) async {
    BlocProvider.of(context).add(NoteLoadSuccess());
    list = (state as OnNotesLoadedSuccessfully).notes;
     //list = await Note().queryNotes();
    setState(() {
      list;
    });
  }

  Widget _myListBuilder(state){
    _noteList(state);
    return ListView.builder(
      reverse: false,
      itemCount: list.length,
      itemBuilder: (context, index){
        final item = list[index];
        return Card(
          child: ListTile(
            title: Text(item.caption),
            subtitle: Text(item.enteredNote),
            onTap: () { //                                  <-- onTap
              setState(() {
                _navigateToUpdate(item);
              });
            },
            onLongPress: () { //                            <-- onLongPress
              setState(() {
                   _trackButtonState = true;
                  _actionBarButton = IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,),
                    onPressed: _trackButtonState ? () => _deleteNote(item.id) : null
                  );
              });
            },

          ),
        );
      },
    );
  }

  _navigateToUpdate(Note item){
    setState(() {
      Navigator.of(context).pushNamed('/updateNoteScreen');
      updateCaptionEditingController = TextEditingController();
      updateNoteEditingController = TextEditingController();
      updateCaptionEditingController.text = item.caption;
      updateNoteEditingController.text = item.enteredNote;
      id = item.id;
    });
  }

  _deleteNote(id) async{
    //BlocProvider.of(context).add(NoteDeleted())
    //await Note().deleteNote(id);
  }
}
