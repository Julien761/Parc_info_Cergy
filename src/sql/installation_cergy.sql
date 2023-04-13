-- Ici sont appelés tous les scripts qui permettent la mise en place
-- de la base locale de Cergy + les scripts uniquement présents sur Cergy
-- afin de satisfaire l'exigence d'une base de données répartie.

-- CREATION DES TABLES --

CREATE TABLE Utilisateurs (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(50) NOT NULL,
  prenom VARCHAR2(50) NOT NULL,
  email VARCHAR2(100),
  telephone VARCHAR2(20),
  role VARCHAR2(20) NOT NULL
);
CREATE SEQUENCE Utilisateurs_seq
START WITH 1;

CREATE TABLE Materiels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(100) NOT NULL,
  description VARCHAR2(200),
  date_achat DATE,
  date_fin_garantie DATE,
  type VARCHAR2(20),
  etat VARCHAR2(20),
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE Materiels_seq
START WITH 1;

CREATE TABLE Logiciels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  date_achat DATE,
  date_expiration DATE
);
CREATE SEQUENCE Logiciels_seq
START WITH 1;

CREATE TABLE Materiel_logiciels (
  id NUMBER(10) PRIMARY KEY,
  materiel_id NUMBER(10),
  FOREIGN KEY (materiel_id) REFERENCES Materiels(id),
  logiciel_id NUMBER(10),
  FOREIGN KEY (logiciel_id) REFERENCES Logiciels(id)
);
CREATE SEQUENCE Materiel_logiciels_seq
START WITH 1;

