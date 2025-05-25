-- Drop existing tables
DROP TABLE IF EXISTS Prescriptions;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Medications;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;

-- Create tables
CREATE TABLE Patients (
    PatientID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER,
    Gender TEXT,
    Contact TEXT
);

CREATE TABLE Doctors (
    DoctorID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Specialization TEXT,
    Contact TEXT
);

CREATE TABLE Medications (
    MedicationID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Description TEXT
);

CREATE TABLE Appointments (
    AppointmentID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    DoctorID INTEGER,
    AppointmentDate TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Billing (
    BillID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    Amount REAL,
    BillDate TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INTEGER PRIMARY KEY,
    AppointmentID INTEGER,
    MedicationID INTEGER,
    Dosage TEXT,
    Duration TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- Insert sample Patients
INSERT INTO Patients VALUES
(1, 'John Doe', 35, 'Male', '999-123-4567'),
(2, 'Jane Smith', 29, 'Female', '999-987-6543'),
(3, 'Alice Johnson', 42, 'Female', '999-456-7890'),
(4, 'Robert Brown', 50, 'Male', '999-654-3210'),
(5, 'Emily Davis', 31, 'Female', '999-321-9876');

-- Insert sample Doctors
INSERT INTO Doctors VALUES
(1, 'Dr. Gregory House', 'Diagnostics', '123-111-2222'),
(2, 'Dr. Meredith Grey', 'Surgery', '123-222-3333'),
(3, 'Dr. John Watson', 'General Medicine', '123-333-4444');

-- Insert sample Medications
INSERT INTO Medications VALUES
(1, 'Paracetamol', 'Pain reliever and fever reducer'),
(2, 'Amoxicillin', 'Antibiotic for bacterial infections'),
(3, 'Ibuprofen', 'Anti-inflammatory drug');

-- Insert Appointments
INSERT INTO Appointments VALUES
(1, 1, 1, '2025-05-10'),
(2, 2, 2, '2025-05-11'),
(3, 3, 3, '2025-05-12'),
(4, 4, 1, '2025-05-13'),
(5, 5, 2, '2025-05-14');

-- Insert Billing
INSERT INTO Billing VALUES
(1, 1, 500.0, '2025-05-10'),
(2, 2, 750.0, '2025-05-11'),
(3, 3, 600.0, '2025-05-12'),
(4, 4, 900.0, '2025-05-13'),
(5, 5, 700.0, '2025-05-14');

-- Insert Prescriptions
INSERT INTO Prescriptions VALUES
(1, 1, 1, '500mg', '5 days'),
(2, 2, 2, '250mg', '7 days'),
(3, 3, 3, '400mg', '3 days'),
(4, 4, 1, '500mg', '5 days'),
(5, 5, 2, '250mg', '10 days');
