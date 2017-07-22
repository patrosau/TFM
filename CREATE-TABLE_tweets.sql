CREATE TABLE maps.tweets
(
  id bigint NOT NULL,
  tweet character varying,
  x integer NOT NULL,
  y integer NOT NULL,
  hourslot bigint NOT NULL,
  favourite_count bigint,
  retweet_count bigint,
  in_reply_to bigint,
  quoted_status_id bigint,
  retweeted_status_id bigint,
  user_id bigint,
  geom geometry(Point,3857) NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE maps.tweets
  OWNER TO postgres;
