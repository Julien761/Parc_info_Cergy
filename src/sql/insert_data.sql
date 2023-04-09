INSERT INTO Utilisateurs VALUES (0,'condamine', 'julien', 'cledupas@gmail.com','0658745285');
INSERT INTO Utilisateurs VALUES (0,'ledda', 'Alessia', 'aless@gmail.com','0601020304');
INSERT INTO Utilisateurs VALUES (0,'couchoude', 'Matt', 'bencouchoude@gmail.com','0695186420');
INSERT INTO Utilisateurs VALUES (0,'dupas', 'clem', 'clement@gmail.com','0612121212');
SELECT * FROM Utilisateurs;

INSERT INTO PROJETS VALUES (0,'Projet 1', 'Description du projet 1', (TO_DATE('2005/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss')), 1);
INSERT INTO PROJETS VALUES (1,'Projet 2', 'Description du projet 2', (TO_DATE('2023/02/10 22:22:22', 'yyyy/mm/dd hh24:mi:ss')), 1);

INSERT INTO PARTICIPANTS_PROJETS VALUES (0, 1, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (1, 2, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (2, 3, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (3, 1, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (4, 2, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (5, 0, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (6, 0, 1);
