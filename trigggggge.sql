USE club_sport;
GO

CREATE TRIGGER tr_Activites_PreventOverlaps
ON Activités
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT * FROM Activités AS A
        JOIN inserted AS I ON A.ID_entraîneur = I.ID_entraîneur OR A.ID_salle = I.ID_salle
        WHERE DATEDIFF(MINUTE, A.Date_de_début, I.Date_de_début) BETWEEN 0 AND DATEDIFF(MINUTE, A.Heure_de_début, A.Heure_de_fin)
          OR DATEDIFF(MINUTE, A.Date_de_début, I.Heure_de_début) BETWEEN 0 AND DATEDIFF(MINUTE, A.Heure_de_début, A.Heure_de_fin)
    )
    BEGIN
        RAISERROR('L''entraîneur ou la salle est déjà engagé(e) dans une autre activité à la même date et heure.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Activités (ID, Nom_de_l_activité, ID_entraîneur, Date_de_début, ID_salle, Heure_de_début, Heure_de_fin, Limite_participants)
        SELECT ID, Nom_de_l_activité, ID_entraîneur, Date_de_début, ID_salle, Heure_de_début, Heure_de_fin, Limite_participants
        FROM inserted;
    END;
END;
