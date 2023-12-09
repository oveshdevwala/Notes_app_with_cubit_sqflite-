import 'package:notes_database_with_cubit/database/notesModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //variables
  static const dbName = 'notes.db';
  static const dbVersion = 1;
  static const dbTable = 'noetsTable';
  //col
  static const colId = 'id';
  static const colTitle = 'title';
  static const colDescription = 'description';

  //constructor
  DatabaseHelper._();
static  DatabaseHelper instance = DatabaseHelper._();

  // get Db
  Database? db;
  Future<Database> getDb() async {
    db ??= await inilDb();
    return db!;
  }

  //inil Database
  Future<Database> inilDb() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, dbName);
    _oncreate(Database db, int version) {
      var autoIncrement = 'integer primary key autoincrement not null';
      var stringType = 'text not null';
      // var intType = 'integer not null';
      db.execute('''
CREATE TABLE $dbTable(
  $colId $autoIncrement,
  $colTitle $stringType,
  $colDescription $stringType
) ''');
    }

    return await openDatabase(path, version: dbVersion, onCreate: _oncreate);
  }

  void createNotes(NoteModel model) async {
    var db = await getDb();
    db.insert(dbTable, model.toMap());
    facthData();
  }

  Future<List<NoteModel>> facthData() async {
    var db = await getDb();
    var data = await db.query(dbTable);

    List<NoteModel> arryData = [];

    for (Map<String, dynamic> eachData in data) {
      var notesmodel = NoteModel.fromMap(eachData);
      arryData.add(notesmodel);
    }
    return arryData;
  }

  delete(int id) async {
    var db = await getDb();
    db.delete(dbTable, where: '$colId = ?', whereArgs: ['$id']);
    facthData();
  }

  update(NoteModel notesmodel) async {
    var db = await getDb();
    db.update(dbTable, notesmodel.toMap(),
        where: '$colId = ?', whereArgs: ['${notesmodel.modelId}']);
    facthData();
  }
}
