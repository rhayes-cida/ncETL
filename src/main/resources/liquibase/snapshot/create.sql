--<ScriptOptions statementTerminator=";"/>
CREATE TABLE RENAME_MAPPING (
		ID INTEGER DEFAULT AUTOINCREMENT: start 1 increment 1 NOT NULL GENERATED ALWAYS AS IDENTITY  (START WITH 1 ,INCREMENT BY 38),
		ARCHIVE_ID INTEGER,
		FROM_NAME VARCHAR(256),
		TO_NAME VARCHAR(256),
		INSERTED null DEFAULT false,
		UPDATED null DEFAULT false
	);

CREATE TABLE ARCHIVE_CONFIG (
		ID INTEGER DEFAULT AUTOINCREMENT: start 1 increment 1 NOT NULL GENERATED ALWAYS AS IDENTITY  (START WITH 1 ,INCREMENT BY 15),
		INPUT_DIR VARCHAR(256),
		OUTPUT_DIR VARCHAR(256),
		COMPLETE_DIR VARCHAR(256),
		FILE_REGEX VARCHAR(256),
		RFC_CODE INTEGER,
		UNLIMITED_DIM VARCHAR(256),
		UNLIMITED_UNITS VARCHAR(256),
		INSERTED null DEFAULT false,
		UPDATED null DEFAULT false,
		NAME CHAR(4)
	);

CREATE TABLE ETL_HISTORY (
		ID INTEGER DEFAULT GENERATED_BY_DEFAULT NOT NULL GENERATED ALWAYS AS IDENTITY  (START WITH 1 ,INCREMENT BY 10),
		ARCHIVE_ID INTEGER,
		TS TIMESTAMP,
		OUTCOME VARCHAR(255)
	);

CREATE TABLE EXCLUDE_MAPPING (
		ID INTEGER DEFAULT AUTOINCREMENT: start 1 increment 1 NOT NULL GENERATED ALWAYS AS IDENTITY  (START WITH 1 ,INCREMENT BY 146),
		ARCHIVE_ID INTEGER,
		EXCLUDE_TYPE_ID INTEGER,
		EXCLUDE_TEXT VARCHAR(256),
		INSERTED null DEFAULT false,
		UPDATED null DEFAULT false
	);

CREATE TABLE EXCLUDE_TYPE (
		ID INTEGER NOT NULL,
		TYPE VARCHAR(8)
	);

CREATE INDEX SQL130530095627830 ON ETL_HISTORY (ARCHIVE_ID ASC);

CREATE UNIQUE INDEX SQL130311202651290 ON EXCLUDE_TYPE (ID ASC);

CREATE UNIQUE INDEX SQL130530095627790 ON ETL_HISTORY (ID ASC);

CREATE INDEX SQL130311202651340 ON EXCLUDE_MAPPING (EXCLUDE_TYPE_ID ASC);

CREATE INDEX SQL130311202651330 ON EXCLUDE_MAPPING (ARCHIVE_ID ASC);

CREATE UNIQUE INDEX SQL130311202651470 ON RENAME_MAPPING (ID ASC);

CREATE UNIQUE INDEX SQL130311202651270 ON ARCHIVE_CONFIG (ID ASC);

CREATE INDEX SQL130311202651471 ON RENAME_MAPPING (ARCHIVE_ID ASC);

CREATE UNIQUE INDEX SQL130311202651320 ON EXCLUDE_MAPPING (ID ASC);

ALTER TABLE EXCLUDE_MAPPING ADD CONSTRAINT SQL130311202651320 PRIMARY KEY (ID);

ALTER TABLE ARCHIVE_CONFIG ADD CONSTRAINT SQL130311202651270 PRIMARY KEY (ID);

ALTER TABLE EXCLUDE_TYPE ADD CONSTRAINT SQL130311202651290 PRIMARY KEY (ID);

ALTER TABLE RENAME_MAPPING ADD CONSTRAINT SQL130311202651470 PRIMARY KEY (ID);

ALTER TABLE ETL_HISTORY ADD CONSTRAINT PK_ETL_HISTORY PRIMARY KEY (ID);

ALTER TABLE EXCLUDE_MAPPING ADD CONSTRAINT EXCLUDE_TYPE_FK FOREIGN KEY (EXCLUDE_TYPE_ID)
	REFERENCES EXCLUDE_TYPE (ID)
	ON DELETE CASCADE;

ALTER TABLE ETL_HISTORY ADD CONSTRAINT FKETLHISTORY FOREIGN KEY (ARCHIVE_ID)
	REFERENCES ARCHIVE_CONFIG (ID);

ALTER TABLE EXCLUDE_MAPPING ADD CONSTRAINT ARCHIVE2_FK FOREIGN KEY (ARCHIVE_ID)
	REFERENCES ARCHIVE_CONFIG (ID)
	ON DELETE CASCADE;

CREATE TRIGGER TG_SET_TIME AFTER INSERT ON ETL_HISTORY
FOR EACH STATEMENT MODE DB2SQL
UPDATE ETL_HISTORY 
  			SET TS = CURRENT_TIMESTAMP
  			WHERE TS IS NULL;

