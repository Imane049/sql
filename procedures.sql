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



-- Création de la procédure
IF OBJECT_ID('spRechercherClientParNom', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherClientParNom
GO

CREATE PROCEDURE spRechercherClientParNom
    @NomClient VARCHAR(255)
AS
BEGIN
    -- Recherche du client par son nom (insensible à la casse et correspondance partielle)
    SELECT C.ID, C.Nom, C.Adresse, C.Numéro_de_téléphone, C.Adresse_email, C.Paiement_réglé,
           F.Nom_du_forfait,
           A.Nom_de_l_activité
    FROM Clients C
    LEFT JOIN Abonnements Abo ON C.ID = Abo.ID_client
    LEFT JOIN Forfaits F ON Abo.ID_forfait = F.ID
    LEFT JOIN Participations P ON C.ID = P.ID_client
    LEFT JOIN Activités A ON P.ID_activité = A.ID
    WHERE LOWER(C.Nom) LIKE '%' + LOWER(@NomClient) + '%';
END
GO

-- Création de la procédure
IF OBJECT_ID('spRechercherEntraineursParSpecialite', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherEntraineursParSpecialite
GO

CREATE PROCEDURE spRechercherEntraineursParSpecialite
    @Specialite VARCHAR(255)
AS
BEGIN
    -- Recherche des entraîneurs par spécialité et leurs activités associées
    SELECT E.ID, E.Spécialité, A.ID AS ActiviteID, A.Nom_de_l_activité
    FROM Entraineurs E
    LEFT JOIN Activités A ON E.ID = A.ID_entraîneur
    WHERE E.Spécialité LIKE '%' + @Specialite + '%';
END
GO

-- Création de la procédure
IF OBJECT_ID('spRechercherSalleActivites', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherSalleActivites
GO

CREATE PROCEDURE spRechercherSalleActivites
    @NomSalle VARCHAR(255) = NULL,
    @IDSalle INT = NULL
AS
BEGIN
    -- Recherche de la salle par nom ou ID et affichage des activités associées
    SELECT S.ID, S.Nom_de_la_salle, A.ID AS ActiviteID, A.Nom_de_l_activité
    FROM Salles S
    INNER JOIN Activités A ON S.ID = A.ID_salle
    WHERE (S.Nom_de_la_salle LIKE '%' + @NomSalle + '%' OR S.ID = @IDSalle);
END
GO


-- Création de la procédure
IF OBJECT_ID('spRechercherForfaitActivites', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherForfaitActivites
GO

CREATE PROCEDURE spRechercherForfaitActivites
    @NomForfait VARCHAR(255)
AS
BEGIN
    -- Recherche du forfait par nom et affichage des activités et du nombre d'abonnements associés
    SELECT F.ID, F.Nom_du_forfait, A.ID AS ActiviteID, A.Nom_de_l_activité, COUNT(AB.ID_client) AS NombreAbonnements
    FROM Forfaits F
    LEFT JOIN Forfait_Activité FA ON F.ID = FA.ID_forfait
    LEFT JOIN Activités A ON FA.ID_activité = A.ID
    LEFT JOIN Abonnements AB ON F.ID = AB.ID_forfait
    WHERE F.Nom_du_forfait LIKE '%' + @NomForfait + '%'
    GROUP BY F.ID, F.Nom_du_forfait, A.ID, A.Nom_de_l_activité;
END
GO

-- Création de la procédure
IF OBJECT_ID('spRechercherActiviteForfaits', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherActiviteForfaits
GO

CREATE PROCEDURE spRechercherActiviteForfaits
    @NomActivite VARCHAR(255) = NULL,
    @SpecialiteEntraîneur VARCHAR(255) = NULL
AS
BEGIN
    -- Recherche de l'activité par nom ou spécialité de l'entraîneur et affichage des forfaits et places restantes
    SELECT A.ID AS ActiviteID, A.Nom_de_l_activité, E.Spécialité, F.ID AS ForfaitID, F.Nom_du_forfait, F.Limite_participants - COUNT(P.ID_activité) AS PlacesRestantes
    FROM Activités A
    LEFT JOIN Entraineurs E ON A.ID_entraîneur = E.ID
    LEFT JOIN Forfait_Activité FA ON A.ID = FA.ID_activité
    LEFT JOIN Forfaits F ON FA.ID_forfait = F.ID
    LEFT JOIN Participations P ON A.ID = P.ID_activité
    WHERE (A.Nom_de_l_activité LIKE '%' + @NomActivite + '%' OR E.Spécialité LIKE '%' + @SpecialiteEntraîneur + '%')
    GROUP BY A.ID, A.Nom_de_l_activité, E.Spécialité, F.ID, F.Nom_du_forfait, F.Limite_participants;
END
GO


