CREATE DATABASE IF NOT EXISTS GLPIRefacto;

CREATE TABLE IF NOT EXISTS `GLPIRefacto`.Users (
    idUsers int(2000) AUTO_INCREMENT PRIMARY KEY,
    nom varchar(30) NOT NULL,
    prenom varchar(30) NOT NULL,
    sexe varchar(2) NOT NULL,
    mail varchar(50) NOT NULL,
    mdp varchar(50) NOT NULL,
    birth date NOT NULL
);