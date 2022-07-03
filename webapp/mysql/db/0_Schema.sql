DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id                INTEGER             NOT NULL PRIMARY KEY,
    name              VARCHAR(64)         NOT NULL,
    description       VARCHAR(4096)       NOT NULL,
    thumbnail         VARCHAR(128)        NOT NULL,
    address           VARCHAR(128)        NOT NULL,
    latitude          DOUBLE PRECISION    NOT NULL,
    longitude         DOUBLE PRECISION    NOT NULL,
    rent              INTEGER             NOT NULL,
    rent_class        INTEGER             AS (
      CASE
        WHEN rent < 50000   THEN 0
        WHEN rent < 100000  THEN 1
        WHEN rent < 150000  THEN 2
        ELSE 3
      END
    ),
    door_height       INTEGER NOT NULL,
    door_height_class INTEGER AS (
      CASE
        WHEN door_height < 80   THEN 0
        WHEN door_height < 110  THEN 1
        WHEN door_height < 150  THEN 2
        ELSE 3
      END
    ),
    door_width        INTEGER NOT NULL,
    door_width_class  INTEGER AS (
      CASE
        WHEN door_width < 80   THEN 0
        WHEN door_width < 110  THEN 1
        WHEN door_width < 150  THEN 2
        ELSE 3
      END
    ),
    door_min_edge INTEGER AS (
      CASE
        WHEN door_width < door_height THEN door_width
        ELSE door_height
      END
    ),
    door_max_edge INTEGER AS (
      CASE
        WHEN door_width > door_height THEN door_width
        ELSE door_height
      END
    ),
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    neg_popularity  INTEGER         AS (1000000 - popularity),
    INDEX door_height_class_index(door_height_class),
    INDEX door_width_class_index(door_width_class),
    INDEX rent_class_index(rent_class),
    INDEX neg_popularity(neg_popularity, id)
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    neg_popularity  INTEGER     AS (1000000 - popularity),
    stock       INTEGER         NOT NULL,
    INDEX price_id(price, id),
    INDEX neg_popularity_id(neg_popularity, id)
);
