USE club_sport;
GO

CREATE TRIGGER tr_Activites_PreventOverlaps
ON Activit�s
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT * FROM Activit�s AS A
        JOIN inserted AS I ON A.ID_entra�neur = I.ID_entra�neur OR A.ID_salle = I.ID_salle
        WHERE DATEDIFF(MINUTE, A.Date_de_d�but, I.Date_de_d�but) BETWEEN 0 AND DATEDIFF(MINUTE, A.Heure_de_d�but, A.Heure_de_fin)
          OR DATEDIFF(MINUTE, A.Date_de_d�but, I.Heure_de_d�but) BETWEEN 0 AND DATEDIFF(MINUTE, A.Heure_de_d�but, A.Heure_de_fin)
    )
    BEGIN
        RAISERROR('L''entra�neur ou la salle est d�j� engag�(e) dans une autre activit� � la m�me date et heure.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Activit�s (ID, Nom_de_l_activit�, ID_entra�neur, Date_de_d�but, ID_salle, Heure_de_d�but, Heure_de_fin, Limite_participants)
        SELECT ID, Nom_de_l_activit�, ID_entra�neur, Date_de_d�but, ID_salle, Heure_de_d�but, Heure_de_fin, Limite_participants
        FROM inserted;
    END;
END;
