import 'package:drift/drift.dart';
import 'package:pat_gest/db/drift_database.dart';
import 'package:pat_gest/services/crud_exceptions.dart';

class CrudService {
  static final CrudService _instance = CrudService._internal();

  PatGestDatabase? _db;

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory CrudService() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  CrudService._internal();

  PatGestDatabase _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseOpeningError();
    }
    return db;
  }

  Stream<List<Patient>> getPatientsListStream() {
    final db = _getDatabaseOrThrow();
    return db.watchPatientsList();
  }

  Stream<Patient> getPatientStream({required int id}) {
    final db = _getDatabaseOrThrow();
    return db.watchPatient(id);
  }

  Future<void> open() async {
    _db ??= PatGestDatabase();
  }

  Future<int> createPatient({
    required String surname,
    required String name,
    required double height,
    required double initialWeight,
    required DateTime dateOfBirth,
    String? email,
    String? phoneNumber,
    String? notes,
  }) async {
    final db = _getDatabaseOrThrow();
    return await db.into(db.patients).insert(PatientsCompanion(
          name: Value(name),
          surname: Value(surname),
          email: Value.ofNullable(email),
          phoneNumber: Value.ofNullable(phoneNumber),
          notes: Value.ofNullable(notes),
          height: Value(height),
          initialWeight: Value(initialWeight),
          dateOfBirth: Value(dateOfBirth),
        ));
  }
}
