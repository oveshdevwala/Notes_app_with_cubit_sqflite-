import 'package:notes_database_with_cubit/database/notesModel.dart';

// class NotesState {
//   List<NoteModel> data;
//   // bool isLoading;
//   // bool isError;
//   // String erroMsg;
//   NotesState({
//     required this.data,
//     //     this.isLoading = false,
//     //     this.isError = false,
//     // this.erroMsg = ''
//   });
// }

abstract class NotesStates {}

class InitialState extends NotesStates {}

class LoadingState extends NotesStates {}

class LoadedState extends NotesStates {
 List<NoteModel> notesData;
  LoadedState({required this.notesData});
}

class ErrorState extends NotesStates {
  String errorMsg;
  ErrorState({required this.errorMsg});
}
