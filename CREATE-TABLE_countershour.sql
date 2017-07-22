CREATE TABLE maps.countershour
(
  hourslot bigint NOT NULL,
  x integer NOT NULL,
  y integer NOT NULL,
  tweets_count bigint,
  users_count bigint,
  avgfavourite double precision,
  avgretweets double precision,
  geom geometry(Point,3857) NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE maps.countershour
  OWNER TO postgres;

