# Portfolio 4: NoSQL Implementation & Suitability Report

## 1. Model Selection
For Ardeliah Clinical System, a **Document-Oriented NoSQL Model (MongoDB)** was selected. It organizes patient data into hierarchical BSON/JSON documents rather than flat tabular rows.

## 2. Key Benefits over Relational Model
-- **Atomic Retrieval:** Fetching a patient's entire medical background (visits, prescriptions, lab results) requires a single query (`db.patients.findOne({ _id: "PAT_9845210" })`), eliminating complex 5-way SQL `JOIN` overhead.
-- **Schema Flexibility:** Medical attributes change frequently (e.g., a new test category or wearable device integration). Document stores accommodate schema evolution without requiring disruptive table migrations (`ALTER TABLE`).
-- **Horizontal Scalability:** As hospital records scale into millions of historical patient logs, MongoDB's sharding architecture distributes document collections across clusters seamlessly.
