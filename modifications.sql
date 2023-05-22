USE club_sport;
GO

-- Proc�dure pour modifier les �l�ments de la table "Employ�s"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateEmploy�')
    DROP PROCEDURE UpdateEmploy�;
GO

CREATE PROCEDURE UpdateEmploy�
    @ID INT,
    @Nom VARCHAR(255),
    @Salaire DECIMAL(10, 2)
AS
BEGIN
    UPDATE Employ�s
    SET Nom = @Nom,
        Salaire = @Salaire
    WHERE ID = @ID;
END;
GO

-- Proc�dure pour modifier les �l�ments de la table "Entraineurs"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateEntraineur')
    DROP PROCEDURE UpdateEntraineur;
GO

CREATE PROCEDURE UpdateEntraineur
    @ID INT,
    @Sp�cialit� VARCHAR(255)
AS
BEGIN
    UPDATE Entraineurs
    SET Sp�cialit� = @Sp�cialit�
    WHERE ID = @ID;
END;
GO

-- Proc�dure pour modifier les �l�ments de la table "Autres"
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

-- Proc�dure pour modifier les �l�ments de la table "Clients"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateClient')
    DROP PROCEDURE UpdateClient;
GO

CREATE PROCEDURE UpdateClient
    @ID INT,
    @Nom VARCHAR(255),
    @Adresse VARCHAR(255),
    @Num�ro_de_t�l�phone VARCHAR(20),
    @Adresse_email VARCHAR(255),
    @Paiement_r�gl� BIT
AS
BEGIN
    UPDATE Clients
    SET Nom = @Nom,
        Adresse = @Adresse,
        Num�ro_de_t�l�phone = @Num�ro_de_t�l�phone,
        Adresse_email = @Adresse_email,
        Paiement_r�gl� = @Paiement_r�gl�
    WHERE ID = @ID;
END;
GO

-- Proc�dure pour modifier les �l�ments de la table "Salles"
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

-- Proc�dure pour modifier les �l�ments de la table "Activit�s"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'UpdateActivit�')
    DROP PROCEDURE UpdateActivit�;
GO

CREATE PROCEDURE UpdateActivit�
    @ID INT,
    @Nom_de_l_activit� VARCHAR(255),
    @ID_entra�neur INT,
    @Date_de_d�but DATE,
    @ID_salle INT,
    @Heure_de_d�but TIME,
    @Heure_de_fin TIME,
    @Limite_participants INT
AS
BEGIN
    UPDATE Activit�s
    SET Nom_de_l_activit� = @Nom_de_l_activit�,
        ID_entra�neur = @ID_entra�neur,
        Date_de_d�but = @Date_de_d�but,
        ID_salle = @ID_salle,
        Heure_de_d�but = @Heure_de_d�but,
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
    @Date_de_d�but DATE,
    @Date_de_fin DATE
AS
BEGIN
    UPDATE Abonnements
    SET ID_forfait = @ID,
        Date_de_d�but = @Date_de_d�but,
        Date_de_fin = @Date_de_fin
    WHERE ID_client = @ID_client;
END;
GO

CREATE PROCEDURE ModifierParticipation
    @ID_client INT,
    @ID_activit� INT
AS
BEGIN
    UPDATE Participations
    SET ID_activit� = @ID_activit�
    WHERE ID_client = @ID_client;
END;
GO

CREATE PROCEDURE Modifier�quipement
    @ID INT,
    @ID_salle INT,
    @�tat VARCHAR(255)
AS
BEGIN
    UPDATE �quipements
    SET ID_salle = @ID_salle,
        �tat = @�tat
    WHERE ID = @ID;
END;
GO
