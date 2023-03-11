class OfficeModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String email;
  final String address;

  OfficeModel(
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.address,
  );

  OfficeModel.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        phoneNumber = map[phoneNumberColumn] as String,
        email = map[emailColumn] as String,
        address = map[addressColumn] as String;

  @override
  String toString() =>
      'Person, ID = $id, name = $name, phoneNumber = $phoneNumber, email = $email, address = $address ';

  @override
  bool operator ==(covariant OfficeModel other);

  @override
  int get hashCode => id.hashCode;
}

const idColumn = 'id';
const nameColumn = 'name';
const phoneNumberColumn = 'phone_number';
const emailColumn = 'email';
const addressColumn = 'address';
