USE club_sport;
GO

-- Procédure pour modifier les éléments de la table "Employés"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateEmployé')
    DROP PROCEDURE UpdateEmployé;
GO

CREATE PROCEDURE UpdateEmployé
    @ID INT,
    @Nom VARCHAR(255),
    @Salaire DECIMAL(10, 2)
AS
BEGIN
    UPDATE Employés
    SET Nom = @Nom,
        Salaire = @Salaire
    WHERE ID = @ID;
END;
GO

-- Procédure pour modifier les éléments de la table "Entraineurs"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateEntraineur')
    DROP PROCEDURE UpdateEntraineur;
GO

CREATE PROCEDURE UpdateEntraineur
    @ID INT,
    @Spécialité VARCHAR(255)
AS
BEGIN
    UPDATE Entraineurs
    SET Spécialité = @Spécialité
    WHERE ID = @ID;
END;
GO

-- Procédure pour modifier les éléments de la table "Autres"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateAutre')
    DROP PROCEDURE UpdateAutre;
GO

CREATE PROCEDURE UpdateAutre
    @ID INT,
    @Fonction VARCHAR(255)
AS
BEGIN
    UPDATE Autres
    SET Fonction = @Fonction
    WHERE ID = @ID;
END;
GO

-- Procédure pour modifier les éléments de la table "Clients"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateClient')
    DROP PROCEDURE UpdateClient;
GO

CREATE PROCEDURE UpdateClient
    @ID INT,
    @Nom VARCHAR(255),
    @Adresse VARCHAR(255),
    @Numéro_de_téléphone VARCHAR(20),
    @Adresse_email VARCHAR(255),
    @Paiement_réglé BIT
AS
BEGIN
    UPDATE Clients
    SET Nom = @Nom,
        Adresse = @Adresse,
        Numéro_de_téléphone = @Numéro_de_téléphone,
        Adresse_email = @Adresse_email,
        Paiement_réglé = @Paiement_réglé
    WHERE ID = @ID;
END;
GO

-- Procédure pour modifier les éléments de la table "Salles"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateSalle')
    DROP PROCEDURE UpdateSalle;
GO

CREATE PROCEDURE UpdateSalle
    @ID INT,
    @Nom_de_la_salle VARCHAR(255)
AS
BEGIN
    UPDATE Salles
    SET Nom_de_la_salle = @Nom_de_la_salle
    WHERE ID = @ID;
END;
GO

-- Procédure pour modifier les éléments de la table "Activités"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateActivité')
    DROP PROCEDURE UpdateActivité;
GO

CREATE PROCEDURE UpdateActivité
    @ID INT,
    @Nom_de_l_activité VARCHAR(255),
    @ID_entraîneur INT,
    @Date_de_début DATE,
    @ID_salle INT,
    @Heure_de_début TIME,
    @Heure_de_fin TIME,
    @Limite_participants INT
AS
BEGIN
    UPDATE Activités
    SET Nom_de_l_activité = @Nom_de_l_activité,
        ID_entraîneur = @ID_entraîneur,
        Date_de_début = @Date_de_début,
        ID_salle = @ID_salle,
        Heure_de_début = @Heure_de_début,
        Heure_de_fin = @Heure_de_fin,
        Limite_participants = @Limite_participants
    WHERE ID = @ID;
END;
GO

CREATE PROCEDURE ModifierForfait
    @ID INT,
    @Nom_du_forfait VARCHAR(255),
    @Description VARCHAR(MAX),
    @Prix DECIMAL(10, 2)
AS
BEGIN
    UPDATE Forfaits
    SET Nom_du_forfait = @Nom_du_forfait,
        Description = @Description,
        Prix = @Prix
    WHERE ID = @ID;
END;
GO

CREATE PROCEDURE ModifierAbonnement
    @ID_client INT,
    @ID INT,
    @Date_de_début DATE,
    @Date_de_fin DATE
AS
BEGIN
    UPDATE Abonnements
    SET ID_forfait = @ID,
        Date_de_début = @Date_de_début,
        Date_de_fin = @Date_de_fin
    WHERE ID_client = @ID_client;
END;
GO

CREATE PROCEDURE ModifierParticipation
    @ID_client INT,
    @ID_activité INT
AS
BEGIN
    UPDATE Participations
    SET ID_activité = @ID_activité
    WHERE ID_client = @ID_client;
END;
GO

CREATE PROCEDURE ModifierÉquipement
    @ID INT,
    @ID_salle INT,
    @État VARCHAR(255)
AS
BEGIN
    UPDATE Équipements
    SET ID_salle = @ID_salle,
        État = @État
    WHERE ID = @ID;
END;
GO
