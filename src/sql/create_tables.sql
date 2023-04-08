CREATE TABLE Utilisateurs (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(50) NOT NULL,
  prenom VARCHAR2(50) NOT NULL,
  email VARCHAR2(100),
  telephone VARCHAR2(20)
);

CREATE SEQUENCE Utilisateurs_seq;

CREATE TABLE Materiels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(100) NOT NULL,
  description VARCHAR2(200),
  date_achat DATE,
  date_fin_garantie DATE,
  etat VARCHAR2(20)
);

CREATE TABLE Logiciels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  date_achat DATE,
  date_expiraton DATE
);

CREATE TABLE TICKETS (
  id NUMBER(10) PRIMARY KEY,
  sujet VARCHAR(100) NOT NULL,
  description VARCHAR(510),
  date_creation DATE,
  priorite NUMBER(10),
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id)
);

CREATE TABLE PROJETS (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  description VARCHAR(510),
  date_creation DATE,
  responsable_id NUMBER(10),
  FOREIGN KEY (responsable_id) REFERENCES Utilisateurs(id)
);

CREATE TABLE PARTICIPANTS_PROJETS (
  id NUMBER(10) PRIMARY KEY,
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
  projet_id NUMBER(10),
  FOREIGN KEY (projet_id) REFERENCES PROJETS(id)
);