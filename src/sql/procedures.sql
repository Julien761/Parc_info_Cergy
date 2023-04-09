CREATE OR REPLACE PROCEDURE Update_Ticket_Status (p_ticket_id IN NUMBER, p_status IN VARCHAR2) AS
    BEGIN
        UPDATE TICKETS SET STATUS = p_status WHERE ID = p_ticket_id;
    END Update_Ticket_Status;

CREATE OR REPLACE PROCEDURE Ajouter_Participant_Projet (projet_id IN NUMBER, participant_id IN NUMBER) AS
    BEGIN
        INSERT INTO PARTICIPANTS_PROJETS (UTILISATEUR_ID, PROJET_ID) VALUES (participant_id, projet_id);
    END Ajouter_Participant_Projet;

CREATE OR REPLACE PROCEDURE Supprimer_Participant_Projet (projet_id IN NUMBER, participant_id IN NUMBER) AS
    BEGIN
        DELETE FROM PARTICIPANTS_PROJETS
            WHERE PROJET_ID = projet_id AND UTILISATEUR_ID = participant_id;
    END;

CREATE OR REPLACE PROCEDURE Maj_Etat_Materiel (id_materiel IN NUMBER, etat IN VARCHAR(200)) AS
    BEGIN
        UPDATE MATERIELS
            SET ETAT = etat
            WHERE MATERIELS.ID = id_materiel;
    END;


-- LIGNE DE DROIT D'EXECUTUION DE CERTAINE PROCEDURE POUR PAU
--REVOKE EXECUTE ON Supprimer_Participant_Projet FROM admin;























