-- 1. Index on Appointments date and status for fast date-range filtering
CREATE INDEX idx_appointment_date_status ON Appointments(appointment_date, status);

-- 2. Index on Doctors specialization for fast filtering by medical department
CREATE INDEX idx_doctor_specialization ON Doctors(specialization);

-- 3. Index on foreign keys to optimize multi-table join performance
CREATE INDEX idx_appointment_patient ON Appointments(patient_id);
CREATE INDEX idx_appointment_doctor ON Appointments(doctor_id);
