USE RetailAnalytics;
GO

INSERT INTO Customers VALUES
(1, 'Asha Kumar', 'Toronto', '2024-01-10'),
(2, 'Ravi Patel', 'Ottawa', '2024-02-15'),
(3, 'Meera Singh', 'Vancouver', '2024-03-20'),
(4, 'John Lee', 'Calgary', '2024-04-05');

INSERT INTO Products VALUES
(101, 'Wireless Mouse', 'Electronics', 25.99),
(102, 'Keyboard', 'Electronics', 45.50),
(103, 'Water Bottle', 'Home', 12.00),
(104, 'Notebook', 'Stationery', 5.50);

INSERT INTO Transactions VALUES
(1, 1, 101, 1, '2024-04-01'),
(2, 1, 102, 1, '2024-04-10'),
(3, 2, 103, 2, '2024-04-03'),
(4, 3, 104, 5, '2024-04-05'),
(5, 3, 101, 1, '2024-04-15'),
(6, 4, 103, 1, '2024-04-20'),
(7, 4, 101, 1, '2024-04-25');
