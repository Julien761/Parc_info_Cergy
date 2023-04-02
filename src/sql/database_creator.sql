-- commande pour ne pas avoir à mettre c## devant les noms d'users.
alter session set "_ORACLE_SCRIPT"=true;

-- création tablespace où sont stockées les données des sites Cergy et Pau
CREATE TABLESPACE sites 
   DATAFILE 'sites_data.dbf' 
   SIZE 4m;

-- création des sites Cergy et Pau : émulé par 2 utilisateurs
CREATE USER Cergy
    IDENTIFIED BY Cergy
    DEFAULT TABLESPACE sites;

CREATE USER Pau
    IDENTIFIED BY Pau
    DEFAULT TABLESPACE sites;

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


