use club_sport;
go

-------------Creation des triggers-------------------


-- Création du déclencheur pour vérifier les conditions de participation
CREATE TRIGGER tr_Participation_Check
ON Participations
INSTEAD OF INSERT
AS
BEGIN
    -- Vérifier les conditions pour chaque ligne insérée
    IF EXISTS (
        SELECT i.ID_activité
        FROM inserted i
        INNER JOIN (
            SELECT ID_activité, COUNT(*) AS participants
            FROM Participations
            GROUP BY ID_activité
        ) p ON i.ID_activité = p.ID_activité
        INNER JOIN Activités a ON i.ID_activité = a.ID
        WHERE p.participants >= a.Limite_participants
    )
    BEGIN
        -- Condition non respectée, annuler l'insertion
        RAISERROR ('La participation ne peut pas être créée car le nombre de participants a atteint la limite.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Condition respectée, effectuer l'insertion
        INSERT INTO Participations (ID_client, ID_activité)
        SELECT ID_client, ID_activité
        FROM inserted;
    END
END;
