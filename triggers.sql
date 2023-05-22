use club_sport;
go

-------------Creation des triggers-------------------


-- Cr�ation du d�clencheur pour v�rifier les conditions de participation
CREATE TRIGGER tr_Participation_Check
ON Participations
INSTEAD OF INSERT
AS
BEGIN
    -- V�rifier les conditions pour chaque ligne ins�r�e
    IF EXISTS (
        SELECT i.ID_activit�
        FROM inserted i
        INNER JOIN (
            SELECT ID_activit�, COUNT(*) AS participants
            FROM Participations
            GROUP BY ID_activit�
        ) p ON i.ID_activit� = p.ID_activit�
        INNER JOIN Activit�s a ON i.ID_activit� = a.ID
        WHERE p.participants >= a.Limite_participants
    )
    BEGIN
        -- Condition non respect�e, annuler l'insertion
        RAISERROR ('La participation ne peut pas �tre cr��e car le nombre de participants a atteint la limite.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Condition respect�e, effectuer l'insertion
        INSERT INTO Participations (ID_client, ID_activit�)
        SELECT ID_client, ID_activit�
        FROM inserted;
    END
END;
