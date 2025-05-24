import sqlite3
from datetime import datetime

DB_NAME = "hospital.db"

def connect_db():
    return sqlite3.connect(DB_NAME)

def create_db():
    with open('hospital.sql', 'r') as f:
        sql_script = f.read()
    conn = connect_db()
    conn.executescript(sql_script)
    conn.commit()
    conn.close()
    print("Database and tables created with sample data.")

def view_patients():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT PatientID, Name, Age, Gender, Contact FROM Patients")
    patients = cursor.fetchall()
    print("\n--- Patients List ---")
    for p in patients:
        print(f"ID: {p[0]}, Name: {p[1]}, Age: {p[2]}, Gender: {p[3]}, Contact: {p[4]}")
    conn.close()

def view_doctors():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT DoctorID, Name, Specialization, Contact FROM Doctors")
    doctors = cursor.fetchall()
    print("\n--- Doctors List ---")
    for d in doctors:
        print(f"ID: {d[0]}, Name: {d[1]}, Specialization: {d[2]}, Contact: {d[3]}")
    conn.close()

def generate_bill(patient_id):
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT B.BillID, B.Amount, B.BillDate, P.Name
        FROM Billing B
        JOIN Patients P ON B.PatientID = P.PatientID
        WHERE B.PatientID = ?
        """, (patient_id,))
    bills = cursor.fetchall()
    if bills:
        print(f"\n--- Billing History for Patient ID {patient_id} ---")
        for b in bills:
            print(f"Bill ID: {b[0]}, Amount: ${b[1]:.2f}, Date: {b[2]}, Patient Name: {b[3]}")
    else:
        print(f"No billing records found for Patient ID {patient_id}")
    conn.close()

def view_prescriptions():
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT D.Name, P.Name, M.Name, Pr.Dosage, Pr.Duration
        FROM Prescriptions Pr
        JOIN Appointments A ON Pr.AppointmentID = A.AppointmentID
        JOIN Doctors D ON A.DoctorID = D.DoctorID
        JOIN Patients P ON A.PatientID = P.PatientID
        JOIN Medications M ON Pr.MedicationID = M.MedicationID
        ORDER BY D.Name
    """)
    rows = cursor.fetchall()
    print("\n--- Prescriptions List ---")
    for r in rows:
        print(f"Doctor: {r[0]}, Patient: {r[1]}, Medication: {r[2]}, Dosage: {r[3]}, Duration: {r[4]}")
    conn.close()

def export_patients_csv():
    import csv
    conn = connect_db()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM Patients")
    rows = cursor.fetchall()
    with open('patients_export.csv', 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow([desc[0] for desc in cursor.description])  # header
        writer.writerows(rows)
    conn.close()
    print("Patients data exported to patients_export.csv")

def menu():
    while True:
        print("\n--- Hospital Management System CLI ---")
        print("1. Create database and insert sample data")
        print("2. View all patients")
        print("3. View all doctors")
        print("4. Generate billing report for a patient")
        print("5. View all prescriptions")
        print("6. Export patients data to CSV")
        print("0. Exit")
        choice = input("Enter choice: ").strip()

        if choice == '1':
            create_db()
        elif choice == '2':
            view_patients()
        elif choice == '3':
            view_doctors()
        elif choice == '4':
            pid = input("Enter Patient ID: ").strip()
            if pid.isdigit():
                generate_bill(int(pid))
            else:
                print("Invalid Patient ID")
        elif choice == '5':
            view_prescriptions()
        elif choice == '6':
            export_patients_csv()
        elif choice == '0':
            print("Goodbye!")
            break
        else:
            print("Invalid choice, try again.")

if __name__ == "__main__":
    menu()
