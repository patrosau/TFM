-- Index: maps.geo_countersday_gix

-- DROP INDEX maps.geo_countersday_gix;

CREATE INDEX geo_countersday_gix
  ON maps.countersday
  USING gist
  (geom);
