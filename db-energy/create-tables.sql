-- create tables for the unenergy2018 database
DROP TABLE solar;

CREATE TABLE solar (
  country VARCHAR(120),
  type    VARCHAR(120),
  year    INT,
  unit    VARCHAR(40),
  usage   DOUBLE PRECISION,
  notes   VARCHAR(40)
);

\copy solar from "/Users/km/odrive/Google Drive (Tamedia)
/LEDE-12/Classes/Data and Databases/energy/solar-energy.csv" delimiter ',' csv;

CREATE TABLE wind (
  country VARCHAR(120),
  type    VARCHAR(120),
  year    INT,
  unit    VARCHAR(40),
  usage   DOUBLE PRECISION,
  notes   VARCHAR(40)
);

CREATE TABLE hydro (
  country VARCHAR(120),
  type    VARCHAR(120),
  year    INT,
  unit    VARCHAR(40),
  usage   DOUBLE PRECISION,
  notes   VARCHAR(40)
);