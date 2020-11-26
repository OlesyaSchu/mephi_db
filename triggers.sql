DROP FUNCTION IF EXISTS result_write_if_zero() CASCADE;
CREATE FUNCTION result_write_if_zero() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
BEGIN
    -- Балл за увлечения
	UPDATE result 
	SET test_hobby =
	(SELECT hobby_score.skill_degree
    --INTO NEW.test_hobby
    FROM p_date
    JOIN scenario_date ON p_date.id_scenario_date = scenario_date.id_scenario_date
    JOIN hobby ON scenario_date.id_hobby = hobby.id_hobby
    JOIN hobby_score ON hobby.id_hobby = hobby_score.id_hobby AND NEW.id_profile = hobby_score.id_profile
    WHERE p_date.id_date = NEW.id_date)
	--WHERE id_profile = NEW.id_profile
    ;

    -- Балл за внешность
	UPDATE result
	SET test_appearance = 
    (SELECT point_appearance
    --INTO NEW.test_appearance
    FROM appearance_score
    WHERE id_profile = NEW.id_profile)
	--WHERE id_profile = NEW.id_profile
    ;

    -- Балл за характер
    UPDATE result
	SET test_temper = 
	(SELECT point_temper
    --INTO NEW.test_temper
    FROM temper_score
    WHERE id_profile = NEW.id_profile)
	--WHERE id_profile = NEW.id_profile
    ;

    RETURN NEW;
END;
$$;

CREATE TRIGGER result_write_if_zero_trg 
AFTER INSERT OR UPDATE ON result 
FOR EACH ROW
WHEN (
	NEW.test_appearance IS NOT DISTINCT FROM NULL OR 
	NEW.test_hobby IS NOT DISTINCT FROM NULL OR 
	NEW.test_temper IS NOT DISTINCT FROM NULL) --когда хотя бы одно из значений = 0
EXECUTE PROCEDURE result_write_if_zero();

--------------------------------------------------------------------------

CREATE FUNCTION mephisto_update() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    mephisto_row record;
    conformity_mephisto_change CURSOR FOR
        SELECT * FROM mephisto
        WHERE
              NEW.id_profile = id_profile_one
           OR NEW.id_profile = id_profile_two
        ;
BEGIN
    FOR mephisto_row IN conformity_mephisto_change LOOP
        UPDATE mephisto
        SET conformity_mephisto = (conformity_mephisto * 0.3)^2 + NEW.value_correction_factor
        WHERE CURRENT OF conformity_mephisto_change;
    END LOOP;

    RETURN NEW;
END
$$;

CREATE TRIGGER mephisto_update_trg
AFTER INSERT ON correction_factor
FOR EACH ROW
EXECUTE PROCEDURE mephisto_update();