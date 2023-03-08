import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:pat_gest/db/patients.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'foods.dart';
import 'offices.dart';

// https://drift.simonbinder.eu/docs/getting-started/
// flutter pub run build_runner build

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'drift_database.g.dart';

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Patients, Offices, Foods])
class PatGestDatabase extends _$PatGestDatabase {
  // we tell the database where to store the data with this constructor
  PatGestDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Stream<List<Patient>> watchPatientsList() {
    return (select(patients)).watch();
  }

  Stream<Patient> watchPatient(int id) {
    return (select(patients)..where((tbl) => tbl.id.equals(id))).watchSingle();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'PatGestData', 'db.sqlite'));
    debugPrint(file.toString());
    return NativeDatabase.createInBackground(file);
  });
}
