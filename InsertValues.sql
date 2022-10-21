SET search_path = "scorpkir";

-- Вставляем жанры
INSERT INTO genre ("Name") VALUES
('Компьютерная литература'),
('Математическая литература'),
('Научно-популярная литература'),
('Фантастика'),
('Фэнтези'),
('Мистика'),
('Детектив'),
('Приключения'),
('Исторический роман'),
('Авангардная литература'),
('Ужасы');

-- Вставляем авторов
INSERT INTO author("FullName") VALUES
('Роберт Мартин'),
('Тим Рафгарден'),
('Джеффри Рихтер'),
('Томмазо Теофили'),
('Джеффри Макконнелл'),
('Юлий Васильев'),
('Анатолий Постолит'),
('Жюль Верн'),
('Айзек Азимов'),
('Дмитрий Глуховский'),
('Аркадий Стругацкий'),
('Борис Стругацкий'),
('Стивен Кинг'),
('Ричард Чизмар'),
('Дуглас Адамс'),
('Дэвид Фишер'),
('Джеймс Госс');

-- Вставляем продавцов
INSERT INTO salesman("FullName") VALUES
('Лаврова Мария Артёмовна'),
('Карпова Вера Тихоновна'),
('Пахомов Лука Кириллович'),
('Чернова Вера Романовна'),
('Касаткина Мария Кирилловна'),
('Леонов Кирилл Матвеевич'),
('Тихонов Кирилл Владимирович'),
('Тарасова Мария Адамовна'),
('Горячева Ангелина Тимофеевна'),
('Лавров Владимир Ярославович'),
('Кузнецова Александра Викторовна');

-- Вставляем книги
INSERT INTO book("Cipher", "Name", "GenreID") VALUES
('s{291$#OWe', 'Глубокое обучение для поисковых систем', 1),
('FZJLFLK?6o', 'Идеальный программист', 3),
('}*1GlBtDjt', 'Анализ алгоритмов', 1),
('4HgP630G#|', 'Обработка естественного языка', 1),
('gpOBODLGRV', 'Совершенный алгоритм', 3),
('3zbLz~LRBt', 'Пост', 11),
('sxHVIOx}q~', 'Чистая архитектура', 1),
('0YGj@By#hY', 'Чистый код', 1),
('9hm5$QT#5m', 'Метро 2033', 4),
('OM6~B~L1VT', 'Дети капитана Гранта', 4),
('rlT1AuH6u%', 'Двадцать тысяч льё под водой', 4),
('3L#i{|wX$L', 'Основание', 4),
('}N|*V?MY2l', 'Я, робот', 4),
('{oX?Vnr{Uz', 'CLR via C#', 1),
('dOcsyco0dj', 'Основы искуственного интеллекта в примерах на Python', 1),
('#RJ7U6|r7W', 'За миллиард лет до конца света', 4),
('1yP|j9@b?j', 'Второе нашествие марсиан', 4),
('zvPDM*kxC}', 'Отягощенные злом или сорок лет спустя', 4),
('VSMtdpWI6*', 'Гвенди и ее шкатулка', 5),
('yc}tFCoN}f', 'Доктор Кто. Город смерти', 5);

-- Вставляем авторства
INSERT INTO writingparticipation("AuthorID", "BookCipher") VALUES
(4, 's{291$#OWe'),
(1, 'FZJLFLK?6o'),
(5, '}*1GlBtDjt'),
(6, '4HgP630G#|'),
(2, 'gpOBODLGRV'),
(10, '3zbLz~LRBt'),
(1, 'sxHVIOx}q~'),
(1, '0YGj@By#hY'),
(10, '9hm5$QT#5m'),
(8, 'OM6~B~L1VT'),
(8, 'rlT1AuH6u%'),
(9, '3L#i{|wX$L'),
(9, '}N|*V?MY2l'),
(3, '{oX?Vnr{Uz'),
(7, 'dOcsyco0dj'),
(11, 'zvPDM*kxC}'),
(12, 'zvPDM*kxC}'),
(11, '#RJ7U6|r7W'),
(12, '#RJ7U6|r7W'),
(11, '1yP|j9@b?j'),
(12, '1yP|j9@b?j'),
(13, 'VSMtdpWI6*'),
(14, 'VSMtdpWI6*'),
(15, 'yc}tFCoN}f'),
(16, 'yc}tFCoN}f'),
(17, 'yc}tFCoN}f');

-- Вставляем тиражи
INSERT INTO circulation("BookCipher", "Publisher", "ReceiptDate", "PurchasePrice", "ReceivedCopies") VALUES
('s{291$#OWe', 'Питер', '20190101', 2323, 100),
('s{291$#OWe', 'Питер', '20190101', 1987, 200),
('}*1GlBtDjt', 'Техносфера', '20090628', 745, 300),
('1yP|j9@b?j', 'Байкал', '19670101', 1000, 200000),
('VSMtdpWI6*', 'АСТ', '20170516', 500, 3000),
('s{291$#OWe', 'ДМК Пресс', '20191205', 1000, 500),
('rlT1AuH6u%', 'АСТ', '18690320', 200, 4000),
('OM6~B~L1VT', 'АСТ', '20220806', 200, 20000),
('yc}tFCoN}f', 'АСТ', '20220504', 400, 1500),
('#RJ7U6|r7W', 'АСТ', '20210604', 300, 30000),
('FZJLFLK?6o', 'Питер', '20220316', 900, 3000),
('9hm5$QT#5m', 'АСТ', '20210417', 1100, 7000),
('4HgP630G#|', 'Питер', '20210713', 1600, 3000),
('3L#i{|wX$L', 'Эксмо', '20221013', 600, 400),
('dOcsyco0dj', 'BHV', '20211230', 900, 1000),
('zvPDM*kxC}', 'АСТ', '20210101', 300, 4500);

-- Вставляем продажи книг
INSERT INTO booksale("SalesmanID", "CirculationID") VALUES
(4, 8),
(11, 3),
(2, 10),
(5, 3),
(4, 9),
(2, 9),
(3, 10),
(7, 13),
(11, 3),
(7, 10),
(2, 12),
(8, 13),
(3, 6),
(6, 7),
(3, 9),
(5, 9),
(2, 3),
(3, 5),
(5, 9),
(3, 9),
(7, 8),
(4, 11);

