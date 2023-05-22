USE club_sport;
GO

-- Proc�dure pour supprimer un employ�
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteEmploy�')
    DROP PROCEDURE DeleteEmploy�;
GO

CREATE PROCEDURE DeleteEmploy�
    @ID INT
AS
BEGIN
    DELETE FROM Employ�s
    WHERE ID = @ID;
END;
GO

-- Proc�dure pour supprimer un entra�neur
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

-- Proc�dure pour supprimer un autre employ�
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

-- Proc�dure pour supprimer un client
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

-- Proc�dure pour supprimer une salle
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

-- Proc�dure pour supprimer une activit�
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DeleteActivit�')
    DROP PROCEDURE DeleteActivit�;
GO

CREATE PROCEDURE DeleteActivit�
    @ID INT
AS
BEGIN
    DELETE FROM Activit�s
    WHERE ID = @ID;
END;
GO

-- Proc�dure pour supprimer un forfait
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

-- Proc�dure pour supprimer un abonnement
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

-- Proc�dure pour supprimer une participation
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

-- Proc�dure pour supprimer un �quipement
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Delete�quipement')
    DROP PROCEDURE Delete�quipement;
GO

CREATE PROCEDURE Delete�quipement
    @ID INT
AS
BEGIN
    DELETE FROM �quipements
    WHERE ID = @ID;
END;
GO
