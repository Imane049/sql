use club_sport;
go


-- Proc�dure pour afficher les �l�ments de la table "Employ�s"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetEmploy�s')
    DROP PROCEDURE GetEmploy�s;
GO

CREATE PROCEDURE GetEmploy�s
AS
BEGIN
    SELECT * FROM Employ�s;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Entraineurs"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetEntraineurs')
    DROP PROCEDURE GetEntraineurs;
GO

CREATE PROCEDURE GetEntraineurs
AS
BEGIN
    SELECT * FROM Entraineurs;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Autres"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAutres')
    DROP PROCEDURE GetAutres;
GO

CREATE PROCEDURE GetAutres
AS
BEGIN
    SELECT * FROM Autres;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Clients"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetClients')
    DROP PROCEDURE GetClients;
GO

CREATE PROCEDURE GetClients
AS
BEGIN
    SELECT * FROM Clients;
END;
GO



-- Proc�dure pour afficher les �l�ments de la table "Salles"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetSalles')
    DROP PROCEDURE GetSalles;
GO
CREATE PROCEDURE GetSalles
AS
BEGIN
    SELECT * FROM Salles;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Activit�s"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetActivit�s')
    DROP PROCEDURE GetActivit�s;
GO

CREATE PROCEDURE GetActivit�s
AS
BEGIN
    SELECT * FROM Activit�s;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Forfaits"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetForfaits')
    DROP PROCEDURE GetForfaits;
GO

CREATE PROCEDURE GetForfaits
AS
BEGIN
    SELECT * FROM Forfaits;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Abonnements"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAbonnements')
    DROP PROCEDURE GetAbonnements;
GO

CREATE PROCEDURE GetAbonnements
AS
BEGIN
    SELECT * FROM Abonnements;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Participations"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetParticipations')
    DROP PROCEDURE GetParticipations;
GO

CREATE PROCEDURE GetParticipations
AS
BEGIN
    SELECT * FROM Participations;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "Forfait_Activit�"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetForfait_Activit�')
    DROP PROCEDURE GetForfait_Activit�;
GO

CREATE PROCEDURE GetForfait_Activit�
AS
BEGIN
    SELECT * FROM Forfait_Activit�;
END;
GO

-- Proc�dure pour afficher les �l�ments de la table "�quipements"
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get�quipements')
    DROP PROCEDURE Get�quipements;
GO

CREATE PROCEDURE Get�quipements
AS
BEGIN
    SELECT * FROM �quipements;
END;
GO


-------statistiques actiites-----
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetStatistiquesActivit�s')
    DROP PROCEDURE GetStatistiquesActivit�s;
GO

CREATE PROCEDURE GetStatistiquesActivit�s
AS
BEGIN
    -- Nombre de clients inscrits � chaque activit�
    SELECT a.ID AS ID_activit�, a.Nom_de_l_activit�, COUNT(p.ID_client) AS NombreClientsInscrits
    FROM Activit�s a
    LEFT JOIN Participations p ON a.ID = p.ID_activit�
    GROUP BY a.ID, a.Nom_de_l_activit�;

    -- Revenu g�n�r� par chaque activit�
    SELECT a.ID AS ID_activit�, a.Nom_de_l_activit�, SUM(f.Prix) AS RevenuG�n�r�
    FROM Activit�s a
    INNER JOIN Forfait_Activit� fa ON a.ID = fa.ID_activit�
    INNER JOIN Forfaits f ON fa.ID_forfait = f.ID
    GROUP BY a.ID, a.Nom_de_l_activit�;
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
    DECLARE @Diff�rence DECIMAL(10, 2);

    -- Total des salaires des employ�s
    SELECT @TotalSalaires = SUM(Salaire) FROM Employ�s;

    -- Total du revenu g�n�r� par les clients
    SELECT @TotalRevenu = SUM(Prix) FROM Forfaits f
    INNER JOIN Abonnements a ON f.ID = a.ID_forfait;

    -- Calcul de la diff�rence entre les deux
    SET @Diff�rence = @TotalRevenu - @TotalSalaires;

    -- Affichage des r�sultats
    SELECT @TotalSalaires AS TotalSalaires, @TotalRevenu AS TotalRevenu, @Diff�rence AS Diff�rence;
END;
GO

--------statistiqes forfaits------
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetStatistiquesForfaits')
    DROP PROCEDURE GetStatistiquesForfaits;
GO

CREATE PROCEDURE GetStatistiquesForfaits
AS
BEGIN
    -- Nombre de clients inscrits � chaque forfait
    SELECT f.ID AS ID_forfait, f.Nom_du_forfait, COUNT(a.ID_client) AS NombreClientsInscrits
    FROM Forfaits f
    LEFT JOIN Abonnements a ON f.ID = a.ID_forfait
    GROUP BY f.ID, f.Nom_du_forfait;

    -- Revenu g�n�r� par chaque forfait
    SELECT f.ID AS ID_forfait, f.Nom_du_forfait, SUM(f.Prix) AS RevenuG�n�r�
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
           p.ID_activit� AS ActiviteID
    FROM Clients c
    LEFT JOIN Abonnements a ON c.ID = a.ID_client
    LEFT JOIN Forfaits f ON a.ID_forfait = f.ID
    LEFT JOIN Participations p ON c.ID = p.ID_client;
END;
