-- 1.1

-- Запрос выбирает все данные по тиражам
-- в порядке возрастания издателя и убывания даты
SELECT *
FROM circulation circ
ORDER BY circ."Publisher", circ."ReceiptDate" DESC;

-- 1.2

-- Запрос выбирает все тиражи издателя "АСТ"
SELECT * FROM circulation WHERE "Publisher" IN ('АСТ', 'Питер');

-- Запрос выбирает все книги, у которых идентификатор жанра равен 4
SELECT * FROM book WHERE "GenreID" = 4;

-- 1.3

-- Запрос подсчитывает из скольких тиражей была продана хотя бы одна книга
SELECT COUNT(DISTINCT "CirculationID") FROM booksale;

-- Запрос выводит ID всех авторов книги по шифру
SELECT "BookCipher", STRING_AGG("AuthorID"::text, ', ')
FROM writingparticipation
GROUP BY "BookCipher";

-- Запрос находит для шифра книги максимальный тираж по количеству экземпляров
SELECT "BookCipher", MAX("ReceivedCopies")
FROM circulation
GROUP BY "BookCipher";

-- 1.4

-- Запрос находит количество экземпляров книги во всех тиражах
-- и общую выручку при условии продажи всех книг
-- Также запрос выводи общее количество проданных книг
-- и общую выручку
SELECT
    COALESCE("BookCipher"::text, 'ИТОГО') BookCipher,
    COALESCE("Publisher"::text, 'ИТОГО') Publisher,
    SUM("ReceivedCopies") "Количество экземпляров",
    SUM("ReceivedCopies" * "SellPrice") "Ожидаемая выручка"
FROM circulation
GROUP BY ROLLUP ("BookCipher", "Publisher");

-- Все тоже самое, что и в прошлом запросе,
-- но добавлены итоги по издательству
SELECT
    COALESCE("BookCipher"::text, 'ИТОГО') BookCipher,
    COALESCE("Publisher"::text, 'ИТОГО') Publisher,
    SUM("ReceivedCopies") "Количество экземпляров",
    SUM("ReceivedCopies" * "SellPrice") "Ожидаемая выручка"
FROM circulation
GROUP BY CUBE ("BookCipher", "Publisher");

-- Список авторов, имя которых не начинается на Д
SELECT "FullName" FROM author WHERE "FullName" NOT LIKE 'Д%';

-- 2.1

-- Список тиражей, содержащий названия книги вместо шифра
SELECT
    "ID",
    (SELECT book."Name" FROM book WHERE book."Cipher" = circ."BookCipher") "BookName",
    "Publisher",
    "ReceiptDate",
    "PurchasePrice",
    "ReceivedCopies",
    "SoldCopies",
    "CurrentRevenue"
FROM circulation circ;

-- Выводит все записи из таблицы продаж книг с заменой идентификатора продавца на ФИО
SELECT bs."CirculationID",
       (SELECT "FullName" FROM salesman WHERE bs."SalesmanID" = salesman."ID") "Salesman",
       bs."CountCopies"
FROM booksale bs;

-- 2.2

-- Список тиражей, содержащий названия книги вместо шифра
SELECT
    "ID",
    "Name",
    "Publisher",
    "ReceiptDate",
    "PurchasePrice",
    "ReceivedCopies",
    "SoldCopies",
    "CurrentRevenue"
FROM circulation circ
JOIN book ON book."Cipher" = circ."BookCipher";

-- Выводит все записи из таблицы продаж книг с заменой идентификатора продавца на ФИО
SELECT bs."CirculationID",
       sm."FullName",
       bs."CountCopies"
FROM booksale bs
    JOIN salesman sm on bs."SalesmanID" = sm."ID";

-- 2.3

-- Выводит пары автор-книга для всех авторов, зарегистрированных в книжном магазине
SELECT "FullName", "Name"
FROM author
    LEFT JOIN writingparticipation w ON author."ID" = w."AuthorID"
    LEFT JOIN book b ON b."Cipher" = w."BookCipher";

-- Для каждого продавца выводит записи о его продажах книг
-- (Если у продавца нет продаж, то будет выведено NULL)
SELECT s."FullName", b2."Name"
FROM salesman s
    LEFT JOIN booksale b on s."ID" = b."SalesmanID"
    LEFT JOIN circulation c on b."CirculationID" = c."ID"
    LEFT JOIN book b2 on c."BookCipher" = b2."Cipher";

-- 2.4

-- Для всех продаж книг выводит продавца в магазине
-- (если у книги нет продаж, то вместо продавца выведет NULL)
SELECT b."Name", s."FullName"
FROM booksale bs
    JOIN salesman s ON s."ID" = bs."SalesmanID"
    RIGHT JOIN circulation c ON c."ID" = bs."CirculationID"
    RIGHT JOIN book b on c."BookCipher" = b."Cipher";

