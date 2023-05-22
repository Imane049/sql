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



-- Cr�ation de la proc�dure
IF OBJECT_ID('spRechercherClientParNom', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherClientParNom
GO

CREATE PROCEDURE spRechercherClientParNom
    @NomClient VARCHAR(255)
AS
BEGIN
    -- Recherche du client par son nom (insensible � la casse et correspondance partielle)
    SELECT C.ID, C.Nom, C.Adresse, C.Num�ro_de_t�l�phone, C.Adresse_email, C.Paiement_r�gl�,
           F.Nom_du_forfait,
           A.Nom_de_l_activit�
    FROM Clients C
    LEFT JOIN Abonnements Abo ON C.ID = Abo.ID_client
    LEFT JOIN Forfaits F ON Abo.ID_forfait = F.ID
    LEFT JOIN Participations P ON C.ID = P.ID_client
    LEFT JOIN Activit�s A ON P.ID_activit� = A.ID
    WHERE LOWER(C.Nom) LIKE '%' + LOWER(@NomClient) + '%';
END
GO

-- Cr�ation de la proc�dure
IF OBJECT_ID('spRechercherEntraineursParSpecialite', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherEntraineursParSpecialite
GO

CREATE PROCEDURE spRechercherEntraineursParSpecialite
    @Specialite VARCHAR(255)
AS
BEGIN
    -- Recherche des entra�neurs par sp�cialit� et leurs activit�s associ�es
    SELECT E.ID, E.Sp�cialit�, A.ID AS ActiviteID, A.Nom_de_l_activit�
    FROM Entraineurs E
    LEFT JOIN Activit�s A ON E.ID = A.ID_entra�neur
    WHERE E.Sp�cialit� LIKE '%' + @Specialite + '%';
END
GO

-- Cr�ation de la proc�dure
IF OBJECT_ID('spRechercherSalleActivites', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherSalleActivites
GO

CREATE PROCEDURE spRechercherSalleActivites
    @NomSalle VARCHAR(255) = NULL,
    @IDSalle INT = NULL
AS
BEGIN
    -- Recherche de la salle par nom ou ID et affichage des activit�s associ�es
    SELECT S.ID, S.Nom_de_la_salle, A.ID AS ActiviteID, A.Nom_de_l_activit�
    FROM Salles S
    INNER JOIN Activit�s A ON S.ID = A.ID_salle
    WHERE (S.Nom_de_la_salle LIKE '%' + @NomSalle + '%' OR S.ID = @IDSalle);
END
GO


-- Cr�ation de la proc�dure
IF OBJECT_ID('spRechercherForfaitActivites', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherForfaitActivites
GO

CREATE PROCEDURE spRechercherForfaitActivites
    @NomForfait VARCHAR(255)
AS
BEGIN
    -- Recherche du forfait par nom et affichage des activit�s et du nombre d'abonnements associ�s
    SELECT F.ID, F.Nom_du_forfait, A.ID AS ActiviteID, A.Nom_de_l_activit�, COUNT(AB.ID_client) AS NombreAbonnements
    FROM Forfaits F
    LEFT JOIN Forfait_Activit� FA ON F.ID = FA.ID_forfait
    LEFT JOIN Activit�s A ON FA.ID_activit� = A.ID
    LEFT JOIN Abonnements AB ON F.ID = AB.ID_forfait
    WHERE F.Nom_du_forfait LIKE '%' + @NomForfait + '%'
    GROUP BY F.ID, F.Nom_du_forfait, A.ID, A.Nom_de_l_activit�;
END
GO

-- Cr�ation de la proc�dure
IF OBJECT_ID('spRechercherActiviteForfaits', 'P') IS NOT NULL
    DROP PROCEDURE spRechercherActiviteForfaits
GO

CREATE PROCEDURE spRechercherActiviteForfaits
    @NomActivite VARCHAR(255) = NULL,
    @SpecialiteEntra�neur VARCHAR(255) = NULL
AS
BEGIN
    -- Recherche de l'activit� par nom ou sp�cialit� de l'entra�neur et affichage des forfaits et places restantes
    SELECT A.ID AS ActiviteID, A.Nom_de_l_activit�, E.Sp�cialit�, F.ID AS ForfaitID, F.Nom_du_forfait, F.Limite_participants - COUNT(P.ID_activit�) AS PlacesRestantes
    FROM Activit�s A
    LEFT JOIN Entraineurs E ON A.ID_entra�neur = E.ID
    LEFT JOIN Forfait_Activit� FA ON A.ID = FA.ID_activit�
    LEFT JOIN Forfaits F ON FA.ID_forfait = F.ID
    LEFT JOIN Participations P ON A.ID = P.ID_activit�
    WHERE (A.Nom_de_l_activit� LIKE '%' + @NomActivite + '%' OR E.Sp�cialit� LIKE '%' + @SpecialiteEntra�neur + '%')
    GROUP BY A.ID, A.Nom_de_l_activit�, E.Sp�cialit�, F.ID, F.Nom_du_forfait, F.Limite_participants;
END
GO


