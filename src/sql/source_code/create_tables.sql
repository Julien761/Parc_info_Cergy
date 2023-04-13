CREATE TABLE Utilisateurs (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(50) NOT NULL,
  prenom VARCHAR2(50) NOT NULL,
  email VARCHAR2(100),
  telephone VARCHAR2(20),
  role VARCHAR2(20) NOT NULL
);
CREATE SEQUENCE Utilisateurs_seq
START WITH 1;

CREATE TABLE Materiels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR2(100) NOT NULL,
  description VARCHAR2(200),
  date_achat DATE,
  date_fin_garantie DATE,
  type VARCHAR2(20),
  etat VARCHAR2(20),
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE Materiels_seq
START WITH 1;

CREATE TABLE Logiciels (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  date_achat DATE,
  date_expiration DATE
);
CREATE SEQUENCE Logiciels_seq
START WITH 1;

CREATE TABLE Materiel_logiciels (
  id NUMBER(10) PRIMARY KEY,
  materiel_id NUMBER(10),
  FOREIGN KEY (materiel_id) REFERENCES Materiels(id),
  logiciel_id NUMBER(10),
  FOREIGN KEY (logiciel_id) REFERENCES Logiciels(id)
);
CREATE SEQUENCE Materiel_logiciels_seq
START WITH 1;

CREATE TABLE TICKETS (
  id NUMBER(10) PRIMARY KEY,
  sujet VARCHAR(100) NOT NULL,
  description VARCHAR(510) NOT NULL,
  date_creation DATE NOT NULL,
  priorite VARCHAR(20) NOT NULL,
  status VARCHAR(20),
  utilisateur_id NUMBER(10) NOT NULL,
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
  technicien_id NUMBER(10),
  FOREIGN KEY (technicien_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE TICKETS_seq
START WITH 1;

CREATE TABLE PROJETS (
  id NUMBER(10) PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  description VARCHAR(510) NOT NULL,
  date_creation DATE,
  responsable_id NUMBER(10) NOT NULL,
  FOREIGN KEY (responsable_id) REFERENCES Utilisateurs(id)
);
CREATE SEQUENCE PROJETS_seq
START WITH 1;

CREATE TABLE PARTICIPANTS_PROJETS (
  id NUMBER(10) PRIMARY KEY,
  utilisateur_id NUMBER(10),
  FOREIGN KEY (utilisateur_id) REFERENCES Utilisateurs(id),
  projet_id NUMBER(10),
  FOREIGN KEY (projet_id) REFERENCES PROJETS(id)
);

CREATE SEQUENCE PARTICIPANTS_PROJETS_seq
START WITH 1;

CREATE TABLE PROJETS_TICKETS (
  id NUMBER(10) PRIMARY KEY,
  ticket_id NUMBER(10),
  FOREIGN KEY (ticket_id) REFERENCES TICKETS(id),
  projet_id NUMBER(10),
  FOREIGN KEY (projet_id) REFERENCES PROJETS(id)
);
CREATE SEQUENCE PROJETS_TICKETS_seq
START WITH 1;
/