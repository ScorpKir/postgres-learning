-- Запрос выбирает все данные по тиражам
-- в порядке возрастания издателя и убывания даты
SELECT *
FROM circulation circ
ORDER BY circ."Publisher", circ."ReceiptDate" DESC;

-- Запрос выбирает все тиражи издателя "АСТ"
SELECT * FROM circulation WHERE "Publisher" IN ('АСТ', 'Питер');

-- Запрос выбирает все книги, у которых идентификатор жанра равен 4
SELECT * FROM book WHERE "GenreID" = 4;

-- Запрос подсчитывает из скольких тиражей была продана
-- Хотя бы одна книга
SELECT COUNT(DISTINCT "CirculationID") FROM booksale;

-- Запрос выводит ID всех авторов книги по шифру
SELECT "BookCipher", STRING_AGG("AuthorID"::text, ', ')
FROM writingparticipation
GROUP BY "BookCipher";

-- Запрос находит для шифра книги максимальный тираж
-- по количеству экземпляров
SELECT "BookCipher", MAX("ReceivedCopies")
FROM circulation
GROUP BY "BookCipher";

-- Запрос находит количество экземпляров книги во всех тиражах
-- и общую выручку при условии продажи всех книг
-- Также запрос выводи общее количество проданных книг
-- и общую выручку
SELECT
    COALESCE("BookCipher"::text, 'ИТОГО') BookCipher,
    COALESCE("Publisher"::text, 'ИТОГО') Publisher,
    SUM("ReceivedCopies") "Количество экземпляров",
    SUM("ReceivedCopies" * "PurchasePrice") "Ожидаемая выручка"
FROM circulation
GROUP BY ROLLUP ("BookCipher", "Publisher");

-- Все тоже самое, что и в прошлом запросе,
-- но добавлены итоги по издательству
SELECT
    COALESCE("BookCipher"::text, 'ИТОГО') BookCipher,
    COALESCE("Publisher"::text, 'ИТОГО') Publisher,
    SUM("ReceivedCopies") "Количество экземпляров",
    SUM("ReceivedCopies" * "PurchasePrice") "Ожидаемая выручка"
FROM circulation
GROUP BY CUBE ("BookCipher", "Publisher");

-- Список авторов, имя которых не начинается на Д
SELECT "FullName" FROM author WHERE "FullName" NOT LIKE 'Д%'


