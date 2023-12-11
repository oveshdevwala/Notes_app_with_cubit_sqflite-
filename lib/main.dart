import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/notescubit.dart';
import 'package:notes_database_with_cubit/database/database.dart';
import 'package:notes_database_with_cubit/screens/homeNotes.dart';
// import 'package:notes_database_with_cubit/screens/AddNote.dart';
// import 'package:notes_database_with_cubit/screens/homeNotes.dart';
// import 'package:notes_database_with_cubit/screens/notesView.dart';
// import 'package:notes_database_with_cubit/screens/viewhomeNotes.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NoteCubit(db: DatabaseHelper.instance))], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: HomeNotesGrid(),
    );
  }
}
