USE club_sport;
GO

-- Cr�ation de la table "Employ�s" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employ�s')
BEGIN
    CREATE TABLE Employ�s (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom VARCHAR(255),
        Salaire DECIMAL(10, 2)
    );
END;

-- Cr�ation de la table "Entraineurs" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Entraineurs')
BEGIN
    CREATE TABLE Entraineurs (
        ID INT PRIMARY KEY,
        Sp�cialit� VARCHAR(255),
        FOREIGN KEY (ID) REFERENCES Employ�s (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Cr�ation de la table "Autres" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Autres')
BEGIN
    CREATE TABLE Autres (
        ID INT PRIMARY KEY,
        Fonction VARCHAR(255),
        FOREIGN KEY (ID) REFERENCES Employ�s (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Cr�ation de la table "Clients" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Clients')
BEGIN
    CREATE TABLE Clients (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom VARCHAR(255),
        Adresse VARCHAR(255),
        Num�ro_de_t�l�phone VARCHAR(20),
        Adresse_email VARCHAR(255),
        Paiement_r�gl� BIT
    );
END;

-- Cr�ation de la table "Salles" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Salles')
BEGIN
    CREATE TABLE Salles (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_la_salle VARCHAR(255)
    );
END;

-- Cr�ation de la table "Activit�s" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activit�s')
BEGIN
    CREATE TABLE Activit�s (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_l_activit� VARCHAR(255),
        ID_entra�neur INT,
        Date_de_d�but DATE,
        ID_salle INT,
        Heure_de_d�but TIME,
        Heure_de_fin TIME,
        FOREIGN KEY (ID_entra�neur) REFERENCES Entraineurs (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_salle) REFERENCES Salles (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        Limite_participants INT
    );
END;

-- Cr�ation de la table "Forfaits" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Forfaits')
BEGIN
    CREATE TABLE Forfaits (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_du_forfait VARCHAR(255),
        Description VARCHAR(MAX),
        Prix DECIMAL(10, 2)
    );
END;

-- Cr�ation de la table "Abonnements" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Abonnements')
BEGIN
    CREATE TABLE Abonnements (
        ID_client INT,
        ID_forfait INT,
        Date_de_d�but DATE,
        Date_de_fin DATE,
        FOREIGN KEY (ID_client) REFERENCES Clients (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_forfait) REFERENCES Forfaits (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Cr�ation de la table "Participations" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Participations')
BEGIN
    CREATE TABLE Participations (
        ID_client INT,
        ID_activit� INT,
        FOREIGN KEY (ID_client) REFERENCES Clients (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_activit�) REFERENCES Activit�s (ID) ON UPDATE CASCADE ON DELETE CASCADE
    );
END;

-- Cr�ation de la table "Forfait_Activit�" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Forfait_Activit�')
BEGIN
    CREATE TABLE Forfait_Activit� (
        ID_forfait INT,
        ID_activit� INT,
        FOREIGN KEY (ID_forfait) REFERENCES Forfaits (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY (ID_activit�) REFERENCES Activit�s (ID) ON UPDATE CASCADE ON DELETE CASCADE,
        PRIMARY KEY (ID_forfait, ID_activit�)
    );
END;

-- Cr�ation de la table "�quipements" si elle n'existe pas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '�quipements')
BEGIN
    CREATE TABLE �quipements (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nom_de_l_�quipement VARCHAR(255),
        ID_salle INT,
        �tat VARCHAR(255),
        FOREIGN KEY (ID_salle) REFERENCES Salles (ID) ON UPDATE CASCADE
    );
END;