CREATE TABLE TICKETS (
  id NUMBER(10) PRIMARY KEY,
  sujet VARCHAR(100) NOT NULL,
  description VARCHAR(510) NOT NULL,
  date_creation DATE NOT NULL,
  priorite VARCHAR(20) NOT NULL,
  status VARCHAR(20),
  utilisateur_id NUMBER(10) NOT NULL,
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
  technicien_id NUMBER(10),
  FOREIGN KEY (technicien_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE TICKETS_seq
START WITH 1;

CREATE TABLE PROJETS (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  description VARCHAR(510) NOT NULL,
  date_creation DATE,
  responsable_id NUMBER(10) NOT NULL,
  FOREIGN KEY (responsable_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE PROJETS_seq
START WITH 1;

CREATE TABLE PARTICIPANTS_PROJETS (
  id NUMBER(10) PRIMARY KEY,
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
  projet_id NUMBER(10),
  FOREIGN KEY (projet_id) REFERENCES PROJETS(id)
);

CREATE SEQUENCE PARTICIPANTS_PROJETS_seq
START WITH 1;

CREATE TABLE PROJETS_TICKETS (
  id NUMBER(10) PRIMARY KEY,
  ticket_id NUMBER(10),
  FOREIGN KEY (ticket_id) REFERENCES TICKETS(id),
  projet_id NUMBER(10),
  FOREIGN KEY (projet_id) REFERENCES PROJETS(id)
);
CREATE SEQUENCE PROJETS_TICKETS_seq
START WITH 1;

-- CREATION DES PROCEDURES --

-- TICKETS --
CREATE OR REPLACE PROCEDURE Update_Ticket_Status (p_ticket_id IN NUMBER, p_status IN VARCHAR2) AS
    BEGIN
        UPDATE TICKETS SET STATUS = p_status WHERE ID = p_ticket_id;
    END Update_Ticket_Status;

CREATE OR REPLACE PROCEDURE Update_Ticket_Priority (p_ticket_id IN NUMBER, p_priority IN VARCHAR2) AS
    BEGIN
        UPDATE TICKETS SET PRIORITE = p_priority WHERE ID = p_ticket_id;
    END Update_Ticket_Priority;

CREATE OR REPLACE PROCEDURE Update_Ticket_Assignee (p_ticket_id IN NUMBER, p_technicien_id IN NUMBER) AS
    BEGIN
        UPDATE TICKETS SET TECHNICIEN_ID = p_technicien_id WHERE ID = p_ticket_id;
    END Update_Ticket_Assignee;

-- END TICKETS --

-- MATERIELS --
CREATE OR REPLACE PROCEDURE Maj_Etat_Materiel (id_materiel IN NUMBER, n_etat IN VARCHAR2) AS
    BEGIN
        UPDATE MATERIELS SET ETAT = n_etat WHERE ID = id_materiel;
    END Maj_Etat_Materiel;

CREATE OR REPLACE PROCEDURE Add_Logiciel_Materiel (id_materiel IN NUMBER, id_logiciel IN NUMBER) AS
    BEGIN
        INSERT INTO MATERIEL_LOGICIELS (MATERIEL_ID, LOGICIEL_ID) VALUES (id_materiel, id_logiciel);
    END Add_Logiciel_Materiel;

CREATE OR REPLACE PROCEDURE Delete_Logiciel_Materiel (id_materiel IN NUMBER, id_logiciel IN NUMBER) AS
    BEGIN
        DELETE FROM MATERIEL_LOGICIELS
            WHERE MATERIEL_ID = id_materiel AND LOGICIEL_ID = id_logiciel;
    END Delete_Logiciel_Materiel;


-- END MATERIELS --

-- LOGICIELS --

CREATE OR REPLACE PROCEDURE Remove_Logiciel_From_All_Materiels (id_logiciel IN NUMBER) AS
    BEGIN
        DELETE FROM MATERIEL_LOGICIELS
            WHERE LOGICIEL_ID = id_logiciel;
    END Remove_Logiciel_From_All_Materiels;

-- END LOGICIELS --


-- PROJETS --
CREATE OR REPLACE PROCEDURE Ajouter_Participant_Projet (projet_id IN NUMBER, participant_id IN NUMBER) AS
    BEGIN
        INSERT INTO PARTICIPANTS_PROJETS (UTILISATEUR_ID, PROJET_ID) VALUES (participant_id, projet_id);
    END Ajouter_Participant_Projet;

CREATE OR REPLACE PROCEDURE Supprimer_Participant_Projet (projet_id IN NUMBER, participant_id IN NUMBER) AS
    BEGIN
        DELETE FROM PARTICIPANTS_PROJETS
            WHERE PROJET_ID = projet_id AND UTILISATEUR_ID = participant_id;
    END Supprimer_Participant_Projet;

CREATE OR REPLACE PROCEDURE Ajouter_Ticket_Projet (projet_id IN NUMBER, ticket_id IN NUMBER) AS
    BEGIN
        INSERT INTO PROJETS_TICKETS (PROJET_ID, TICKET_ID) VALUES (projet_id, ticket_id);
    END Ajouter_Ticket_Projet;

-- CREATION DES TRIGGERS --

CREATE OR REPLACE TRIGGER UtilisateurIncrementeId
    BEFORE INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
        SELECT Utilisateurs_seq.nextval
        INTO :NEW.id
        FROM DUAL;
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



CREATE OR REPLACE TRIGGER after_user_creations
    AFTER INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('L utilisateur ' || :NEW.nom || ' ' || :NEW.prenom || ' a bien été créé');
END;

CREATE OR REPLACE TRIGGER checkValiditeRole
    AFTER UPDATE OR INSERT ON Utilisateurs
    FOR EACH ROW
BEGIN
    IF :NEW.role != 'technicien' AND :NEW.role != 'utilisateur' AND :NEW.role != 'professeur' THEN
        RAISE_APPLICATION_ERROR(698651, 'Le role doit être "technicien" ou "utilisateur"');
    end if;
end;

-- END UTILISATEURS --


    -- LIGNE DE DROIT D'EXECUTION DE CERTAINS trigger POUR local_admin
-- GRANT EXECUTE ON nom-trigger TO admin;
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


-- TICKETS --

CREATE OR REPLACE TRIGGER TicketIncrementeId
    BEFORE INSERT ON Tickets
    FOR EACH ROW
BEGIN

        SELECT Tickets_seq.nextval
        INTO :NEW.id
        FROM DUAL;
        :new.status := 'created';
END;

CREATE OR REPLACE TRIGGER checkTechnicien
    BEFORE INSERT OR UPDATE ON Tickets
    FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM Utilisateurs WHERE id = :NEW.technicien_id AND role = 'technicien';
        IF nb_match=0 AND :NEW.technicien_id != NULL THEN
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

CREATE OR REPLACE TRIGGER checkValiditeStatus
    AFTER UPDATE OR INSERT ON Tickets
    FOR EACH ROW
BEGIN
    IF :NEW.status != 'created' AND :NEW.status != 'assigned' AND :NEW.status != 'in progress' AND :NEW.status != 'resolved' AND :NEW.status != 'closed' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le status du ticket doit être "created", "assigned", "in progress", "resolved" ou "closed"');
    end if;
end;

CREATE OR REPLACE TRIGGER checkValidityPriority
    AFTER UPDATE OR INSERT ON Tickets
    FOR EACH ROW
BEGIN
    IF :NEW.priorite != 'low' AND :NEW.priorite != 'medium' AND :NEW.priorite != 'high' AND :NEW.priorite != 'urgent' THEN
        RAISE_APPLICATION_ERROR(-20001, 'La priorité du ticket doit être "low", "medium", "high" ou "urgent"');
    end if;
end;

-- END TICKETS --

-- MATERIELS --

CREATE OR REPLACE TRIGGER MaterielIncrementeId
    BEFORE INSERT ON Materiels
    FOR EACH ROW
BEGIN
        SELECT MATERIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;

CREATE OR REPLACE TRIGGER MessageMaterielDetruit
    AFTER UPDATE ON MATERIELS
    FOR EACH ROW
BEGIN
    IF :NEW.ETAT = 'detruit' then
        DBMS_OUTPUT.PUT_LINE('Le matériel ' || :OLD.NOM || ' / ' || :OLD.TYPE || ' d id ' || :OLD.ID || ' est détruit');
    end if;
END;

CREATE OR REPLACE TRIGGER checkValiditeEtat
    AFTER UPDATE OR INSERT ON MATERIELS
    FOR EACH ROW
BEGIN
    IF :NEW.ETAT != 'detruit' AND :NEW.ETAT != 'en service' AND :NEW.ETAT != 'en panne' AND :NEW.ETAT != 'en réparation' THEN
        RAISE_APPLICATION_ERROR(-20001, 'L état du matériel doit être "detruit", "en service", "en panne" ou "en réparation"');
    end if;
end;

-- END MATERIELS --

-- LOGICIELS --

CREATE OR REPLACE TRIGGER LogicielIncrementeId
    BEFORE INSERT ON Logiciels
    FOR EACH ROW
BEGIN
        SELECT LOGICIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;

CREATE OR REPLACE TRIGGER VerifierExpiration
    BEFORE INSERT ON Logiciels
    FOR EACH ROW
BEGIN
    IF :NEW.DATE_EXPIRATION <= SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erreur dans l enregistrement, le logiciel a expiré');
    END IF;
END;

CREATE OR REPLACE TRIGGER LicenceDejaEnregistre
    BEFORE INSERT ON Logiciels
    FOR EACH ROW
    DECLARE
        nb_match NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO nb_match FROM Logiciels WHERE nom = :NEW.nom AND date_achat = :NEW.date_achat AND date_expiration = :NEW.date_expiration;
    IF nb_match != 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erreur dans l enregistrement, la licence est déjà enregistrée');
    END IF;
END;

-- END LOGICIELS --


-- PROJETS --

CREATE OR REPLACE TRIGGER ProjetIncrementeId
    BEFORE INSERT ON Projets
    FOR EACH ROW
BEGIN
        SELECT PROJETS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;



-- END PROJETS --

-- MATERIEL_LOGICIELS --

CREATE OR REPLACE TRIGGER MaterielLogicielIncrementeId
    BEFORE INSERT ON Materiel_Logiciels
    FOR EACH ROW
BEGIN
        SELECT MATERIEL_LOGICIELS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;

-- END MATERIEL_LOGICIELS --

-- PARTICIPANTS_PROJETS --

CREATE OR REPLACE TRIGGER ParticipantProjetIncrementeId
    BEFORE INSERT ON Participants_Projets
    FOR EACH ROW
BEGIN
        SELECT PARTICIPANTS_PROJETS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;

-- END PARTICIPANTS_PROJETS --

-- PROJETS_TICKETS --

CREATE OR REPLACE TRIGGER ProjetTicketIncrementeId
    BEFORE INSERT ON Projets_Tickets
    FOR EACH ROW
BEGIN
        SELECT PROJETS_TICKETS_SEQ.nextval
        INTO :NEW.id
        FROM DUAL;
END;

CREATE OR REPLACE TRIGGER checkProjet
    BEFORE INSERT ON Projets_Tickets
    FOR EACH ROW
DECLARE
    nb_match NUMBER;
BEGIN
        SELECT COUNT(*) INTO nb_match FROM Projets WHERE id = :NEW.projet_id;
        IF nb_match=0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Ce projet n existe pas');
        end if;
END;
-- END PROJETS_TICKETS --

-- CREATION DES VUES --

CREATE OR REPLACE VIEW Noms_Utilisateurs AS
  SELECT PRENOM, NOM
  FROM UTILISATEURS;


-- PROJETS --
CREATE OR REPLACE VIEW Noms_Participants_Projets AS
    SELECT PROJETS.NOM, UTILISATEURS.PRENOM
    FROM UTILISATEURS
    INNER JOIN PARTICIPANTS_PROJETS PP on UTILISATEURS.ID = PP.UTILISATEUR_ID
    INNER JOIN PROJETS on PP.PROJET_ID = PROJETS.ID
    ORDER BY PROJET_ID;

CREATE OR REPLACE VIEW Nombre_De_Projets AS
    SELECT UTILISATEURS.PRENOM, COUNT(PROJETS.NOM) AS NOMBRE_DE_PROJETS
    FROM UTILISATEURS
    INNER JOIN PARTICIPANTS_PROJETS PP on UTILISATEURS.ID = PP.UTILISATEUR_ID
    INNER JOIN PROJETS on PP.PROJET_ID = PROJETS.ID
    GROUP BY UTILISATEURS.PRENOM
    ORDER BY NOMBRE_DE_PROJETS DESC;

CREATE OR REPLACE VIEW Liste_Projets_Tickets_Noms AS
    SELECT PROJETS.NOM, TICKETS.SUJET
    FROM PROJETS
    INNER JOIN PROJETS_TICKETS PT on PROJETS.ID = PT.PROJET_ID
    INNER JOIN TICKETS on PT.TICKET_ID = TICKETS.ID;

-- END PROJETS --

CREATE OR REPLACE VIEW Logiciel_Par_Materiel AS
    SELECT MATERIELS.NOM, LOGICIELS.NOM as Logiciel_Nom
    FROM MATERIELS
    INNER JOIN MATERIEL_LOGICIELS LM on MATERIELS.ID = LM.MATERIEL_ID
    INNER JOIN LOGICIELS on LM.LOGICIEL_ID = LOGICIELS.ID;

CREATE OR REPLACE VIEW Materiel_Par_Utilisateur AS
    SELECT UTILISATEURS.PRENOM, MATERIELS.NOM
    FROM UTILISATEURS
    INNER JOIN MATERIELS on UTILISATEURS.ID = MATERIELS.UTILISATEUR_ID;

-- MATERIELS --
CREATE OR REPLACE VIEW Voir_Materiel_Vacant AS
    SELECT MATERIELS.NOM, MATERIELS.TYPE
    FROM MATERIELS
    WHERE UTILISATEUR_ID is NULL;

CREATE OR REPLACE VIEW Materiel_Fin_Garantie AS
    SELECT MATERIELS.NOM, MATERIELS.TYPE, MATERIELS.DATE_FIN_GARANTIE, UTILISATEURS.PRENOM, UTILISATEURS.NOM as UtilisateursNom
    FROM MATERIELS
    INNER JOIN UTILISATEURS on UTILISATEURS.id = MATERIELS.Utilisateur_id
    WHERE DATE_FIN_GARANTIE <= SYSDATE;

CREATE OR REPLACE VIEW Materiel_Defectueux AS
    SELECT MATERIELS.NOM, MATERIELS.TYPE, MATERIELS.ETAT, UTILISATEURS.PRENOM
    FROM MATERIELS
    INNER JOIN UTILISATEURS on UTILISATEURS.ID = MATERIELS.UTILISATEUR_ID
    WHERE MATERIELS.ETAT = 'detruit';

-- END MATERIELS --

-- LOGICIELS --

CREATE OR REPLACE VIEW Logiciel_Expire AS
    SELECT Logiciels.NOM, logiciels.DATE_ACHAT, logiciels.DATE_EXPIRATION as LogicielNom
    FROM Logiciels
    WHERE DATE_EXPIRATION <= SYSDATE;

-- END LOGICIELS --

-- TICKETS --
CREATE OR REPLACE VIEW Tickets_Par_Utilisateur AS
    SELECT UTILISATEURS.PRENOM, COUNT(TICKETS.ID) AS NOMBRE_DE_TICKETS
    FROM UTILISATEURS
    INNER JOIN TICKETS on UTILISATEURS.ID = TICKETS.UTILISATEUR_ID
    GROUP BY UTILISATEURS.PRENOM
    ORDER BY NOMBRE_DE_TICKETS DESC;


CREATE OR REPLACE VIEW Tickets_Par_Technicien AS
    SELECT UTILISATEURS.PRENOM, COUNT(TICKETS.ID) AS NOMBRE_DE_TICKETS
    FROM UTILISATEURS
    INNER JOIN TICKETS on UTILISATEURS.ID = TICKETS.TECHNICIEN_ID
    GROUP BY UTILISATEURS.PRENOM
    ORDER BY NOMBRE_DE_TICKETS DESC;

CREATE OR REPLACE VIEW Tickets_Par_Priorite AS
    SELECT TICKETS.PRIORITE, COUNT(TICKETS.ID) AS NOMBRE_DE_TICKETS
    FROM TICKETS
    GROUP BY TICKETS.PRIORITE
    ORDER BY NOMBRE_DE_TICKETS DESC;

CREATE OR REPLACE VIEW Tickets_Par_Status AS
    SELECT TICKETS.STATUS, COUNT(TICKETS.ID) AS NOMBRE_DE_TICKETS
    FROM TICKETS
    GROUP BY TICKETS.STATUS
    ORDER BY NOMBRE_DE_TICKETS DESC;

-- END TICKETS --

-- DONNEES DES TABLES --
-- INSERT UTILISATEURS --
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (1, 'Dupont', 'Jean', 'jean.dupont@gmail.com', '0645454566', 'admin');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (2, 'Martin', 'Marie', 'marie.martin@hotmail.fr', '0656789765', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (3, 'Dubois', 'Pierre', 'pierre.dubois@yahoo.com', '0678987689', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (4, 'Lefebvre', 'Sophie', 'sophie.lefebvre@orange.fr', '0634567890', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (5, 'Durand', 'Paul', 'paul.durand@gmail.com', '0687654321', 'admin');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (6, 'Benoit', 'Lucie', 'lucie.benoit@hotmail.com', '0612345678', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (7, 'Moreau', 'Julien', 'julien.moreau@yahoo.fr', '0698765432', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (8, 'Girard', 'Camille', 'camille.girard@gmail.com', '0678901234', 'admin');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (9, 'Rousseau', 'Antoine', 'antoine.rousseau@outlook.com', '0611223344', 'utilisateur');
INSERT INTO Utilisateurs (id, nom, prenom, email, telephone, role) VALUES (10, 'Lacroix', 'Nathalie', 'nathalie.lacroix@laposte.net', '0698989898', 'utilisateur');

-- INSERT MATERIEL --
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (1, 'Ordinateur portable', 'MacBook Pro 13 pouces', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 2);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (2, 'Imprimante', 'HP LaserJet Pro MFP M28w', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 3);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (3, 'Téléphone portable', 'Samsung Galaxy S21', TO_DATE('2021-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Téléphonie', 'Bon état', 4);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (4, 'Casque audio', 'Bose QuietComfort 35 II', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Audio', 'Neuf', 5);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (5, 'Scanner', 'Epson Perfection V370', TO_DATE('2021-11-01', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Informatique', 'Bon état', 6);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (6, 'Tablette', 'iPad Pro 12.9 pouces', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 7);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (7, 'Appareil photo', 'Sony Alpha 7 III', TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Photo', 'Bon état', 8);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (8, 'Clé USB', 'SanDisk Ultra Flair 64 Go', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 9);

-- INSERT LOGICIEL --
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (1, 'Microsoft Office 365', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (2, 'Adobe Photoshop', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2023-02-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (3, 'AutoCAD 2022', TO_DATE('2021-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (4, 'SketchUp Pro 2022', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-03-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (5, 'Visual Studio Code', TO_DATE('2021-11-01', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (6, 'Adobe Illustrator', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (7, 'MATLAB R2022a', TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (8, 'Blender', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (9, 'Sublime Text', TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO Logiciels (id, nom, date_achat, date_expiration) VALUES (10, 'MySQL', TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2023-09-01', 'YYYY-MM-DD'));

-- INSERT MATERIEL_LOGICIEL --
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (1, 1, 2);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (2, 3, 7);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (3, 4, 6);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (4, 5, 8);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (5, 2, 3);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (6, 1, 5);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (7, 3, 1);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (8, 4, 10);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (9, 5, 2);
INSERT INTO Materiel_logiciels (id, materiel_id, logiciel_id) VALUES (10, 2, 9);

-- INSERT TICKETS --
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (1, 'Problème de connexion', 'Je ne peux pas me connecter à mon compte', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Haute', 'En attente', 3, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (2, 'Problème d impression', 'Je ne peux pas imprimer de documents', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Moyenne', 'En cours de traitement', 4, 6);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (3, 'Problème de performance', 'Mon ordinateur est très lent', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Basse', 'Résolu', 2, 7);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (4, 'Problème de logiciel', 'Je ne peux pas ouvrir mon logiciel de traitement de texte', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Haute', 'En attente', 5, 9);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (5, 'Problème d accès', 'Je n ai pas accès à un dossier partagé', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Moyenne', 'Résolu', 1, 8);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (6, 'Problème de connexion', 'Je ne peux pas me connecter à Internet', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Haute', 'En cours de traitement', 6, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (7, 'Problème de messagerie', 'Je ne reçois pas mes emails', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Moyenne', 'Résolu', 3, 7);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (8, 'Problème d installation', 'Je ne peux pas installer un logiciel', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Basse', 'En attente', 4, 6);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (9, 'Problème de son', 'Je n ai pas de son sur mon ordinateur', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Moyenne', 'Résolu', 2, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (10, 'Problème de sauvegarde', 'Je ne peux pas sauvegarder mes fichiers', TO_DATE('2021-09-01', 'YYYY-MM-DD'), 'Haute', 'En cours de traitement', 1, 9);

-- INSERT PROJET --
INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (1, 'Projet A', 'Description du projet A', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 3);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (2, 'Projet B', 'Description du projet B', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 4);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (3, 'Projet C', 'Description du projet C', TO_DATE('2022-03-01', 'YYYY-MM-DD'), 2);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (4, 'Projet D', 'Description du projet D', TO_DATE('2022-04-01', 'YYYY-MM-DD'), 1);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (5, 'Projet E', 'Description du projet E', TO_DATE('2022-05-01', 'YYYY-MM-DD'), 5);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (6, 'Projet F', 'Description du projet F', TO_DATE('2022-06-01', 'YYYY-MM-DD'), 2);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (7, 'Projet G', 'Description du projet G', TO_DATE('2022-07-01', 'YYYY-MM-DD'), 1);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (8, 'Projet H', 'Description du projet H', TO_DATE('2022-08-01', 'YYYY-MM-DD'), 3);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (9, 'Projet I', 'Description du projet I', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 4);

INSERT INTO PROJETS (id, nom, description, date_creation, responsable_id)
VALUES (10, 'Projet J', 'Description du projet J', TO_DATE('2022-10-01', 'YYYY-MM-DD'), 5);


-- INSERT PARTICIPANTS_PROJETS --
INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (1, 2, 1);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (2, 3, 1);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (3, 4, 1);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (4, 2, 2);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (5, 5, 2);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (6, 3, 3);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (7, 4, 3);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (8, 5, 4);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (9, 1, 5);

INSERT INTO PARTICIPANTS_PROJETS (id, utilisateur_id, projet_id)
VALUES (10, 3, 5);

-- INSERT PROJETS_TICKETS --
INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (1, 1, 1);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (2, 2, 1);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (3, 3, 1);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (4, 4, 2);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (5, 5, 2);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (6, 6, 3);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (7, 7, 3);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (8, 8, 4);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (9, 9, 5);

INSERT INTO PROJETS_TICKETS (id, ticket_id, projet_id)
VALUES (10, 10, 5);

-- CREATION INDEX --
CREATE UNIQUE INDEX index_tickets_utilisateurID ON TICKETS(utilisateur_id);
CREATE UNIQUE INDEX index_materiel_date ON Materiels(date_fin_garantie);
CREATE UNIQUE INDEX index_logiciel_date ON Logiciels(date_expiration);
CREATE INDEX participants_projets_all ON PARTICIPANTS_PROJETS(UTILISATEUR_ID, PROJET_ID);

-- CREATION DU DATA LINK VERS PAU --

CREATE DATABASE LINK Pau_link2
CONNECT TO Pau IDENTIFIED BY Pau
USING 'XE';

-- VUE RESERVEE A CERGY --

CREATE OR REPLACE VIEW Noms_UtilisateursPau AS
  SELECT PRENOM, NOM
  FROM Utilisateurs@Pau_link2;
/