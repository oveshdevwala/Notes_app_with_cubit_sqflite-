import 'package:notes_database_with_cubit/database/database.dart';

class NoteModel {
  // variables
  int modelId;
  String modelTitle;
  String modelDiscription;
  // constructor
  NoteModel(
      {required this.modelId,
      required this.modelTitle,
      required this.modelDiscription});
  //fromMap
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        modelId: map[DatabaseHelper.colId],
        modelTitle: map[DatabaseHelper.colTitle],
        modelDiscription: map[DatabaseHelper.colDescription]);
  }
  //toMap
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.colTitle: modelTitle,
      DatabaseHelper.colDescription: modelDiscription
    };
  }
}
