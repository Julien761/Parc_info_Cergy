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

GRANT CREATE SESSION, CREATE ANY TABLE TO Cergy;
GRANT CREATE SESSION, CREATE ANY TABLE TO Pau;
GRANT CREATE SEQUENCE, CREATE TRIGGER TO Cergy;
GRANT CREATE SEQUENCE, CREATE TRIGGER TO Pau;
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


