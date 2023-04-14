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

CREATE OR REPLACE VIEW Noms_UtilisateursPau AS
  SELECT PRENOM, NOM
  FROM Utilisateurs@Pau_link2;
/