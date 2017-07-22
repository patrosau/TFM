
-- Index: maps.geo_countershour_gix

-- DROP INDEX maps.geo_countershour_gix;

CREATE INDEX geo_countershour_gix
  ON maps.countershour
  USING gist
  (geom);
