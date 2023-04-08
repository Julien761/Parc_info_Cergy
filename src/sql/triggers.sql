CREATE OR REPLACE TRIGGER UtilisateurIncrementeId
    BEFORE INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
        SELECT Utilisateurs_seq.nextval
        INTO :new.id
        FROM dual;
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
