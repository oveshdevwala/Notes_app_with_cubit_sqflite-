import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/database/database.dart';
import 'package:notes_database_with_cubit/database/notesModel.dart';

class notescubit extends Cubit<NotesState> {
  notescubit() : super(NotesState(data: []));
  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();
  DatabaseHelper db = DatabaseHelper.instance;
  bool _isUpdate = false;
  set isupdate(value) => _isUpdate = value;
  get isupdate => _isUpdate;
  Future<void> facthdatas() async {
    emit(NotesState(data: await db.facthData()));
  }


  Future updatedata(index) async {
    titleController.text = state.data[index].modelTitle;
    discController.text = state.data[index].modelDiscription;
  }

  Future creates(index) async {
    if (titleController.text.isNotEmpty && discController.text.isNotEmpty) {
      if (isupdate == false) {
        NoteModel newNotess = NoteModel(
            modelDiscription: discController.text.toString(),
            modelId: 0,
            modelTitle: titleController.text.toString());
        db.createNotes(newNotess);
        emit(NotesState(data: await db.facthData()));
        titleController.clear();
        discController.clear();
      } else if (isupdate == true) {
        print('I m update notes');
        NoteModel update = NoteModel(
            modelDiscription: discController.text.toString(),
            modelId: state.data[index].modelId,
            modelTitle: titleController.text.toString());

        db.update(update);
        emit(NotesState(data: await db.facthData()));
        // print('I m emit');
      }
    }
  }
  
  Future delete(int index) async {
    db.delete(state.data[index].modelId, );
    emit(NotesState(data: await db.facthData()));
  }
}
