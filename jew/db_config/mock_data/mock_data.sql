USE jewelry;

-- Insert 30 master
INSERT INTO master (FirstName, LastName, FatherName)
VALUES
       ('John', 'Doe', 'Paul'),
       ('Jane', 'Doe', NULL),
       ('Robert', 'Johnson', 'Michael'),
       ('Emily', 'Smith', NULL),
       ('David', 'Lee', 'William'),
       ('Sarah', 'Taylor', NULL),
       ('Thomas', 'Brown', NULL),
       ('Elizabeth', 'Wilson', 'Jennifer'),
       ('Richard', 'Anderson', 'Matthew'),
       ('Karen', 'Martin', NULL),
       ('William', 'Thompson', NULL),
       ('Nancy', 'Garcia', NULL),
       ('Michael', 'Davis', 'Anthony'),
       ('Mary', 'Miller', NULL),
       ('Christopher', 'Jackson', NULL),
       ('Jessica', 'Perez', 'Marie'),
       ('Brian', 'Moore', NULL),
       ('Megan', 'Allen', NULL),
       ('Anthony', 'Young', NULL),
       ('Laura', 'Harris', 'Christine'),
       ('Kevin', 'King', NULL),
       ('Stephanie', 'Scott', NULL),
       ('Jason', 'Turner', 'Eric'),
       ('Melissa', 'Walker', NULL),
       ('Mark', 'Collins', NULL),
       ('Tiffany', 'Nelson', NULL),
       ('Eric', 'Gonzalez', NULL),
       ('Amy', 'Carter', 'Jennifer'),
       ('Matthew', 'Baker', NULL),
       ('Samantha', 'Edwards', NULL);

-- Insert 10 customer
INSERT INTO customer (Name, Email)
VALUES
       ('Smith & Sons Jewelers', 'info@smithandsons.com'),
       ('Cartier', 'info@cartier.com'),
       ('Tiffany & Co.', 'info@tiffany.com'),
       ('Harry Winston', NULL),
       ('Graff Diamonds', 'info@graffdiamonds.com'),
       ('Bulgari', 'info@bulgari.com'),
       ('Van Cleef & Arpels', 'info@vancleefarpels.com'),
       ('Chopard', NULL),
       ('Piaget', 'info@piaget.com'),
       ('Buccellati', 'info@buccellati.com');

