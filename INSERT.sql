use club_sport;
go

-- Exemple d'exécution de la procédure InsertEmployé
EXEC InsertEmployé 'John Doe', 2500.00;

-- Exemple d'exécution de la procédure InsertEntraineur
EXEC InsertEntraineur 'Yoga';

-- Exemple d'exécution de la procédure InsertAutre
EXEC InsertAutre 'Réceptionniste';

-- Exemple d'exécution de la procédure InsertClient
EXEC InsertClient 'Alice Smith', '123 Main Street', '1234567890', 'alice@example.com', 1;

-- Exemple d'exécution de la procédure InsertSalle
EXEC InsertSalle 'Salle A';

-- Exemple d'exécution de la procédure InsertActivité
EXEC InsertActivité 'Yoga class', 1, '2023-05-01', 1, '09:00', '10:00', 10;

-- Exemple d'exécution de la procédure InsertForfait
EXEC InsertForfait 'Basic Package', 'Includes access to gym and group classes', 50.00;

-- Exemple d'exécution de la procédure InsertAbonnement
EXEC InsertAbonnement 1, 1, '2023-05-01', '2023-06-30';

-- Exemple d'exécution de la procédure InsertParticipation
EXEC InsertParticipation 1, 1;

-- Exemple d'exécution de la procédure InsertForfaitActivité
EXEC InsertForfaitActivité 1, 1;

-- Exemple d'exécution de la procédure InsertÉquipement
EXEC InsertÉquipement 'Treadmill', 1, 'Working';

exec AfficherClientsAvecAbonnementsEtParticipations;
