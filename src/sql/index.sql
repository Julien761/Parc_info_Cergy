CREATE INDEX index_tickets_utilisateurID ON TICKETS(utilisateur_id);
CREATE INDEX index_materiel_date ON Materiels(date_fin_garantie);
CREATE INDEX index_logiciel_date ON Logiciels(date_expiration);