-- derived units
SELECT radian();
SELECT steradian();
SELECT hertz();
SELECT newton();
SELECT pascal();
SELECT joule();
SELECT watt();
SELECT coulomb();
SELECT volt();
SELECT farad();
SELECT ohm();
SELECT siemens();
SELECT weber();
SELECT tesla();
SELECT henry();
SELECT celsius();
SELECT lumen();
SELECT lux();
SELECT becquerel();
SELECT gray();
SELECT sievert();
SELECT katal();

SELECT radian(2);
SELECT steradian(2);
SELECT hertz(2);
SELECT newton(2);
SELECT pascal(2);
SELECT joule(2);
SELECT watt(2);
SELECT coulomb(2);
SELECT volt(2);
SELECT farad(2);
SELECT ohm(2);
SELECT siemens(2);
SELECT weber(2);
SELECT tesla(2);
SELECT henry(2);
SELECT celsius(100);
SELECT lumen(2);
SELECT lux(2);
SELECT becquerel(2);
SELECT gray(2);
SELECT sievert(2);
SELECT katal(2);

-- Non-SI units accepted for use with the SI
SELECT minute();
SELECT hour();
SELECT day();
SELECT degree_arc();
SELECT minute_arc();
SELECT second_arc();
SELECT hectare();
SELECT liter();
SELECT tonne();
SELECT au();
SELECT decibel();

SELECT minute(60);
SELECT hour(24);
SELECT day(1/24.0);
SELECT degree_arc(360);
SELECT minute_arc(60);
SELECT second_arc(60);
SELECT hectare(1/100.0);
SELECT liter(1000);
SELECT tonne(1/1000.0);
SELECT au(10);
SELECT decibel(-3);
SELECT decibel(3);
SELECT decibel(10);
SELECT decibel(20);

SET client_min_messages = warning;
DROP TABLE IF EXISTS u;
RESET client_min_messages;
CREATE TABLE u AS
  SELECT unit AS u, 2000 * unit AS "2k", unit/5000 AS "200µ", 0.002/unit AS "500th_inverse", (40*unit)^2 AS "1600_square"
	FROM units WHERE base OR coherent;
SELECT * FROM u;
SELECT u, u::text::unit AS "text::unit", "2k"::text::unit, "200µ"::text::unit, "500th_inverse"::text::unit, "1600_square"::text::unit FROM u;

-- test i/o
SELECT
  a.u, b.u, (a.u::unit*b.u::unit)::text, (a.u::unit*b.u::unit)::text::unit
FROM
  units a CROSS JOIN units b
WHERE (a.u::unit*b.u::unit)::text != (a.u::unit*b.u::unit)::text::unit::text;
