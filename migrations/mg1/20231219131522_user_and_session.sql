CREATE TABLE
  users (id int primary key, name varchar(100), age int);

CREATE TABLE
  sessions (
    id int primary key,
    user_id int not null,
    data text not null,
    created_at timestamptz not null default now ()
  );