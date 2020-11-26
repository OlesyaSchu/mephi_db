CREATE TABLE p_profile (
	id_profile				uuid NOT NULL PRIMARY KEY,
	name_profile 			varchar(50) NOT NULL,
	sex 					boolean,
	age 					numeric(3,0),
	CHECK(age > 18),
	about_profile 			varchar(50),
	score					numeric(10,0),
	country					varchar(20) NOT NULL,
	city					varchar(20) NOT NULL,
	photo					bytea
);

CREATE TABLE criterion (
	id_criterion			uuid NOT NULL PRIMARY KEY,
	name_criterion			varchar(20) NOT NULL,
	about_criterion			varchar(50)
);

CREATE TABLE conformity (
	id_conformity			uuid NOT NULL PRIMARY KEY,
	id_profile				uuid NOT NULL REFERENCES p_profile,
	id_criterion			uuid NOT NULL REFERENCES criterion,
	value_conformity		integer,
	relevance_conformity	boolean
);

CREATE TABLE blacklist (
	id_blacklist			uuid NOT NULL PRIMARY KEY,
	id_profile				uuid NOT NULL REFERENCES p_profile,
	id_criterion			uuid NOT NULL REFERENCES criterion,
	value_blacklist			integer,
	relevance_blacklist		boolean
);

CREATE TABLE p_message (
	id_profile_one			uuid NOT NULL REFERENCES p_profile (id_profile),
	id_profile_two			uuid NOT NULL REFERENCES p_profile (id_profile),
	number_message			uuid NOT NULL,
	text_message			varchar(200),
	sender					uuid,
	time_send				timestamp NOT NULL,
	time_get				timestamp NOT NULL,
	CHECK (time_get > time_send),
	time_read				timestamp NOT NULL,
	CHECK (time_read > time_get),
	status_message			numeric(1,0),
	PRIMARY KEY (id_profile_one, id_profile_two, number_message)
);

CREATE TABLE mephisto (
	id_profile_one			uuid NOT NULL REFERENCES p_profile (id_profile),
	id_profile_two			uuid NOT NULL REFERENCES p_profile (id_profile),
	conformity_mephisto		numeric(4,3),
	PRIMARY KEY (id_profile_one, id_profile_two)
);

CREATE TABLE e_score (
	id_profile				uuid NOT NULL REFERENCES p_profile,
	general_score			numeric(10,0),
	PRIMARY KEY (id_profile)
);

CREATE TABLE temper (
	id_temper				uuid NOT NULL PRIMARY KEY,
	name_temper				varchar(20),
	value_temper			smallint,
	about_temper			varchar(50)
);

CREATE TABLE temper_score (
	id_profile				uuid NOT NULL REFERENCES p_profile,
	id_temper				uuid NOT NULL REFERENCES temper,
	point_temper			numeric(10,0),
	PRIMARY KEY (id_profile, id_temper)
);

CREATE TABLE appearance (
	id_appearance			uuid NOT NULL PRIMARY KEY,
	name_appearance			varchar(20),
	value_appearance		smallint
);

CREATE TABLE appearance_score (
	id_profile				uuid NOT NULL REFERENCES p_profile,
	id_appearance			uuid NOT NULL REFERENCES appearance,
	point_appearance		numeric(10,0),
	PRIMARY KEY (id_profile, id_appearance)
);

CREATE TABLE hobby (
	id_hobby				uuid NOT NULL PRIMARY KEY,
	name_hobby				varchar(20)
);

CREATE TABLE hobby_score (
	id_profile				uuid NOT NULL REFERENCES p_profile,
	id_hobby				uuid NOT NULL REFERENCES hobby,
	passion_degree			numeric(4,2),
	skill_degree			numeric(4,2),
	PRIMARY KEY (id_profile, id_hobby)
);

CREATE TABLE advertising_partner (
	INN						numeric(10,0) UNIQUE NOT NULL PRIMARY KEY,
	name_partner			varchar(20) NOT NULL,
	about_partner			text,
	address_partner			varchar(50),
	requisites				text NOT NULL,
	CHECK (INN SIMILAR TO '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

CREATE TABLE date_type (
	id_date_type			uuid NOT NULL PRIMARY KEY,
	name_date_type			varchar(20) NOT NULL,
	about_date_type			varchar(50)
);

CREATE TABLE options_date (
	id_hobby				uuid NOT NULL REFERENCES hobby,
	INN						numeric(10,0) NOT NULL REFERENCES advertising_partner,
	id_date_type			uuid NOT NULL REFERENCES date_type,
	about_options_date		varchar(100),
	PRIMARY KEY (id_hobby, INN, id_date_type)
);

CREATE TABLE place (
	id_place				uuid NOT NULL PRIMARY KEY,
	address_place			varchar(20) NOT NULL,
	working_hours_place		interval NOT NULL,
	photo_place				bytea
);

CREATE TABLE contract_date (
	INN						numeric(10,0) NOT NULL REFERENCES advertising_partner,
	id_place				uuid NOT NULL REFERENCES place,
	terms					text,
	cost					money,
	PRIMARY KEY (INN, id_place)
);

CREATE TABLE scenario_date (
	id_scenario_date		uuid NOT NULL PRIMARY KEY,
	id_hobby				uuid NOT NULL REFERENCES hobby,
	id_place				uuid NOT NULL,
	id_date_type			uuid NOT NULL REFERENCES date_type,
	INN						numeric(10,0) UNIQUE NOT NULL,
	about_scenario_date		text,
	FOREIGN KEY (id_place, INN) REFERENCES contract_date (id_place, INN),
	FOREIGN KEY (id_hobby, id_date_type) REFERENCES options_date (id_hobby, id_date_type)
);

CREATE TABLE p_date (
	id_date					uuid NOT NULL PRIMARY KEY,
	id_profile_one			uuid NOT NULL,
	id_profile_two			uuid NOT NULL,
	id_scenario_date		uuid NOT NULL REFERENCES scenario_date,
	time_date timestamp,
	FOREIGN KEY (id_profile_one, id_profile_two) REFERENCES mephisto (id_profile_one, id_profile_two)
);

CREATE TABLE result (
	id_date					uuid NOT NULL REFERENCES p_date,
	id_author				uuid NOT NULL REFERENCES p_profile (id_profile),
	id_profile				uuid NOT NULL REFERENCES p_profile,
	review					varchar(50),
	test_appearance			numeric(10,0),
	test_temper				numeric(10,0),
	test_hobby				numeric(10,0),
	PRIMARY KEY (id_date, id_author)
);

CREATE TABLE correction_factor (
	id_profile				uuid NOT NULL REFERENCES p_profile,
	number_correction_factor	uuid NOT NULL,
	value_correction_factor		numeric(10,0),
	PRIMARY KEY (id_profile, number_correction_factor)
);