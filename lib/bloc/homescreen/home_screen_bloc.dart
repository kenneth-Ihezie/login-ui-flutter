import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_ui/bloc/homescreen/home_screen_event.dart';
import 'package:login_ui/bloc/homescreen/home_screen_state.dart';
import 'package:login_ui/model/Note.dart';
import 'package:login_ui/model/NoteRepository.dart';

/*Our HomeScreenBloc will have a dependency in NoteRepository*/
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState>{
  final NoteRepository repository;
  //we will set the initial state of our application to OnNotesLoading
  HomeScreenBloc({@required this.repository}) : super(OnNotesLoading());

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if(event is NoteLoadSuccess){
      yield* _mapNotesLoadedToState();
    } else if(event is NoteAdded){
      yield* _mapNoteAddedToState(event);
    } else if(event is NoteUpdated){
      yield* _mapNoteUpdatedToState(event);
    } else if(event is NoteDeleted){
      yield* _mapNoteDeleteToState(event);
    }
  }

  Stream<HomeScreenState> _mapNotesLoadedToState() async* {
    try{
      final notes = await this.repository.queryNotes();
      yield OnNotesLoadedSuccessfully(notes);
    } catch (_){
      yield OnNotesLoadFaliure();
    }
  }

  Stream<HomeScreenState> _mapNoteAddedToState(NoteAdded event) async* {
    //check if notes loaded successfully
    if(state is OnNotesLoadedSuccessfully){
       final List<Note> addedNotes = ((state as OnNotesLoadedSuccessfully).notes)
       ..add(event.addedNote);
       yield OnNotesLoadedSuccessfully(addedNotes);
       //add note to sqflite database
       _saveNotes(event.addedNote);
    }
  }

  Stream<HomeScreenState> _mapNoteUpdatedToState(NoteUpdated event) async* {
    //check if notes loaded successfully
    if(state is OnNotesLoadedSuccessfully){
      final List<Note> updatedNotes = (state as OnNotesLoadedSuccessfully).notes
          .map((note) {
            //update note here to sqflite database
        _updateNotes(note.id == event.updatedNote.id ? event.updatedNote : note);
        return note.id == event.updatedNote.id ? event.updatedNote : note;
      }).toList();
      yield OnNotesLoadedSuccessfully(updatedNotes);
    }
  }

  Stream<HomeScreenState> _mapNoteDeleteToState(NoteDeleted event) async* {
    if(state is OnNotesLoadedSuccessfully){
      final deleteNote = (state as OnNotesLoadedSuccessfully).notes
          .where((note) => note.id == event.deletedNote.id).toList();
      yield OnNotesLoadedSuccessfully(deleteNote);
      _deleteNote(event.deletedNote.id);
    }
  }

  Future<void> _saveNotes(Note notes){
     return this.repository.insertNote(notes);
  }

  Future<void> _updateNotes(Note note){
    return this.repository.updateNote(note);
  }

  Future<void> _deleteNote(int id){
    return this.repository.deleteNote(id);
  }
}