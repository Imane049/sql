use club_sport;
go

-- Exemple d'ex�cution de la proc�dure InsertEmploy�
EXEC InsertEmploy� 'John Doe', 2500.00;

-- Exemple d'ex�cution de la proc�dure InsertEntraineur
EXEC InsertEntraineur 'Yoga';

-- Exemple d'ex�cution de la proc�dure InsertAutre
EXEC InsertAutre 'R�ceptionniste';

-- Exemple d'ex�cution de la proc�dure InsertClient
EXEC InsertClient 'Alice Smith', '123 Main Street', '1234567890', 'alice@example.com', 1;

-- Exemple d'ex�cution de la proc�dure InsertSalle
EXEC InsertSalle 'Salle A';

-- Exemple d'ex�cution de la proc�dure InsertActivit�
EXEC InsertActivit� 'Yoga class', 1, '2023-05-01', 1, '09:00', '10:00', 10;

-- Exemple d'ex�cution de la proc�dure InsertForfait
EXEC InsertForfait 'Basic Package', 'Includes access to gym and group classes', 50.00;

-- Exemple d'ex�cution de la proc�dure InsertAbonnement
EXEC InsertAbonnement 1, 1, '2023-05-01', '2023-06-30';

-- Exemple d'ex�cution de la proc�dure InsertParticipation
EXEC InsertParticipation 1, 1;

-- Exemple d'ex�cution de la proc�dure InsertForfaitActivit�
EXEC InsertForfaitActivit� 1, 1;

-- Exemple d'ex�cution de la proc�dure Insert�quipement
EXEC Insert�quipement 'Treadmill', 1, 'Working';

exec AfficherClientsAvecAbonnementsEtParticipations;
