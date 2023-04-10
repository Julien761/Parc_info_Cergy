-- UTILISATEURS --

CREATE OR REPLACE TRIGGER UtilisateurIncrementeId
    BEFORE INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT Utilisateurs_seq.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;

CREATE OR REPLACE TRIGGER searchForExistingUser
    BEFORE INSERT ON Utilisateurs
    FOR EACH ROW
DECLARE
    nb_match_tel NUMBER;
    nb_match_email NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match_tel FROM Utilisateurs WHERE telephone = :NEW.telephone;
        SELECT COUNT(*) INTO nb_match_email FROM Utilisateurs WHERE email = :NEW.email;

        IF nb_match_email >0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Cet email est déjà enregistré dans la base de données');
        end if;
        IF nb_match_tel>0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ce numéro de téléphone est déjà enregistré dans la base de données');
        end if;
END;


CREATE OR REPLACE TRIGGER after_user_creation
    AFTER INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
        DBMS_OUTPUT.PUT_LINE('L utilisateur ' || :NEW.nom || ' ' || :NEW.prenom || ' a bien été créé');
END;

CREATE OR REPLACE TRIGGER delete_logiciel
    BEFORE DELETE ON Logiciels
    FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM MATERIEL_LOGICIELS WHERE logiciel_id = :OLD.id;
        IF nb_match>0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ce logiciel est encore utilisé par un matériel');
        end if;
END;

-- END UTILISATEURS --

-- TICKETS --

CREATE OR REPLACE TRIGGER TicketIncrementeId
    BEFORE INSERT ON Tickets
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT Tickets_seq.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
    :new.status := 'created';
END;

CREATE OR REPLACE TRIGGER checkTechnicien
    BEFORE INSERT ON Tickets
    FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM Utilisateurs WHERE id = :NEW.technicien_id AND role = 'technicien';
        IF nb_match=0 AND :NEW.technicien_id != NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ce technicien n existe pas');
        end if;
END;

CREATE OR REPLACE TRIGGER checkTechnicienUpdate
BEFORE UPDATE ON Tickets
FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM Utilisateurs WHERE id = :NEW.technicien_id AND role = 'technicien';
        IF nb_match=0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ce technicien n existe pas');
        end if;
END;

CREATE OR REPLACE TRIGGER checkUtilisateur
    BEFORE INSERT ON Tickets
    FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM Utilisateurs WHERE id = :NEW.utilisateur_id AND role = 'utilisateur';
        IF nb_match=0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Cet utilisateur n existe pas');
        end if;
END;



-- END TICKETS --

-- MATERIELS --

CREATE OR REPLACE TRIGGER MaterielIncrementeId
    BEFORE INSERT ON Materiels
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT MATERIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;

CREATE OR REPLACE TRIGGER MessageMaterielDetruit
    BEFORE UPDATE ON MATERIELS
BEGIN
    IF :NEW.ETAT = 'detruit' then
        DBMS_OUTPUT.PUT_LINE('Le matériel ' || MATERIELS.NOM || ' / ' || MATERIELS.TYPE || ' d''id ' || MATERIELS.ID || ' est détruit');
    end if;
END;

-- END MATERIELS --

-- LOGICIELS --

CREATE OR REPLACE TRIGGER LogicielIncrementeId
    BEFORE INSERT ON Logiciels
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT LOGICIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;

-- END LOGICIELS --


-- PROJETS --

CREATE OR REPLACE TRIGGER ProjetIncrementeId
    BEFORE INSERT ON Projets
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT PROJETS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;



-- END PROJETS --

-- MATERIEL_LOGICIELS --

CREATE OR REPLACE TRIGGER MaterielLogicielIncrementeId
    BEFORE INSERT ON Materiels_Logiciels
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT MATERIEL_LOGICIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;

-- END MATERIEL_LOGICIELS --

-- PARTICIPANTS_PROJETS --

CREATE OR REPLACE TRIGGER ParticipantProjetIncrementeId
    BEFORE INSERT ON Participants_Projets
    FOR EACH ROW
BEGIN
    IF :NEW.id is NULL then
        SELECT PARTICIPANTS_PROJETS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
    end if;
END;

-- END PARTICIPANTS_PROJETS --




