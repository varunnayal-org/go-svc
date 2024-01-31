ALTER table props DROP column config_type;

ALTER table props rename column "type" to prop_type;

ALTER table props add column update_at timestamptz not null default now ();