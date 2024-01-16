CREATE TABLE
  config (id int primary key, name varchar(100));

CREATE TABLE
  props (
    id int primary key,
    config_id int not null,
    name int not null,
    value text,
    config_type varchar(100),
    type varchar(100),
    is_active boolean not null default true,
    created_at timestamptz not null default now ()
  );