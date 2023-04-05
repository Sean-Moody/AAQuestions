PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL);


CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);


CREATE TABLE question_follows(
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    
    FOREIGN KEY(user_id) REFERENCES users(id)
    FOREIGN KEY(question_id) REFERENCES questions(id)
);


CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    reply_author_id INTEGER NOT NULL,
    body VARCHAR(255) NOT NULL,


    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(parent_reply_id) REFERENCES replies(id)
    FOREIGN KEY(reply_author_id) REFERENCES users(id)
);


CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    liked_question INTEGER NOT NULL,
    liker INTEGER NOT NULL,

    FOREIGN KEY(liked_question) REFERENCES questions(id)
    FOREIGN KEY(liker) REFERENCES users(id)
);

INSERT INTO 
    users(id, fname, lname)
VALUES
    (1, 'Sean', 'Moody');

INSERT INTO
    users(id, fname, lname)
VALUES
    (2, 'Henry', 'Lin');

INSERT INTO 
    questions(id, title, body, author_id)
VALUES
    (1, 'Who am I?', 'I really do not know', 1);

INSERT INTO 
    questions(id, title, body, author_id)
VALUES
    (2, 'Who are you?', 'I really do not care', 2);

INSERT INTO
    question_follows(id, user_id, question_id)
VALUES
    (1, 1, 2);

INSERT INTO
    question_follows(id, user_id, question_id)
VALUES
    (2, 2, 1);

INSERT INTO
    replies(id, question_id, parent_reply_id, reply_author_id, body)
VALUES
    (1, 1, NULL, 2, 'Yes');

INSERT INTO
    question_likes(id, liked_question, liker)
VALUES
    (1, 1, 2);