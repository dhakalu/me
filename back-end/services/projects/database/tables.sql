-- drop table projects;
CREATE TABLE projects
(
 "id"          bigserial NOT NULL,
 name        text NOT NULL,
 description text NOT NULL,
 created_at  timestamp NOT NULL,
 updated_at  timestamp NOT NULL,
 CONSTRAINT projects_pk PRIMARY KEY ( "id" )
);