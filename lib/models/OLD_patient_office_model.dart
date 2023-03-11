class PatientOfficeModel {
  final int id;
  final int patientId;
  final int officeId;

  PatientOfficeModel(
    this.id,
    this.patientId,
    this.officeId,
  );

  PatientOfficeModel.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        patientId = map[patientIdColumn] as int,
        officeId = map[officeIdColumn] as int;

  @override
  String toString() =>
      'Person, ID = $id, patientId = $patientId, officeId = $officeId';

  @override
  bool operator ==(covariant PatientOfficeModel other);

  @override
  int get hashCode => id.hashCode;
}

const idColumn = 'id';
const patientIdColumn = 'patient_id';
const officeIdColumn = 'office_id';
