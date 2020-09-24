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
  bio TEXT
   /*  Assumption: A Author can have multiple certification, certification can be given to multiple authors*/
 
);

/* table for storing information about author certifications*/
CREATE TABLE IF NOT EXISTS author_certification (
    aid INTEGER NOT NULL,
    certification TEXT COLLATE NOCASE NOT NULL,
   CHECK ( certification IN ('CAP','CSM','CSTE','CBAP','PMP'))/*CHECK if certification is 'PMP','CBAP','CSM','CSTE','CAP'*/
 CONSTRAINT ac_pk PRIMARY KEY (aid, certification) ,
    CONSTRAINT author_fk FOREIGN KEY(aid) REFERENCES author(aid)
    
);
 
/* Linking tables for many to many relationships*/

CREATE TABLE course_topic( 
    courseNumber TEXT COLLATE NOCASE NOT NULL, 
    tid INTEGER NOT NULL, 
    CONSTRAINT ct_pk PRIMARY KEY (courseNumber, tid) ,
    CONSTRAINT course_fk FOREIGN KEY(courseNumber) REFERENCES course(courseNumber),
    CONSTRAINT topic_fk FOREIGN KEY(tid) REFERENCES topic(tid)
);










