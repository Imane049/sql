USE club_sport;
GO

-- Procédure pour supprimer un employé
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteEmployé')
    DROP PROCEDURE DeleteEmployé;
GO

CREATE PROCEDURE DeleteEmployé
    @ID INT
AS
BEGIN
    DELETE FROM Employés
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un entraîneur
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteEntraineur')
    DROP PROCEDURE DeleteEntraineur;
GO

CREATE PROCEDURE DeleteEntraineur
    @ID INT
AS
BEGIN
    DELETE FROM Entraineurs
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un autre employé
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteAutre')
    DROP PROCEDURE DeleteAutre;
GO

CREATE PROCEDURE DeleteAutre
    @ID INT
AS
BEGIN
    DELETE FROM Autres
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un client
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteClient')
    DROP PROCEDURE DeleteClient;
GO

CREATE PROCEDURE DeleteClient
    @ID INT
AS
BEGIN
    DELETE FROM Clients
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer une salle
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteSalle')
    DROP PROCEDURE DeleteSalle;
GO

CREATE PROCEDURE DeleteSalle
    @ID INT
AS
BEGIN
    DELETE FROM Salles
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer une activité
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteActivité')
    DROP PROCEDURE DeleteActivité;
GO

CREATE PROCEDURE DeleteActivité
    @ID INT
AS
BEGIN
    DELETE FROM Activités
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un forfait
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteForfait')
    DROP PROCEDURE DeleteForfait;
GO

CREATE PROCEDURE DeleteForfait
    @ID INT
AS
BEGIN
    DELETE FROM Forfaits
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un abonnement
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteAbonnement')
    DROP PROCEDURE DeleteAbonnement;
GO

CREATE PROCEDURE DeleteAbonnement
    @ID INT
AS
BEGIN
    DELETE FROM Abonnements
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer une participation
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteParticipation')
    DROP PROCEDURE DeleteParticipation;
GO

CREATE PROCEDURE DeleteParticipation
    @ID INT
AS
BEGIN
    DELETE FROM Participations
    WHERE ID = @ID;
END;
GO

-- Procédure pour supprimer un équipement
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteÉquipement')
    DROP PROCEDURE DeleteÉquipement;
GO

CREATE PROCEDURE DeleteÉquipement
    @ID INT
AS
BEGIN
    DELETE FROM Équipements
    WHERE ID = @ID;
END;
GO
