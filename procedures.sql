use club_sport;
go


-- Procédure pour afficher les éléments de la table "Employés"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetEmployés')
    DROP PROCEDURE GetEmployés;
GO

CREATE PROCEDURE GetEmployés
AS
BEGIN
    SELECT * FROM Employés;
END;
GO

-- Procédure pour afficher les éléments de la table "Entraineurs"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetEntraineurs')
    DROP PROCEDURE GetEntraineurs;
GO

CREATE PROCEDURE GetEntraineurs
AS
BEGIN
    SELECT * FROM Entraineurs;
END;
GO

-- Procédure pour afficher les éléments de la table "Autres"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAutres')
    DROP PROCEDURE GetAutres;
GO

CREATE PROCEDURE GetAutres
AS
BEGIN
    SELECT * FROM Autres;
END;
GO

-- Procédure pour afficher les éléments de la table "Clients"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetClients')
    DROP PROCEDURE GetClients;
GO

CREATE PROCEDURE GetClients
AS
BEGIN
    SELECT * FROM Clients;
END;
GO



-- Procédure pour afficher les éléments de la table "Salles"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSalles')
    DROP PROCEDURE GetSalles;
GO
CREATE PROCEDURE GetSalles
AS
BEGIN
    SELECT * FROM Salles;
END;
GO

-- Procédure pour afficher les éléments de la table "Activités"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetActivités')
    DROP PROCEDURE GetActivités;
GO

CREATE PROCEDURE GetActivités
AS
BEGIN
    SELECT * FROM Activités;
END;
GO

-- Procédure pour afficher les éléments de la table "Forfaits"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetForfaits')
    DROP PROCEDURE GetForfaits;
GO

CREATE PROCEDURE GetForfaits
AS
BEGIN
    SELECT * FROM Forfaits;
END;
GO

-- Procédure pour afficher les éléments de la table "Abonnements"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAbonnements')
    DROP PROCEDURE GetAbonnements;
GO

CREATE PROCEDURE GetAbonnements
AS
BEGIN
    SELECT * FROM Abonnements;
END;
GO

-- Procédure pour afficher les éléments de la table "Participations"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetParticipations')
    DROP PROCEDURE GetParticipations;
GO

CREATE PROCEDURE GetParticipations
AS
BEGIN
    SELECT * FROM Participations;
END;
GO

-- Procédure pour afficher les éléments de la table "Forfait_Activité"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetForfait_Activité')
    DROP PROCEDURE GetForfait_Activité;
GO

CREATE PROCEDURE GetForfait_Activité
AS
BEGIN
    SELECT * FROM Forfait_Activité;
END;
GO

-- Procédure pour afficher les éléments de la table "Équipements"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetÉquipements')
    DROP PROCEDURE GetÉquipements;
GO

CREATE PROCEDURE GetÉquipements
AS
BEGIN
    SELECT * FROM Équipements;
END;
GO


-------statistiques actiites-----
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetStatistiquesActivités')
    DROP PROCEDURE GetStatistiquesActivités;
GO

CREATE PROCEDURE GetStatistiquesActivités
AS
BEGIN
    -- Nombre de clients inscrits à chaque activité
    SELECT a.ID AS ID_activité, a.Nom_de_l_activité, COUNT(p.ID_client) AS NombreClientsInscrits
    FROM Activités a
    LEFT JOIN Participations p ON a.ID = p.ID_activité
    GROUP BY a.ID, a.Nom_de_l_activité;

    -- Revenu généré par chaque activité
    SELECT a.ID AS ID_activité, a.Nom_de_l_activité, SUM(f.Prix) AS RevenuGénéré
    FROM Activités a
    INNER JOIN Forfait_Activité fa ON a.ID = fa.ID_activité
    INNER JOIN Forfaits f ON fa.ID_forfait = f.ID
    GROUP BY a.ID, a.Nom_de_l_activité;
END;
GO

----statistiques globales-----
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetStatistiquesGlobales')
    DROP PROCEDURE GetStatistiquesGlobales;
GO

CREATE PROCEDURE GetStatistiquesGlobales
AS
BEGIN
    DECLARE @TotalSalaires DECIMAL(10, 2);
    DECLARE @TotalRevenu DECIMAL(10, 2);
    DECLARE @Différence DECIMAL(10, 2);

    -- Total des salaires des employés
    SELECT @TotalSalaires = SUM(Salaire) FROM Employés;

    -- Total du revenu généré par les clients
    SELECT @TotalRevenu = SUM(Prix) FROM Forfaits f
    INNER JOIN Abonnements a ON f.ID = a.ID_forfait;

    -- Calcul de la différence entre les deux
    SET @Différence = @TotalRevenu - @TotalSalaires;

    -- Affichage des résultats
    SELECT @TotalSalaires AS TotalSalaires, @TotalRevenu AS TotalRevenu, @Différence AS Différence;
END;
GO

--------statistiqes forfaits------
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetStatistiquesForfaits')
    DROP PROCEDURE GetStatistiquesForfaits;
GO

CREATE PROCEDURE GetStatistiquesForfaits
AS
BEGIN
    -- Nombre de clients inscrits à chaque forfait
    SELECT f.ID AS ID_forfait, f.Nom_du_forfait, COUNT(a.ID_client) AS NombreClientsInscrits
    FROM Forfaits f
    LEFT JOIN Abonnements a ON f.ID = a.ID_forfait
    GROUP BY f.ID, f.Nom_du_forfait;

    -- Revenu généré par chaque forfait
    SELECT f.ID AS ID_forfait, f.Nom_du_forfait, SUM(f.Prix) AS RevenuGénéré
    FROM Forfaits f
    INNER JOIN Abonnements a ON f.ID = a.ID_forfait
    GROUP BY f.ID, f.Nom_du_forfait;
END;
GO



IF OBJECT_ID('AfficherClientsAvecAbonnementsEtParticipations', 'P') IS NOT NULL
    DROP PROCEDURE AfficherClientsAvecAbonnementsEtParticipations;
GO

CREATE PROCEDURE AfficherClientsAvecAbonnementsEtParticipations
AS
BEGIN
    SELECT c.ID AS ClientID, c.Nom AS ClientNom,
           a.ID_forfait AS AbonnementID, f.Prix AS ForfaitPrix,
           p.ID_activité AS ActiviteID
    FROM Clients c
    LEFT JOIN Abonnements a ON c.ID = a.ID_client
    LEFT JOIN Forfaits f ON a.ID_forfait = f.ID
    LEFT JOIN Participations p ON c.ID = p.ID_client;
END;
