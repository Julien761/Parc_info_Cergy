-- commande pour ne pas avoir à mettre c## devant les noms d'users.
alter session set "_ORACLE_SCRIPT"=true;
-- création tablespace où sont stockées les données des sites Cergy et Pau
CREATE TABLESPACE stockageCergy
    DATAFILE 'stockageCergy_data.dbf'
    SIZE 100m;

CREATE TABLESPACE stockagePau
    DATAFILE 'stockagePau_data.dbf'
    SIZE 100m;

-- création des sites Cergy et Pau : émulé par 2 utilisateurs
CREATE USER Cergy
    IDENTIFIED BY Cergy
    DEFAULT TABLESPACE stockageCergy;

CREATE USER Pau
    IDENTIFIED BY Pau
    DEFAULT TABLESPACE stockagePau;

CREATE ROLE super_admin;
GRANT CREATE DATABASE LINK, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE, CREATE SESSION, CREATE VIEW, DROP USER, DROP TABLESPACE, CREATE ANY TABLE TO super_admin;
GRANT super_admin TO Cergy;

CREATE ROLE local_admin;
GRANT CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE, CREATE SESSION, CREATE VIEW, CREATE ANY TABLE TO local_admin;
GRANT local_admin TO Pau;

ALTER USER Cergy quota unlimited on stockageCergy;
ALTER USER Pau quota unlimited on stockagePau;

-- debug : vérifie que les 2 utilisateurs sont bien créés
SELECT 
    username,
    default_tablespace,
    profile,
    authentication_type
FROM 
    dba_users
WHERE 
    account_status = 'OPEN';

CREATE DATABASE LINK Pau_link2
CONNECT TO Pau IDENTIFIED BY Pau
USING 'XE';

SELECT * FROM Utilisateurs@Pau_link2;
SELECT * FROM Utilisateurs;


INSERT INTO Utilisateurs@Pau_link2 VALUES (1,'condamine', 'julien', 'cledupas@gmail.com','0658745285', 'user');
/





