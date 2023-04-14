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

INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (1, 'Ordinateur portable', 'MacBook Pro 13 pouces', TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 2);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (2, 'Imprimante', 'HP LaserJet Pro MFP M28w', TO_DATE('2022-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 3);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (3, 'Téléphone portable', 'Samsung Galaxy S21', TO_DATE('2021-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Téléphonie', 'Bon état', 4);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (4, 'Casque audio', 'Bose QuietComfort 35 II', TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Audio', 'Neuf', 5);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (5, 'Scanner', 'Epson Perfection V370', TO_DATE('2021-11-01', 'YYYY-MM-DD'), TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Informatique', 'Bon état', 6);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (6, 'Tablette', 'iPad Pro 12.9 pouces', TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 7);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (7, 'Appareil photo', 'Sony Alpha 7 III', TO_DATE('2021-10-01', 'YYYY-MM-DD'), TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Photo', 'Bon état', 8);
INSERT INTO Materiels (id, nom, description, date_achat, date_fin_garantie, type, etat, utilisateur_id) VALUES (8, 'Clé USB', 'SanDisk Ultra Flair 64 Go', TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Informatique', 'Neuf', 9);

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

INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (1, 'Problème de connexion', 'Je ne peux pas me connecter à mon compte', '2023-04-12', 'Haute', 'En attente', 3, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (2, 'Problème d''impression', 'Je ne peux pas imprimer de documents', '2023-04-11', 'Moyenne', 'En cours de traitement', 4, 6);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (3, 'Problème de performance', 'Mon ordinateur est très lent', '2023-04-10', 'Basse', 'Résolu', 2, 7);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (4, 'Problème de logiciel', 'Je ne peux pas ouvrir mon logiciel de traitement de texte', '2023-04-09', 'Haute', 'En attente', 5, 9);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (5, 'Problème d''accès', 'Je n''ai pas accès à un dossier partagé', '2023-04-08', 'Moyenne', 'Résolu', 1, 8);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (6, 'Problème de connexion', 'Je ne peux pas me connecter à Internet', '2023-04-07', 'Haute', 'En cours de traitement', 6, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (7, 'Problème de messagerie', 'Je ne reçois pas mes emails', '2023-04-06', 'Moyenne', 'Résolu', 3, 7);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (8, 'Problème d''installation', 'Je ne peux pas installer un logiciel', '2023-04-05', 'Basse', 'En attente', 4, 6);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (9, 'Problème de son', 'Je n''ai pas de son sur mon ordinateur', '2023-04-04', 'Moyenne', 'Résolu', 2, 5);
INSERT INTO TICKETS (id, sujet, description, date_creation, priorite, status, utilisateur_id, technicien_id) VALUES (10, 'Problème de sauvegarde', 'Je ne peux pas sauvegarder mes fichiers', '2023-04-03', 'Haute', 'En cours de traitement', 1, 9);

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