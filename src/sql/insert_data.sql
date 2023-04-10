INSERT INTO Utilisateurs VALUES (0,'condamine', 'julien', 'cledupas@gmail.com','0658745285', 'user');
INSERT INTO Utilisateurs VALUES (1,'ledda', 'Alessia', 'aless@gmail.com','0601020304', 'professeur');
INSERT INTO Utilisateurs VALUES (2,'couchoude', 'Matt', 'bencouchoude@gmail.com','0695186420', 'user');
INSERT INTO Utilisateurs VALUES (3,'dupas', 'clem', 'clement@gmail.com','0612121212', 'technicien');

INSERT INTO PROJETS VALUES (0,'Projet 1', 'Description du projet 1', (TO_DATE('2005/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss')), 1);
INSERT INTO PROJETS VALUES (1,'Projet 2', 'Description du projet 2', (TO_DATE('2023/02/10 22:22:22', 'yyyy/mm/dd hh24:mi:ss')), 1);

INSERT INTO PARTICIPANTS_PROJETS VALUES (0, 1, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (1, 2, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (2, 3, 1);
INSERT INTO PARTICIPANTS_PROJETS VALUES (3, 1, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (4, 2, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (5, 0, 0);
INSERT INTO PARTICIPANTS_PROJETS VALUES (6, 0, 1);

INSERT INTO LOGICIELS VALUES (0,'Milanote', (TO_DATE('2020/05/03 21:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2023/06/10 10:00:00', 'yyyy/mm/dd hh24:mi:ss')));
INSERT INTO LOGICIELS VALUES (1,'PowerPoint', (TO_DATE('2022/01/01 10:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2023/02/10 10:00:00', 'yyyy/mm/dd hh24:mi:ss')));

INSERT INTO MATERIELS VALUES (0, 'Ordinateur', 'Ordinateur portable', (TO_DATE('2021/10/03 21:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2023/06/10 10:00:00', 'yyyy/mm/dd hh24:mi:ss')), 'Ordinateur', 'Parfait', 0);
INSERT INTO MATERIELS VALUES (1, 'Ordinateur Portable', 'Ordinateur portable HP-Elite 1200', (TO_DATE('2018/01/01 08:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2020/12/01 10:00:00', 'yyyy/mm/dd hh24:mi:ss')), 'Ordinateur', 'Abimé', 1);
INSERT INTO MATERIELS VALUES (2, 'Souris', 'Souris sans fil', (TO_DATE('2022/12/03 21:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2023/06/10 10:00:00', 'yyyy/mm/dd hh24:mi:ss')), 'Souris', 'Neuf', 0);
INSERT INTO MATERIELS VALUES (3, 'Clavier', 'Clavier sans fil', (TO_DATE('2020/05/03 21:00:00', 'yyyy/mm/dd hh24:mi:ss')), (TO_DATE('2023/06/10 10:00:00', 'yyyy/mm/dd hh24:mi:ss')), 'Clavier', 'Neuf', 1);

INSERT INTO MATERIEL_LOGICIELS VALUES (0, 0, 0);
INSERT INTO MATERIEL_LOGICIELS VALUES (1, 0, 1);
INSERT INTO MATERIEL_LOGICIELS VALUES (2, 1, 1);

INSERT INTO TICKETS (SUJET, DESCRIPTION, DATE_CREATION, PRIORITE, STATUS, UTILISATEUR_ID, TECHNICIEN_ID) VALUES ('Problème de connexion', 'Impossible de se connecter à la base de données', (TO_DATE('2021/05/03 21:00:00', 'yyyy/mm/dd hh24:mi:ss')), 'Moyenne', 'En cours', 0, 3);
