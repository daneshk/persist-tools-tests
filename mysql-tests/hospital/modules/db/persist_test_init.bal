// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer.
// It should not be modified by hand.

import ballerina/persist;

isolated final H2Client h2Client = check new ("jdbc:h2:./test", "sa", "");

public isolated function setupTestDB() returns persist:Error? {
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "appointment";`);
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "patients";`);
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "Doctor";`);
    _ = check h2Client->executeNativeSQL(`
CREATE TABLE "Doctor" (
	"id" INT NOT NULL,
	"name" VARCHAR(191) NOT NULL,
	"specialty" VARCHAR(20) NOT NULL,
	"phone_number" VARCHAR(191) NOT NULL,
	"salary" DECIMAL(10,2),
	PRIMARY KEY("id")
);`);
    _ = check h2Client->executeNativeSQL(`
CREATE TABLE "patients" (
	"ID_P" INT AUTO_INCREMENT,
	"name" VARCHAR(191) NOT NULL,
	"age" INT NOT NULL,
	"ADDRESS" VARCHAR(191) NOT NULL,
	"phoneNumber" CHAR(10) NOT NULL,
	"gender" VARCHAR(6) CHECK ("gender" IN ('MALE', 'FEMALE')) NOT NULL,
	PRIMARY KEY("ID_P")
);`);
    _ = check h2Client->executeNativeSQL(`
CREATE TABLE "appointment" (
	"id" INT NOT NULL,
	"reason" VARCHAR(191) NOT NULL,
	"appointmentTime" DATETIME NOT NULL,
	"status" VARCHAR(9) CHECK ("status" IN ('SCHEDULED', 'STARTED', 'ENDED')) NOT NULL,
	"patient_id" INT NOT NULL,
	FOREIGN KEY("patient_id") REFERENCES "patients"("ID_P"),
	"doctorId" INT NOT NULL,
	FOREIGN KEY("doctorId") REFERENCES "Doctor"("id"),
	PRIMARY KEY("id")
);`);
    _ = check h2Client->executeNativeSQL(`CREATE INDEX "patient_id" ON "appointment" ("patient_id");`);
    _ = check h2Client->executeNativeSQL(`CREATE INDEX "doctorId" ON "appointment" ("doctorId");`);
    _ = check h2Client->executeNativeSQL(`CREATE UNIQUE INDEX "reason_index" ON "appointment" ("reason");`);
    _ = check h2Client->executeNativeSQL(`CREATE INDEX "specialty_index" ON "Doctor" ("specialty");`);
}

public isolated function cleanupTestDB() returns persist:Error? {
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "appointment";`);
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "patients";`);
    _ = check h2Client->executeNativeSQL(`DROP TABLE IF EXISTS "Doctor";`);
}

