-- DON'T EDIT MANNUALLY! THIS FILE IS GENERATED BY author/create_ddl.pl

BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS branch (
  branch_id INTEGER PRIMARY KEY NOT NULL,
  project VARCHAR(255) NOT NULL,
  branch VARCHAR(255) NOT NULL,
  last_report_id INTEGER DEFAULT NULL,
  ctime INTEGER NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS project_branch_uniq ON branch (project, branch);

CREATE TABLE IF NOT EXISTS report (
  report_id INTEGER PRIMARY KEY NOT NULL,
  branch_id INTEGER NOT NULL,
  status TINYINT NOT NULL,
  repo TEXT,
  revision VARCHAR(255) DEFAULT NULL,
  vc_log TEXT,
  body TEXT,
  ctime INTEGER NOT NULL,
  compare_url VARCHAR(255) DEFAULT NULL
);

CREATE INDEX IF NOT EXISTS report_branch_idx ON report (branch_id);

COMMIT;