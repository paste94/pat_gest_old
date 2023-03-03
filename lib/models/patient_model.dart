class PatientModel {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String note;

  PatientModel(
    this.id,
    this.name,
    this.surname,
    this.email,
    this.phoneNumber,
    this.note,
  );

  PatientModel.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        surname = map[surnameColumn] as String,
        email = map[emailColumn] as String,
        phoneNumber = map[phoneNumberColumn] as String,
        note = map[noteColumn] as String;

  @override
  String toString() =>
      'Person, ID = $id, name = $name, surname = $surname, email = $email, phoneNumber = $phoneNumber, note = $note';

  @override
  bool operator ==(covariant PatientModel other);

  @override
  int get hashCode => id.hashCode;
}

const idColumn = 'id';
const nameColumn = 'name';
const surnameColumn = 'surname';
const emailColumn = 'mail';
const phoneNumberColumn = 'phone_number';
const noteColumn = 'note';
