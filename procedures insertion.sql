-- Proc�dure pour l'insertion dans la table "Employ�s"
CREATE PROCEDURE InsertEmploy�
    @Nom VARCHAR(255),
    @Salaire DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Employ�s (Nom, Salaire)
    VALUES (@Nom, @Salaire);
END;

-- Proc�dure pour l'insertion dans la table "Entraineurs"
CREATE PROCEDURE InsertEntraineur
    @Sp�cialit� VARCHAR(255)
AS
BEGIN
    DECLARE @ID INT;

    INSERT INTO Employ�s (Nom, Salaire)
    VALUES ('', 0);

    SET @ID = SCOPE_IDENTITY();

    INSERT INTO Entraineurs (ID, Sp�cialit�)
    VALUES (@ID, @Sp�cialit�);
END;

-- Proc�dure pour l'insertion dans la table "Autres"
CREATE PROCEDURE InsertAutre
    @Fonction VARCHAR(255)
AS
BEGIN
    DECLARE @ID INT;

    INSERT INTO Employ�s (Nom, Salaire)
    VALUES ('', 0);

    SET @ID = SCOPE_IDENTITY();

    INSERT INTO Autres (ID, Fonction)
    VALUES (@ID, @Fonction);
END;

-- Proc�dure pour l'insertion dans la table "Clients"
CREATE PROCEDURE InsertClient
    @Nom VARCHAR(255),
    @Adresse VARCHAR(255),
    @Num�ro_de_t�l�phone VARCHAR(20),
    @Adresse_email VARCHAR(255),
    @Paiement_r�gl� BIT
AS
BEGIN
    INSERT INTO Clients (Nom, Adresse, Num�ro_de_t�l�phone, Adresse_email, Paiement_r�gl�)
    VALUES (@Nom, @Adresse, @Num�ro_de_t�l�phone, @Adresse_email, @Paiement_r�gl�);
END;

-- Proc�dure pour l'insertion dans la table "Salles"
CREATE PROCEDURE InsertSalle
    @Nom_de_la_salle VARCHAR(255)
AS
BEGIN
    INSERT INTO Salles (Nom_de_la_salle)
    VALUES (@Nom_de_la_salle);
END;

-- Proc�dure pour l'insertion dans la table "Activit�s"
CREATE PROCEDURE InsertActivit�
    @Nom_de_l_activit� VARCHAR(255),
    @ID_entra�neur INT,
    @Date_de_d�but DATE,
    @ID_salle INT,
    @Heure_de_d�but TIME,
    @Heure_de_fin TIME,
    @Limite_participants INT
AS
BEGIN
    INSERT INTO Activit�s (Nom_de_l_activit�, ID_entra�neur, Date_de_d�but, ID_salle, Heure_de_d�but, Heure_de_fin, Limite_participants)
    VALUES (@Nom_de_l_activit�, @ID_entra�neur, @Date_de_d�but, @ID_salle, @Heure_de_d�but, @Heure_de_fin, @Limite_participants);
END;

-- Proc�dure pour l'insertion dans la table "Forfaits"
CREATE PROCEDURE InsertForfait
    @Nom_du_forfait VARCHAR(255),
    @Description VARCHAR(MAX),
    @Prix DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Forfaits (Nom_du_forfait, Description, Prix)
    VALUES (@Nom_du_forfait, @Description, @Prix);
END;

-- Proc�dure pour l'insertion dans la table "Abonnements"
CREATE PROCEDURE InsertAbonnement
    @ID_client INT,
    @ID_forfait INT,
    @Date_de_d�but DATE,
    @Date_de_fin DATE
AS
BEGIN
    INSERT INTO Abonnements (ID_client, ID_forfait, Date_de_d�but, Date_de_fin)
    VALUES (@ID_client, @ID_forfait, @Date_de_d�but, @Date_de_fin);
END;

-- Proc�dure pour l'insertion dans la table "Participations"
CREATE PROCEDURE InsertParticipation
    @ID_client INT,
    @ID_activit� INT
AS
BEGIN
    INSERT INTO Participations (ID_client, ID_activit�)
    VALUES (@ID_client, @ID_activit�);
END;

-- Proc�dure pour l'insertion dans la table "Forfait_Activit�"
CREATE PROCEDURE InsertForfaitActivit�
    @ID_forfait INT,
    @ID_activit� INT
AS
BEGIN
    INSERT INTO Forfait_Activit� (ID_forfait, ID_activit�)
    VALUES (@ID_forfait, @ID_activit�);
END;

-- Proc�dure pour l'insertion dans la table "�quipements"
CREATE PROCEDURE Insert�quipement
    @Nom_de_l_�quipement VARCHAR(255),
    @ID_salle INT,
    @�tat VARCHAR(255)
AS
BEGIN
    INSERT INTO �quipements (Nom_de_l_�quipement, ID_salle, �tat)
    VALUES (@Nom_de_l_�quipement, @ID_salle, @�tat);
END;