-- Выводит пары автор-книга для всех книг, зарегистрированных в книжном магазине
SELECT "FullName", "Name"
FROM author
    RIGHT JOIN writingparticipation w ON author."ID" = w."AuthorID"
    RIGHT JOIN book b ON b."Cipher" = w."BookCipher";

-- 2.5

-- Выводит реальную текущую выручку книжного магазина с каждой книги
SELECT book."Name", COUNT(b.id) * circ."PurchasePrice" "RealRevenue"
FROM circulation circ
    JOIN booksale b ON circ."ID" = b."CirculationID"
    JOIN book ON book."Cipher" = circ."BookCipher"
GROUP BY book."Name", circ."PurchasePrice";

-- Для каждого продавца книг в магазине запрос выводит количество проданных им книг
SELECT s."FullName", COUNT(DISTINCT b2."Cipher") "CountBooks"
FROM salesman s
    JOIN booksale b ON s."ID" = b."SalesmanID"
    JOIN circulation c ON c."ID" = b."CirculationID"
    JOIN book b2 ON c."BookCipher" = b2."Cipher"
GROUP BY s."ID", s."FullName";

-- 2.6

-- Выводит реальную текущую выручку книжного магазина
-- с каждой книги, у которой было более двух продаж
SELECT book."Name", COUNT(b.id) * circ."PurchasePrice" "RealRevenue"
FROM circulation circ
    JOIN booksale b ON circ."ID" = b."CirculationID"
    JOIN book ON book."Cipher" = circ."BookCipher"
GROUP BY book."Name", circ."PurchasePrice"
HAVING COUNT(b.id) > 2;

-- Для каждого продавца книг в магазине, продавшего хотя бы одну книгу дороже 600 рублей,
-- запрос выводит количество проданных им книг
SELECT s."FullName", COUNT(DISTINCT b2."Cipher") "CountBooks"
FROM salesman s
    JOIN booksale b ON s."ID" = b."SalesmanID"
    JOIN circulation c ON c."ID" = b."CirculationID"
    JOIN book b2 ON c."BookCipher" = b2."Cipher"
GROUP BY s."ID", s."FullName"
HAVING MAX(c."PurchasePrice") > 600;

-- 2.7

-- Выводит записи о книгах, название жанра которых не содержит буквы Ф
SELECT *
FROM book
WHERE book."GenreID" IN
(
    SELECT "ID"
    FROM genre
    WHERE genre."Name" NOT LIKE '$ф%' AND genre."Name" NOT LIKE '%Ф%'
);

-- Выводит продавцов, которые ничего не продали
SELECT *
FROM salesman
WHERE NOT EXISTS (SELECT * FROM booksale WHERE booksale."SalesmanID" = salesman."ID");

-- Выводит книги, тиражи которых реализуются в нашем магазине
SELECT *
FROM book
WHERE EXISTS (SELECT * FROM circulation WHERE book."Cipher" = circulation."BookCipher");

-- 3.1

-- Представление, содержащее название книги и информацию по тиражу
CREATE VIEW BookCirculation AS
(
    SELECT
    "ID",
    (
        SELECT
            book."Name"
        FROM book
        WHERE book."Cipher" = circ."BookCipher"
    ) "BookName",
    "Publisher",
    "ReceiptDate",
    "PurchasePrice",
    "ReceivedCopies",
    "SoldCopies",
    "CurrentRevenue"
    FROM circulation circ
);

-- Представление, содержащее имя продавца и информвцию по продаже
CREATE VIEW BookSalesman AS
(
    SELECT bs."CirculationID",
       (
            SELECT "FullName"
            FROM salesman
            WHERE bs."SalesmanID" = salesman."ID"
        ) "Salesman",
       bs."CountCopies"
    FROM booksale bs
);

-- 3.2

-- Запрос получает название книги, издательство и прибыль по книге
WITH PublisherProfit AS
(
    SELECT
        c."Publisher",
        SUM(b."CountCopies") * c."SellPrice" "Profit",
        c."BookCipher"
    FROM circulation c
    JOIN booksale b on c."ID" = b."CirculationID"
    GROUP BY c."ID"
)
SELECT b."Name", p."Publisher", p."Profit"
FROM book b
    JOIN PublisherProfit p ON p."BookCipher" = b."Cipher";

-- Запрос выбирает все издательства, с которыми работал автор
WITH BookPublisher AS
(
    SELECT c."Publisher", b."Cipher"
    FROM book b
        JOIN circulation c on b."Cipher" = c."BookCipher"
)
SELECT a."FullName", STRING_AGG(DISTINCT bp."Publisher", ', ')
FROM writingparticipation wp
    JOIN author a ON wp."AuthorID" = a."ID"
    JOIN BookPublisher bp ON bp."Cipher" = wp."BookCipher"
GROUP BY a."ID";

-- 4.1

select inet_server_addr( ), inet_server_port( );