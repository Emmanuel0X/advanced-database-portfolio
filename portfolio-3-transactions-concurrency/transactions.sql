USE ardeliah_clinical_db;

-- ==========================================================
-- SCENARIO A: Successful Transaction (COMMIT)
-- Booking an appointment and recording initial consultation setup.
-- ==========================================================

START TRANSACTION;

-- Step 1: Insert a new patient appointment
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status)
VALUES (1, 2, '2026-06-20', '10:00:00', 'Scheduled');

-- Capture the generated appointment ID
SET @latest_appointment_id = LAST_INSERT_ID();

-- Step 2: Create a linked initial medical record stub for the consultation
INSERT INTO Medical_Records (appointment_id, patient_id, doctor_id, symptoms, diagnosis)
VALUES (@latest_appointment_id, 1, 2, 'Persistent chest pain and dizziness', 'Pending Examination');

-- If everything succeeds, commit the changes permanently
COMMIT;


-- ==========================================================
-- SCENARIO B: Failed Transaction with Error Handling (ROLLBACK)
-- Simulating a failure (e.g., foreign key violation or invalid data)
-- ==========================================================

START TRANSACTION;

-- Step 1: Attempt to book an appointment with a non-existent doctor_id (ID 999)
-- This will trigger a foreign key constraint violation error.
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, status)
VALUES (1, 999, '2026-06-21', '11:30:00', 'Scheduled');

-- Check if an error occurred (Simulated logic control)
-- If an error is detected, we roll back all changes to keep database integrity intact.
ROLLBACK;
