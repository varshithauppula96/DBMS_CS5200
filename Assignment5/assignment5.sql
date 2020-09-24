
/* assignment 6, triggers are created for author table */

/* Creates Table course*/
CREATE TABLE IF NOT EXISTS course(
/* courseNumber is given as domain TEXT in the assignment question*/
/* SQLite allows primary keys to have NULL values by default, hence we need to specify NOT NULL constraint*/
  courseNumber TEXT PRIMARY KEY COLLATE NOCASE NOT NULL, /*  courseNumber 'ABC' and CourseNumber 'abc' are considered same */
  courseTitle TEXT NOT NULL ,
  courseLength INTEGER NOT NULL,
  CHECK (courseLength >0) /* Ensures that course length always more than 0*/
);

/* Creates Table topic*/
CREATE TABLE IF NOT EXISTS topic (
  tid INTEGER PRIMARY KEY, /* For integer values, SQLite takes input as NOT NULL values but auto increments the tid and stores*/
  topicName TEXT NOT NULL,
  topicLength INTEGER NOT NULL,
  subArea TEXT,
  authorID INTEGER, /* Topic can have 0 or more authors*/
  CHECK (topicLength >0) /* Ensures that topic length always more than 0*/
  CONSTRAINT aid_fk FOREIGN KEY(authorID) REFERENCES AUTHOR(aid)  
);

/* Creates Table author*/
CREATE TABLE IF NOT EXISTS author (
  aid INTEGER PRIMARY KEY , /* For integer values, SQLite takes input as NOT NULL values but auto increments the aid and stores*/
  author_name TEXT NOT NULL, /* Assumption: There can be more than one author with the same name*/
  bio TEXT,
  certification TEXT COLLATE NOCASE NOT NULL,
  email TEXT UNIQUE,
  phone TEXT UNIQUE,
  CHECK ( certification IN ('CAP','CSM','CSTE','CBAP','PMP'))/*CHECK if certification is 'PMP','CBAP','CSM','CSTE','CAP'*/

);


/* Trigger to validate email entered into table author 
Event-BEFORE INSERT ON author
Condition-WHEN new.email NOT LIKE '%@northeastern.edu'
Action-RAISE(ABORT, 'invalid Email address, please recheck and enter the correct email provider')
*/

CREATE TRIGGER validate_email_before_insert_author
	BEFORE INSERT ON author
		BEGIN 
		SELECT 
		CASE
		WHEN new.email NOT LIKE '%@northeastern.edu' THEN 
		RAISE(ABORT, 'invalid Email address, please recheck and enter the correct email provider')
		END;
	END;


CREATE TABLE phone_logs(
  old_aid INTEGER,
  new_aid INTEGER,
  old_phone TEXT,
  new_phone TEXT,
  created_at TEXT
);

/*Trigger to keep a log of changes made to author's phone number
Event-AFTER UPDATE ON author
Condition-When there is a update on phone number
Action-Insert the details about the updated phone number, the aid the update is performed for and when the update occured into new table phone_logs 
*/

CREATE TRIGGER log_phone_after_update_authorPhone
	AFTER UPDATE ON author
		WHEN old.phone <> new.phone
		BEGIN
		INSERT INTO phone_logs(
		old_aid,
		new_aid,
		old_phone,
		new_phone,
		created_at
		)
		VALUES
		(
		old.aid, new.aid, old.phone,new.phone,
		DATETIME('NOW')
		);
	END;


/* Linking tables for many to many relationships*/

CREATE TABLE course_topic( 
    courseNumber TEXT COLLATE NOCASE NOT NULL, 
    tid INTEGER NOT NULL, 
    CONSTRAINT ct_pk PRIMARY KEY (courseNumber, tid) ,
    CONSTRAINT course_fk FOREIGN KEY(courseNumber) REFERENCES course(courseNumber),
    CONSTRAINT topic_fk FOREIGN KEY(tid) REFERENCES topic(tid)
);








