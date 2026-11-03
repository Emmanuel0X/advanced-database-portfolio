# Portfolio 3: Concurrency Control & Isolation Levels

## 1. The Concurrency Challenge
In a busy hospital environment like Ardeliah Clinical System, multiple receptionists might attempt to book the same doctor for the exact same time slot concurrently. Without proper isolation, this can lead to **Race Conditions** or **Double Booking**.

## 2. Isolation Levels in MySQL (InnoDB)
To solve this, MySQL uses the InnoDB storage engine supporting ACID properties and four standard isolation levels:
- **READ UNCOMMITTED**: Allows dirty reads. (Not used in clinical systems for obvious safety reasons).
- **READ COMMITTED**: Prevents dirty reads by ensuring queries only see data committed before the query execution.
- **REPEATABLE READ (Default)**: Ensures that any reads performed within a transaction are consistent, preventing non-repeatable reads.
- **SERIALIZABLE**: The strictest level. It forces transactions to execute serially by placing range locks, completely preventing phantom reads.

## 3. Practical Concurrency Control Mechanism
To prevent double-booking a doctor's time slot, Ardeliah Clinical System uses explicit locking or `SERIALIZABLE` isolation during slot verification:

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;

-- Check if slot is taken
SELECT COUNT(*) FROM Appointments 
WHERE doctor_id = 2 AND appointment_date = '2026-06-20' AND appointment_time = '10:00:00';

-- If count is 0, proceed to insert. Otherwise, rollback.
COMMIT;
