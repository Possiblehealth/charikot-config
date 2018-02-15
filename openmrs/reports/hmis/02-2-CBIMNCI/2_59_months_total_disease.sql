SELECT 
    first_question.answer_name AS first_concept_name,
    count(DISTINCT(first_concept.person_id)) as count_patient

FROM
  (SELECT 
				question_concept_name.concept_id as question,
            IFNULL(question_concept_short_name.name, question_concept_name.name) AS answer_name
    FROM
        concept c
    INNER JOIN concept_datatype cd ON c.datatype_id = cd.concept_datatype_id
    INNER JOIN concept_name question_concept_name ON c.concept_id = question_concept_name.concept_id
        AND question_concept_name.concept_name_type = 'FULLY_SPECIFIED'
        AND question_concept_name.voided IS FALSE
    LEFT JOIN concept_name question_concept_short_name ON question_concept_name.concept_id = question_concept_short_name.concept_id
        AND question_concept_short_name.concept_name_type = 'SHORT'
        AND question_concept_short_name.voided
        IS FALSE
    WHERE
        question_concept_name.name IN ('Childhood Illness (2-59)-Malaria Free Zone-Measles',
        'Childhood Illness (2-59)-Malaria Risk Zone-Falciparum Malaria',
        'Childhood Illness (2-59)-Malaria Risk Zone-Non Falciparum Malaria',
        'Childhood Illness (2-59)-Malaria Risk Zone-Complicated Malaria',
        'Childhood Illness, Fever present',
        'CBIMNCI-Anaemia',
        'Childhood Illness-Nutrition status-Other diagnosis')


    ORDER BY answer_name DESC) first_question
        
        LEFT OUTER JOIN
    (SELECT DISTINCT
        o1.person_id,
            
            cn1.concept_id AS question
    FROM
        obs o1
    INNER JOIN concept_name cn1 ON o1.concept_id = cn1.concept_id
        AND cn1.concept_name_type = 'FULLY_SPECIFIED'
        AND cn1.name IN ('Childhood Illness (2-59)-Ear Infection-Chronic Ear Infection','Childhood Illness (2-59)-Malaria Free Zone-Measles',
       'Childhood Illness (2-59)-Malaria Risk Zone-Falciparum Malaria','Childhood Illness (2-59)-Malaria Risk Zone-Non Falciparum Malaria',
       'Childhood Illness (2-59)-Malaria Risk Zone-Complicated Malaria','Childhood Illness, Fever present',
       'CBIMNCI-Anaemia','Childhood Illness-Nutrition status-Other diagnosis')

        AND o1.voided = 0
        AND cn1.voided = 0

    INNER JOIN encounter e ON o1.encounter_id = e.encounter_id
    INNER JOIN person p1 ON o1.person_id = p1.person_id
    WHERE

        -- DATE(e.encounter_datetime) BETWEEN DATE('2016-04-01') AND DATE('2017-04-30') 
		DATE(e.encounter_datetime) BETWEEN DATE('#startDate#') AND DATE('#endDate#')


            AND o1.value_coded IS NOT NULL) first_concept ON first_concept.question = first_question.question
GROUP BY first_question.answer_name ;