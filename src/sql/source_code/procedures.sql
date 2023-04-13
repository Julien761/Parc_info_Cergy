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
CREATE OR REPLACE PROCEDURE Maj_Etat_Materiel (id_materiel IN NUMBER, etat IN VARCHAR(200)) AS
    BEGIN
        UPDATE MATERIELS
            SET ETAT = etat
            WHERE MATERIELS.ID = id_materiel;
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




-- LIGNE DE DROIT D'EXECUTUION DE CERTAINE PROCEDURE POUR PAU
--REVOKE EXECUTE ON Supprimer_Participant_Projet FROM admin;
/






















