-- Создаём таблицу продавец
CREATE TABLE Salesman
(
    "ID" SERIAL PRIMARY KEY,
    "FullName" VARCHAR(100)
);

-- Создаём таблицу жанра
CREATE TABLE Genre
(    "ID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(30)
);

-- Создаём таблицу автора
CREATE TABLE Author
(
    "ID" SERIAL PRIMARY KEY,
    "FullName" VARCHAR(100)
);

-- Создаём таблицу книги
CREATE TABLE Book
(
    "Cipher" VARCHAR(10) PRIMARY KEY,
    "Name" VARCHAR(100),
    "GenreID" INT NOT NULL,
    FOREIGN KEY ("GenreID") REFERENCES Genre("ID") ON DELETE RESTRICT
);

-- Создаём таблицу тиража
CREATE TABLE Circulation
(
    "ID" SERIAL PRIMARY KEY,
    "BookCipher" VARCHAR(10) NOT NULL,
    "Publisher" VARCHAR(30) NOT NULL,
    "ReceiptDate" DATE NOT NULL,
    "PurchasePrice" NUMERIC NOT NULL,
    "ReceivedCopies" INT NOT NULL,
    "SoldCopies" INT DEFAULT 0,
    "CurrentRevenue" NUMERIC DEFAULT 0,
    FOREIGN KEY ("BookCipher") REFERENCES Book("Cipher") ON DELETE RESTRICT
);

-- Создаём таблицу участия в написании
CREATE TABLE WritingParticipation
(
    "AuthorID" INT NOT NULL,
    "BookCipher" VARCHAR(10) NOT NULL,
    PRIMARY KEY ("AuthorID", "BookCipher"),
    FOREIGN KEY ("AuthorID") REFERENCES Author("ID") ON DELETE RESTRICT,
    FOREIGN KEY ("BookCipher") REFERENCES Book("Cipher") ON DELETE RESTRICT
);

-- Создаем таблицу продаж книг
CREATE TABLE BookSale
(
    ID SERIAL PRIMARY KEY,
    "CirculationID" INT NOT NULL,
    "SalesmanID" INT NOT NULL,
    FOREIGN KEY ("CirculationID") REFERENCES Circulation("ID") ON DELETE RESTRICT,
    FOREIGN KEY ("SalesmanID") REFERENCES Salesman("ID") ON DELETE RESTRICT
);