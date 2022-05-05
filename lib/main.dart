import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_ui/bloc/bloc_observer.dart';
import 'package:login_ui/bloc/homescreen/home_screen_bloc.dart';
import 'package:login_ui/bloc/homescreen/home_screen_event.dart';
import 'package:login_ui/model/MyDatabase.dart';
import 'package:login_ui/model/NoteRepository.dart';
import 'package:path/path.dart';
import 'ApplicationState/MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyDatabase().nOpenDatabase();
  Bloc.observer = MyBlocObserver();
 /* runApp(BlocProvider(
      create: (context) {
        return HomeScreenBloc(repository: NoteRepository())
          ..add(NoteLoadSuccess());
      },
      child: MyApp()));*/
  runApp(MyApp());
}
