import 'package:equatable/equatable.dart';
import 'package:flutter_auto_export/flutter_auto_export.dart';
import 'package:login_ui/model/Note.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

@AutoExporter()
class OnNotesLoading extends HomeScreenState{}

@AutoExporter()
class OnNotesLoadedSuccessfully extends HomeScreenState{
  final List<Note> notes;
  const OnNotesLoadedSuccessfully([this.notes = const []]);

  @override
  List<Object> get props => [notes];

  @override
  String toString() => "notes: $notes";
}

@AutoExporter()
class OnNotesLoadFaliure extends HomeScreenState{}