CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT * FROM result;
SELECT * FROM temper;
SELECT * FROM appearance;
SELECT * FROM hobby;

SELECT * FROM temper_score;
SELECT * FROM appearance_score;
SELECT * FROM hobby_score;

SELECT * FROM p_profile;
INSERT INTO p_profile (id_profile, name_profile, country, city)
VALUES (uuid_generate_v4(), '{"a"}', '{"a"}', '{"a"}');

INSERT INTO temper (id_temper)
VALUES (uuid_generate_v4());
INSERT INTO appearance (id_appearance)
VALUES (uuid_generate_v4());
INSERT INTO hobby (id_hobby)
VALUES (uuid_generate_v4());

INSERT INTO temper_score (id_profile, id_temper, point_temper)
VALUES ('153d491b-48e4-40aa-bbad-d51309d5f2b5', '497e23e0-081c-48b3-919f-5af7777771e3', 2);
INSERT INTO appearance_score (id_profile, id_appearance, point_appearance)
VALUES ('153d491b-48e4-40aa-bbad-d51309d5f2b5', '27dab2a6-4e57-4e9f-9a8c-65a64f193ceb', 4);
INSERT INTO hobby_score (id_profile, id_hobby, passion_degree, skill_degree)
VALUES ('153d491b-48e4-40aa-bbad-d51309d5f2b5', 'd9c16805-9044-484b-9caa-905676c32f97', 12, 14);

INSERT INTO mephisto (id_profile_one, id_profile_two, conformity_mephisto)
VALUES ('153d491b-48e4-40aa-bbad-d51309d5f2b5', '5a4f088f-4ea8-436e-bb42-4888fad986d5', 3.467);
SELECT * FROM mephisto;

SELECT * FROM advertising_partner;
INSERT INTO advertising_partner (INN, name_partner, requisites)
VALUES ('1234567890', '{"ООО Вкусные пончики"}', 'циферки всякие');

INSERT INTO date_type (id_date_type, name_date_type)
VALUES (uuid_generate_v4(), '{"-"}');
SELECT * FROM date_type;

INSERT INTO options_date (id_hobby, INN, id_date_type)
VALUES ('d9c16805-9044-484b-9caa-905676c32f97', '1234567890', 'cb1fe45b-c9b8-44aa-945c-88c2bb3ec9b8');
SELECT * FROM options_date;

INSERT INTO place (id_place, address_place, working_hours_place)
VALUES (uuid_generate_v4(), '{"ул.Советская, д.5"}', '5 days 12 hours');
SELECT * FROM place;

INSERT INTO contract_date (INN, id_place)
VALUES ('1234567890', '31365daa-ae18-4447-8b88-d4546be58725');
SELECT * FROM contract_date;

INSERT INTO scenario_date (id_scenario_date, id_hobby, id_place, id_date_type, INN)
VALUES (uuid_generate_v4(), 'd9c16805-9044-484b-9caa-905676c32f97', '31365daa-ae18-4447-8b88-d4546be58725',
		'cb1fe45b-c9b8-44aa-945c-88c2bb3ec9b8', '1234567890');
SELECT * FROM scenario_date;

INSERT INTO p_date (id_date, id_profile_one, id_profile_two, id_scenario_date)
VALUES (uuid_generate_v4(), '153d491b-48e4-40aa-bbad-d51309d5f2b5', 
		'5a4f088f-4ea8-436e-bb42-4888fad986d5', '56f147e3-f098-49b6-bc29-06c4208eecd3');
SELECT * FROM p_date;

INSERT INTO result (id_date, id_author, id_profile, test_appearance, test_temper, test_hobby)
VALUES ('66a82fc5-feaf-493c-b7e9-20c281698d46',
		'5a4f088f-4ea8-436e-bb42-4888fad986d5', '153d491b-48e4-40aa-bbad-d51309d5f2b5', NULL, 3, NULL);
SELECT * FROM result;

UPDATE result 
SET test_appearance = NULL
WHERE id_date = '66a82fc5-feaf-493c-b7e9-20c281698d46' AND id_author = '5a4f088f-4ea8-436e-bb42-4888fad986d5';

INSERT INTO result (id_date, id_author, id_profile, test_appearance, test_temper, test_hobby)
VALUES ('66a82fc5-feaf-493c-b7e9-20c281698d46',
		'5a4f088f-4ea8-436e-bb42-4888fad986d5', '153d491b-48e4-40aa-bbad-d51309d5f2b5', 4, 3, NULL);
SELECT * FROM result;