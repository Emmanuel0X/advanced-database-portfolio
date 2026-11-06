# Portfolio 5: Distributed & Cloud Database Strategy

## 1. High Availability & Replication (Primary-Secondary)
To ensure zero downtime during critical emergency patient admissions, Ardeliah Clinical System implements a **Primary-Secondary (Master-Slave) Replication** model in the cloud (e.g., AWS RDS Multi-AZ):
- **Primary Node:** Handles all write operations (e.g., new bookings, prescription entries, lab result updates).
- **Secondary Replica:** Synchronously or semi-synchronously replicates data from the primary node. In the event of primary hardware failure, automatic failover promotes the secondary node to primary within seconds.

## 2. Horizontal Sharding Strategy
To manage millions of historical patient medical records efficiently, the database implements **range-based sharding** based on `patient_id` geographic clusters (e.g., North Region vs. South Region branches):
- Shard 1: Patients ID 1 – 500,000 (Abuja Central Branch)
- Shard 2: Patients ID 500,001 – 1,000,000 (Lagos Branch)

## 3. CAP Theorem Trade-off
In a distributed hospital database, i evaluate the **CAP Theorem** (Consistency, Availability, Partition Tolerance):
- **Choice:** **AP / Eventual Consistency** for analytical logging and non-urgent appointment syncs across regional branches.
- **Strict Consistency (CP):** Enforced strictly for financial billing, payment transactions, and active emergency medication records to prevent dangerous medical or financial discrepancies.
