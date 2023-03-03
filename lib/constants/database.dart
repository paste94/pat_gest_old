const dbName = 'pat_gest.db';
const databasePath = 'C:\\PatGest_data\\';

const createPatientQuery = '''
  CREATE TABLE IF NOT EXISTS Patient (
    id INTEGER NOT NULL, 
    name TEXT, 
    surname TEXT, 
    mail TEXT, 
    phone_number TEXT, 
    note TEXT, 
    PRIMARY KEY("ID" AUTOINCREMENT)
  );
''';

const createOfficeQuery = '''
  CREATE TABLE IF NOT EXISTS Office (
    id INTEGER NOT NULL, 
    name TEXT,
    phone_number TEXT,
    email TEXT,
    address TEXT,
    PRIMARY KEY("ID" AUTOINCREMENT)
  );
''';

const createPatientOfficeQuery = '''
  CREATE TABLE IF NOT EXISTS Patient_Office (
    id INTEGER NOT NULL, 
    patient_id INTEGER NOT NULL,
    office_id INTEGER NOT NULL,
    PRIMARY KEY("ID" AUTOINCREMENT),
    FOREIGN KEY(patient_id) REFERENCES Patient(ID),
    FOREIGN KEY(office_id) REFERENCES Office(ID)
  );
''';
