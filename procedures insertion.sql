-- Procédure pour l'insertion dans la table "Employés"
CREATE PROCEDURE InsertEmployé
    @Nom VARCHAR(255),
    @Salaire DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Employés (Nom, Salaire)
    VALUES (@Nom, @Salaire);
END;

-- Procédure pour l'insertion dans la table "Entraineurs"
CREATE PROCEDURE InsertEntraineur
    @Spécialité VARCHAR(255)
AS
BEGIN
    DECLARE @ID INT;

    INSERT INTO Employés (Nom, Salaire)
    VALUES ('', 0);

    SET @ID = SCOPE_IDENTITY();

    INSERT INTO Entraineurs (ID, Spécialité)
    VALUES (@ID, @Spécialité);
END;

-- Procédure pour l'insertion dans la table "Autres"
CREATE PROCEDURE InsertAutre
    @Fonction VARCHAR(255)
AS
BEGIN
    DECLARE @ID INT;

    INSERT INTO Employés (Nom, Salaire)
    VALUES ('', 0);

    SET @ID = SCOPE_IDENTITY();

    INSERT INTO Autres (ID, Fonction)
    VALUES (@ID, @Fonction);
END;

-- Procédure pour l'insertion dans la table "Clients"
CREATE PROCEDURE InsertClient
    @Nom VARCHAR(255),
    @Adresse VARCHAR(255),
    @Numéro_de_téléphone VARCHAR(20),
    @Adresse_email VARCHAR(255),
    @Paiement_réglé BIT
AS
BEGIN
    INSERT INTO Clients (Nom, Adresse, Numéro_de_téléphone, Adresse_email, Paiement_réglé)
    VALUES (@Nom, @Adresse, @Numéro_de_téléphone, @Adresse_email, @Paiement_réglé);
END;

-- Procédure pour l'insertion dans la table "Salles"
CREATE PROCEDURE InsertSalle
    @Nom_de_la_salle VARCHAR(255)
AS
BEGIN
    INSERT INTO Salles (Nom_de_la_salle)
    VALUES (@Nom_de_la_salle);
END;

-- Procédure pour l'insertion dans la table "Activités"
CREATE PROCEDURE InsertActivité
    @Nom_de_l_activité VARCHAR(255),
    @ID_entraîneur INT,
    @Date_de_début DATE,
    @ID_salle INT,
    @Heure_de_début TIME,
    @Heure_de_fin TIME,
    @Limite_participants INT
AS
BEGIN
    INSERT INTO Activités (Nom_de_l_activité, ID_entraîneur, Date_de_début, ID_salle, Heure_de_début, Heure_de_fin, Limite_participants)
    VALUES (@Nom_de_l_activité, @ID_entraîneur, @Date_de_début, @ID_salle, @Heure_de_début, @Heure_de_fin, @Limite_participants);
END;

-- Procédure pour l'insertion dans la table "Forfaits"
CREATE PROCEDURE InsertForfait
    @Nom_du_forfait VARCHAR(255),
    @Description VARCHAR(MAX),
    @Prix DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Forfaits (Nom_du_forfait, Description, Prix)
    VALUES (@Nom_du_forfait, @Description, @Prix);
END;

-- Procédure pour l'insertion dans la table "Abonnements"
CREATE PROCEDURE InsertAbonnement
    @ID_client INT,
    @ID_forfait INT,
    @Date_de_début DATE,
    @Date_de_fin DATE
AS
BEGIN
    INSERT INTO Abonnements (ID_client, ID_forfait, Date_de_début, Date_de_fin)
    VALUES (@ID_client, @ID_forfait, @Date_de_début, @Date_de_fin);
END;

-- Procédure pour l'insertion dans la table "Participations"
CREATE PROCEDURE InsertParticipation
    @ID_client INT,
    @ID_activité INT
AS
BEGIN
    INSERT INTO Participations (ID_client, ID_activité)
    VALUES (@ID_client, @ID_activité);
END;

-- Procédure pour l'insertion dans la table "Forfait_Activité"
CREATE PROCEDURE InsertForfaitActivité
    @ID_forfait INT,
    @ID_activité INT
AS
BEGIN
    INSERT INTO Forfait_Activité (ID_forfait, ID_activité)
    VALUES (@ID_forfait, @ID_activité);
END;

-- Procédure pour l'insertion dans la table "Équipements"
CREATE PROCEDURE InsertÉquipement
    @Nom_de_l_équipement VARCHAR(255),
    @ID_salle INT,
    @État VARCHAR(255)
AS
BEGIN
    INSERT INTO Équipements (Nom_de_l_équipement, ID_salle, État)
    VALUES (@Nom_de_l_équipement, @ID_salle, @État);
END;
