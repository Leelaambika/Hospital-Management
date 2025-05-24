-- DROP tables if exist
DROP TABLE IF EXISTS Patients, Doctors, Departments, Appointments, Billing, Medications, Prescriptions, Rooms, Admissions, Lab_Reports;

-- Departments
CREATE TABLE Departments (
    DepartmentID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Head TEXT
);

-- Doctors
CREATE TABLE Doctors (
    DoctorID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Specialization TEXT,
    DepartmentID INTEGER,
    Contact TEXT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Patients
CREATE TABLE Patients (
    PatientID INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER,
    Gender TEXT,
    Address TEXT,
    Contact TEXT,
    EmergencyContact TEXT,
    InsuranceProvider TEXT
);

-- Rooms
CREATE TABLE Rooms (
    RoomID INTEGER PRIMARY KEY,
    RoomType TEXT,
    ChargesPerDay REAL
);

-- Admissions
CREATE TABLE Admissions (
    AdmissionID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    RoomID INTEGER,
    AdmissionDate DATE,
    DischargeDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Appointments
CREATE TABLE Appointments (
    AppointmentID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    DoctorID INTEGER,
    AppointmentDate DATE,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Medications
CREATE TABLE Medications (
    MedicationID INTEGER PRIMARY KEY,
    Name TEXT,
    Description TEXT
);

-- Prescriptions
CREATE TABLE Prescriptions (
    PrescriptionID INTEGER PRIMARY KEY,
    AppointmentID INTEGER,
    MedicationID INTEGER,
    Dosage TEXT,
    Duration TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

-- Billing
CREATE TABLE Billing (
    BillID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    AdmissionID INTEGER,
    Amount REAL,
    BillDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AdmissionID) REFERENCES Admissions(AdmissionID)
);

-- Lab Reports
CREATE TABLE Lab_Reports (
    ReportID INTEGER PRIMARY KEY,
    PatientID INTEGER,
    TestName TEXT,
    TestDate DATE,
    Result TEXT,
    DoctorID INTEGER,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Insert Data: Departments
INSERT INTO Departments VALUES
(1, 'Cardiology', 'Dr. Alice Heart'),
(2, 'Neurology', 'Dr. Brian Brain'),
(3, 'Orthopedics', 'Dr. Clara Bone'),
(4, 'Pediatrics', 'Dr. David Child'),
(5, 'General Surgery', 'Dr. Eva Cut');

-- Insert Data: Doctors
INSERT INTO Doctors VALUES
(101, 'Dr. Alice Heart', 'Cardiologist', 1, '555-1010'),
(102, 'Dr. Brian Brain', 'Neurologist', 2, '555-1020'),
(103, 'Dr. Clara Bone', 'Orthopedic Surgeon', 3, '555-1030'),
(104, 'Dr. David Child', 'Pediatrician', 4, '555-1040'),
(105, 'Dr. Eva Cut', 'General Surgeon', 5, '555-1050');

-- Insert Data: Patients
INSERT INTO Patients VALUES
(201, 'John Doe', 45, 'Male', '123 Elm St', '555-2010', 'Jane Doe (555-2020)', 'HealthPlus'),
(202, 'Mary Jane', 30, 'Female', '456 Oak St', '555-2030', 'Tom Jane (555-2040)', 'MediCare'),
(203, 'Peter Parker', 20, 'Male', '789 Pine St', '555-2050', 'May Parker (555-2060)', 'CareWell'),
(204, 'Lisa Ray', 27, 'Female', '101 Maple St', '555-2070', 'Sam Ray (555-2080)', 'HealthPlus'),
(205, 'Michael Scott', 50, 'Male', '202 Birch St', '555-2090', 'Jan Levinson (555-2100)', 'MediCare');

-- Insert Data: Rooms
INSERT INTO Rooms VALUES
(301, 'Single', 150.00),
(302, 'Double', 100.00),
(303, 'ICU', 300.00),
(304, 'Deluxe', 250.00);

-- Insert Data: Admissions
INSERT INTO Admissions VALUES
(401, 201, 301, '2025-01-10', '2025-01-20'),
(402, 202, 303, '2025-02-15', '2025-02-25'),
(403, 203, 302, '2025-03-05', '2025-03-12'),
(404, 204, 304, '2025-04-01', '2025-04-10'),
(405, 205, 301, '2025-05-12', NULL);

-- Insert Data: Appointments
INSERT INTO Appointments VALUES
(501, 201, 101, '2025-01-09', 'Chest Pain'),
(502, 202, 102, '2025-02-14', 'Headache'),
(503, 203, 103, '2025-03-04', 'Knee Pain'),
(504, 204, 104, '2025-03-31', 'Fever'),
(505, 205, 105, '2025-05-11', 'Abdominal Pain');

-- Insert Data: Medications
INSERT INTO Medications VALUES
(601, 'Aspirin', 'Pain reliever and blood thinner'),
(602, 'Metformin', 'Used to treat type 2 diabetes'),
(603, 'Lisinopril', 'Used for high blood pressure'),
(604, 'Amoxicillin', 'Antibiotic for bacterial infections'),
(605, 'Omeprazole', 'Used for acid reflux');

-- Insert Data: Prescriptions
INSERT INTO Prescriptions VALUES
(701, 501, 601, '75mg', '30 days'),
(702, 502, 604, '500mg', '10 days'),
(703, 503, 603, '10mg', '60 days'),
(704, 504, 605, '20mg', '14 days'),
(705, 505, 602, '850mg', '90 days');

-- Insert Data: Billing
INSERT INTO Billing VALUES
(801, 201, 401, 1500.00, '2025-01-21'),
(802, 202, 402, 3000.00, '2025-02-26'),
(803, 203, 403, 700.00, '2025-03-13'),
(804, 204, 404, 2250.00, '2025-04-11'),
(805, 205, 405, 0.00, '2025-05-20');

-- Insert Data: Lab Reports
INSERT INTO Lab_Reports VALUES
(901, 201, 'Blood Test', '2025-01-11', 'Normal', 101),
(902, 202, 'MRI Brain', '2025-02-16', 'No Abnormalities', 102),
(903, 203, 'X-Ray Knee', '2025-03-06', 'Minor Fracture', 103),
(904, 204, 'CBC', '2025-04-02', 'Elevated WBC', 104),
(905, 205, 'Ultrasound Abdomen', '2025-05-13', 'Normal', 105);
