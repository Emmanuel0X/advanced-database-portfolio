USE ardeliah_clinical_db;

-- Query 1: Comprehensive Patient Medical History
-- Retrieves all past visits, diagnoses, prescriptions, and lab tests for a specific patient.
SELECT 
    p.patient_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    m.visit_date,
    CONCAT(d.first_name, ' ', d.last_name) AS attending_doctor,
    d.specialization,
    m.symptoms,
    m.diagnosis,
    pr.medication_name,
    pr.dosage,
    lt.test_name,
    lt.test_status,
    lt.results
FROM Patients p
JOIN Medical_Records m ON p.patient_id = m.patient_id
JOIN Doctors d ON m.doctor_id = d.doctor_id
LEFT JOIN Prescriptions pr ON m.record_id = pr.record_id
LEFT JOIN Laboratory_Tests lt ON m.record_id = lt.record_id
WHERE p.patient_id = 1;


-- Query 2: Doctor Workload and Revenue Aggregation
-- Computes the total number of appointments handled and total consultation revenue generated per doctor.
SELECT 
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS total_appointments,
    SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) AS completed_appointments,
    (SUM(CASE WHEN a.status = 'Completed' THEN 1 ELSE 0 END) * d.consultation_fee) AS total_revenue_generated
FROM Doctors d
LEFT JOIN Appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.specialization, d.consultation_fee
ORDER BY total_revenue_generated DESC;


-- Query 3: Daily Appointment Schedule Search (Targeted Filtering)
-- Searches for all scheduled appointments on a specific date filtered by a specific doctor's specialization.
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    p.phone_number,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialization,
    a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date = '2026-06-15' 
  AND d.specialization = 'Cardiology'
  AND a.status = 'Scheduled';
