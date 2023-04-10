CREATE UNIQUE INDEX index_tickets_utilisateurID ON TICKETS(utilisateur_id);
CREATE UNIQUE INDEX index_materiel_date ON Materiels(date_fin_garantie);
CREATE UNIQUE INDEX index_logiciel_date ON Logiciels(date_expiration);
CREATE INDEX participants_projets_all ON PARTICIPANTS_PROJETS(UTILISATEUR_ID, PROJET_ID);

INSERT INTO UTILISATEURS (id,NOM, PRENOM, EMAIL, TELEPHONE, ROLE) VALUES (150, 'quentin', 'giova', 'qg@gmail.com', '0911', 'technicien');
DELETE FROM UTILISATEURS WHERE ID = 22;