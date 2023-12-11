import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_database_with_cubit/cubit/noteState.dart';
import 'package:notes_database_with_cubit/database/database.dart';
import 'package:notes_database_with_cubit/database/notesModel.dart';

class NoteCubit extends Cubit<NotesStates> {
  DatabaseHelper db;
  NoteCubit({required this.db}) : super(InitialState());

  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();
  bool isUpdate = false;
  //events
  //addNotes
  // void addNotes(int id) async {
  //   if (isUpdate == false) {
  //     createNotes();
  //   } else {
  //     updateNotes(id);
  //   }
  // }

  void addNotes() async {
    var notemodel = await NoteModel(
        modelId: 0,
        modelTitle: titleController.text.toString(),
        modelDiscription: discController.text.toString());
    emit(LoadingState());
    var check = await db.createNotes(notemodel);
    if (check) {
      List<NoteModel> arrNotes = await db.facthData();
      emit(LoadedState(notesData: arrNotes));
    } else {
      emit(ErrorState(errorMsg: "Notes Not Added!!!"));
    }
    titleController.clear();
    discController.clear();
  }

  void updateNotes(int id) async {
    var notesmodel = await NoteModel(
        modelId: id,
        modelTitle: titleController.text.toString(),
        modelDiscription: discController.text.toString());
    emit(LoadingState());
    var check = await db.update(notesmodel);
    if (check) {
      List<NoteModel> arrNotes = await db.facthData();
      emit(LoadedState(notesData: arrNotes));
    } else {
      emit(ErrorState(errorMsg: 'Note Not Delet'));
    }
    titleController.clear();
    discController.clear();
  }

  void getAllNotes() async {
    emit(LoadingState());
    List<NoteModel> arrNotes = await db.facthData();
    emit(LoadedState(notesData: arrNotes));
  }

  void deleteNotes(int id) async {
    emit(LoadingState());
    Timer(Duration(milliseconds: 500), () async {
      var check = await db.delete(id);
      if (check) {
        List<NoteModel> arrydata = await db.facthData();
        emit(LoadedState(notesData: arrydata));
      } else {
        emit(ErrorState(errorMsg: 'Notes Not Deleted'));
      }
    });
  }
}








// class notescubit extends Cubit<NotesState> {
//   notescubit() : super(NotesState(data: []));
//   TextEditingController titleController = TextEditingController();
//   TextEditingController discController = TextEditingController();
//   DatabaseHelper db = DatabaseHelper.instance;
//   bool _isUpdate = false;
//   set isupdate(value) => _isUpdate = value;
//   get isupdate => _isUpdate;
//   Future<void> facthdatas() async {
//     emit(NotesState(data: await db.facthData()));
//   }

//   Future deletes(int index) async {
//     db.delete(state.data[index].modelId);
//     emit(NotesState(data: await db.facthData()));
//   }

//   Future updatedata(index) async {
//     titleController.text = state.data[index].modelTitle;
//     discController.text = state.data[index].modelDiscription;
//   }

//   Future creates(index) async {
//     if (titleController.text.isNotEmpty && discController.text.isNotEmpty) {
//       if (isupdate == false) {
//         NoteModel newNotess = NoteModel(
//             modelDiscription: discController.text.toString(),
//             modelId: 0,
//             modelTitle: titleController.text.toString());
//         db.createNotes(newNotess);
//         emit(NotesState(data: await db.facthData()));
//         titleController.clear();
//         discController.clear();
//       } else if (isupdate == true) {
//         print('I m update notes');
//         NoteModel update = NoteModel(
//             modelDiscription: discController.text.toString(),
//             modelId: state.data[index].modelId,
//             modelTitle: titleController.text.toString());

//         db.update(update);
//         emit(NotesState(data: await db.facthData()));
//         // print('I m emit');
//       }
//     }
//   }
// }
