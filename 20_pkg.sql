/*

    Copyright (c) 2010, 2012 Tender.Pro http://tender.pro.
    [SQL_LICENSE]

    Таблицы для компиляции и установки пакетов
*/
CREATE TYPE t_pkg_op AS ENUM ('create', 'build', 'drop', 'erase', 'done'); 
/* ------------------------------------------------------------------------- */
CREATE TABLE pkg_log (
  id          INTEGER PRIMARY KEY
, code        TEXT NOT NULL
, schemas     name[] NOT NULL
, op          t_pkg_op
, log_name    TEXT
, user_name   TEXT
, ssh_client  TEXT
, usr         TEXT DEFAULT current_user
, ip          INET DEFAULT inet_client_addr()
, stamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE SEQUENCE pkg_id_seq;
ALTER TABLE pkg_log ALTER COLUMN id SET DEFAULT NEXTVAL('pkg_id_seq');

/* ------------------------------------------------------------------------- */
CREATE TABLE pkg (
  id          INTEGER NOT NULL UNIQUE
, code        TEXT PRIMARY KEY -- для REFERENCES
, schemas     name[]
, op          t_pkg_op
, log_name    TEXT
, user_name   TEXT
, ssh_client  TEXT
, usr         TEXT DEFAULT current_user
, ip          INET DEFAULT inet_client_addr()
, stamp       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* ------------------------------------------------------------------------- */
CREATE TABLE pkg_required_by (
  code        name REFERENCES pkg
, required_by name DEFAULT current_schema() 
, CONSTRAINT pkg_required_by_pkey PRIMARY KEY (code, required_by)
);
