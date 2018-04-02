-- colors table
create table colors (
  id serial,
  color_name varchar(255) not null,
  hex varchar(20) not null,
  r integer not null,
  g integer not null,
  b integer not null,
  initial_import boolean not null default false,
  creation_ts timestamp not null default now(),
  modification_ts timestamp not null default now(),
  check (r between 0 and 255 and g between 0 and 255 and b between 0 and 255)
)
;