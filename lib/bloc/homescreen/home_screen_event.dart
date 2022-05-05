/*
Events
The events we will need to handle in our NoteBloc are:
NoteLoadSuccess - tells the bloc that it needs to load the todos from the NoteRepository.
NoteAdded - tells the bloc that it needs to add a new todo to the list of todos.
NoteUpdated - tells the bloc that it needs to update an existing todo.
NoteDeleted - tells the bloc that it needs to remove an existing todo.
 */
import 'package:equatable/equatable.dart';
import 'package:flutter_auto_export/flutter_auto_export.dart';
import 'package:login_ui/model/Note.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
  @override
  List<Object> get props => [];
}

//we don't need to add any function in this class because we are already handling in HomeScreenState.
@AutoExporter()
class NoteLoadSuccess extends HomeScreenEvent{}

@AutoExporter()
class NoteAdded extends HomeScreenEvent{
  final Note addedNote;
  const NoteAdded({this.addedNote});

  @override
  List<Object> get props => [addedNote];

  @override
  String toString() => "Note Added {note: $addedNote}";
}

@AutoExporter()
class NoteUpdated extends HomeScreenEvent{
  final Note updatedNote;
  const NoteUpdated({this.updatedNote});

  @override
  List<Object> get props => [updatedNote];

  @override
  String toString() => "Note Updated {note: $updatedNote}";
}

@AutoExporter()
class NoteDeleted extends HomeScreenEvent{
  final Note deletedNote;
  const NoteDeleted({this.deletedNote});

  @override
  List<Object> get props => [deletedNote];

  @override
  String toString() => "Note deleted {note: $deletedNote}";
}