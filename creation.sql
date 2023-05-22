USE club_sport;
GO

-- Création de la table "Employés" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employés')
BEGIN
    CREATE TABLE Employés (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom VARCHAR(255),
        Salaire DECIMAL(10, 2)
    );
END;

-- Création de la table "Entraineurs" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entraineurs')
BEGIN
    CREATE TABLE Entraineurs (
        ID INT PRIMARY KEY,
        Spécialité VARCHAR(255),
        FOREIGN KEY (ID) REFERENCES Employés (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Création de la table "Autres" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Autres')
BEGIN
    CREATE TABLE Autres (
        ID INT PRIMARY KEY,
        Fonction VARCHAR(255),
        FOREIGN KEY (ID) REFERENCES Employés (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Création de la table "Clients" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Clients')
BEGIN
    CREATE TABLE Clients (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom VARCHAR(255),
        Adresse VARCHAR(255),
        Numéro_de_téléphone VARCHAR(20),
        Adresse_email VARCHAR(255),
        Paiement_réglé BIT
    );
END;

-- Création de la table "Salles" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Salles')
BEGIN
    CREATE TABLE Salles (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_la_salle VARCHAR(255)
    );
END;

-- Création de la table "Activités" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activités')
BEGIN
    CREATE TABLE Activités (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_l_activité VARCHAR(255),
        ID_entraîneur INT,
        Date_de_début DATE,
        ID_salle INT,
        Heure_de_début TIME,
        Heure_de_fin TIME,
        FOREIGN KEY (ID_entraîneur) REFERENCES Entraineurs (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_salle) REFERENCES Salles (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        Limite_participants INT
    );
END;

-- Création de la table "Forfaits" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Forfaits')
BEGIN
    CREATE TABLE Forfaits (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_du_forfait VARCHAR(255),
        Description VARCHAR(MAX),
        Prix DECIMAL(10, 2)
    );
END;

-- Création de la table "Abonnements" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Abonnements')
BEGIN
    CREATE TABLE Abonnements (
        ID_client INT,
        ID_forfait INT,
        Date_de_début DATE,
        Date_de_fin DATE,
        FOREIGN KEY (ID_client) REFERENCES Clients (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_forfait) REFERENCES Forfaits (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Création de la table "Participations" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Participations')
BEGIN
    CREATE TABLE Participations (
        ID_client INT,
        ID_activité INT,
        FOREIGN KEY (ID_client) REFERENCES Clients (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_activité) REFERENCES Activités (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Création de la table "Forfait_Activité" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Forfait_Activité')
BEGIN
    CREATE TABLE Forfait_Activité (
        ID_forfait INT,
        ID_activité INT,
        FOREIGN KEY (ID_forfait) REFERENCES Forfaits (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_activité) REFERENCES Activités (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (ID_forfait, ID_activité)
    );
END;

-- Création de la table "Équipements" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Équipements')
BEGIN
    CREATE TABLE Équipements (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_l_équipement VARCHAR(255),
        ID_salle INT,
        État VARCHAR(255),
        FOREIGN KEY (ID_salle) REFERENCES Salles (ID) ON UPDATE CASCADE
    );
END;
