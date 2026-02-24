create table authors(author_id int auto_increment, author_name VARCHAR(50), nationality VARCHAR(30), primary key(author_id) );

CREATE TABLE book_details(isbn BIGINT, title VARCHAR(255), author_id INT, category VARCHAR(100), year INT,edition VARCHAR(20), publisher VARCHAR(100), PRIMARY KEY(isbn), FOREIGN KEY(author_id) REFERENCES authors(author_id));

-- 3. Stock Table
CREATE TABLE stock (
    book_id INT AUTO_INCREMENT,
    isbn BIGINT,
    status VARCHAR(50), -- Available, Borrowed, etc.
    price DECIMAL(10, 2),
    PRIMARY KEY (book_id),
    FOREIGN KEY (isbn) REFERENCES book_details(isbn)
);

-- 4. Students Table
CREATE TABLE students (
    adm_no INT AUTO_INCREMENT,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100),
    class_program VARCHAR(100),
    PRIMARY KEY (adm_no)
);

-- 5. Staff Table
CREATE TABLE staff (
    staff_no INT AUTO_INCREMENT,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    position VARCHAR(100),
    employment_status VARCHAR(50),
    PRIMARY KEY (staff_no)
);

-- 6. Borrowings Table
CREATE TABLE borrowings (
    borrowing_id INT AUTO_INCREMENT,
    student_id INT,
    book_id INT,
    staff_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE,
    PRIMARY KEY (borrowing_id),
    FOREIGN KEY (student_id) REFERENCES students(adm_no),
    FOREIGN KEY (book_id) REFERENCES stock(book_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_no)
);

INSERT INTO authors (author_name, nationality) VALUES 
('Ngũgĩ wa Thiong''o', 'Kenyan'),
('Margaret A. Ogola', 'Kenyan'),
('Ken Walibora', 'Kenyan'),
('Yvonne Adhiambo Owuor', 'Kenyan'),
('John Kiriamiti', 'Kenyan');

INSERT INTO book_details (isbn, title, author_id, category, year, edition, publisher) VALUES 
(9780435900021, 'Weep Not, Child', 1, 'Classic Literature', 1964, '1st', 'Heinemann Kenya'),
(9789966882451, 'The River and the Source', 2, 'Fiction', 1994, 'Reprint', 'Focus Publishers'),
(9789966442010, 'Siku Njema', 3, 'Swahili Literature', 1996, '2nd', 'Longhorn Publishers'),
(9781101870334, 'Dust', 4, 'Contemporary Fiction', 2014, '1st', 'Kwani Trust'),
(9789966441021, 'My Life in Crime', 5, 'True Crime/Thriller', 1984, '1st', 'Spear Books');

INSERT INTO stock (isbn, status, price) VALUES 
(9780435900021, 'Available', 850.00),
(9789966882451, 'Borrowed', 1200.00),
(9789966442010, 'Available', 650.00),
(9781101870334, 'Available', 1500.00),
(9789966441021, 'Borrowed', 700.00);

INSERT INTO students (name, address, phone, email, class_program) VALUES 
('Achieng Wanjiru', 'Nairobi, Westlands', '0722000111', 'achieng.w@example.ke', 'BSc. Computer Science'),
('Kevin Kiprono', 'Eldoret, Kapsoya', '0733444555', 'kiprono.k@example.ke', 'Bachelor of Commerce'),
('Faith Chebet', 'Nakuru, Milimani', '0701999888', 'f.chebet@example.ke', 'Diploma in Nursing'),
('Alex Mutua', 'Machakos Town', '0788222333', 'mutua.alex@example.ke', 'BEd. Arts'),
('Grace Atieno', 'Kisumu, Milimani', '0755666777', 'atieno.grace@example.ke', 'BSc. IT');

INSERT INTO staff (name, phone, email, position, employment_status) VALUES 
('Bavon Ochieng', '0711222333', 'bavon.o@library.ke', 'Chief Librarian', 'Permanent'),
('Rose Mathenge', '0722333444', 'rose.m@library.ke', 'Assistant Registrar', 'Permanent'),
('Moses Baragu', '0733555666', 'm.baragu@library.ke', 'Library Assistant', 'Contract'),
('Janet Apima', '0744777888', 'j.apima@library.ke', 'Records Clerk', 'Permanent'),
('Samson Otakwa', '0755999000', 's.otakwa@library.ke', 'Technical Support', 'Permanent');

INSERT INTO borrowings (student_id, book_id, staff_id, issue_date, due_date, return_date) VALUES 
(1, 1, 3, '2024-05-01', '2024-05-15', NULL),          -- Achieng borrowed "Weep Not, Child"
(2, 2, 3, '2024-05-02', '2024-05-16', '2024-05-14'),  -- Kiprono borrowed/returned "The River and the Source"
(3, 3, 1, '2024-05-05', '2024-05-19', NULL),          -- Faith borrowed "Siku Njema"
(4, 5, 4, '2024-05-10', '2024-05-24', NULL),          -- Alex borrowed "My Life in Crime"
(5, 4, 2, '2024-05-12', '2024-05-26', '2024-05-20');  -- Grace borrowed/returned "Dust"



-- BOOKS THAT WERE BORROWED, NOT YET RETURNED AS OF 20TH MAY 2024 AND THEY ARE OVERDUE

select student_id, due_date from borrowings WHERE return_date is NULL AND due_date < "2024-05-20";
select student_id,name,phone, due_date from borrowings JOIN students ON borrowings.student_id = students.adm_no WHERE return_date is NULL AND due_date < "2024-05-20";

-- seeding data for borowing records 

INSERT INTO borrowings (student_id, book_id, staff_id, issue_date, due_date, return_date) VALUES 
(1, 3, 2, '2024-01-05', '2024-01-19', '2024-01-15'),
(2, 5, 4, '2024-01-07', '2024-01-21', '2024-01-20'),
(3, 1, 1, '2024-01-10', '2024-01-24', NULL),
(4, 2, 3, '2024-01-12', '2024-01-26', '2024-01-25'),
(5, 4, 5, '2024-01-15', '2024-01-29', '2024-02-01'),
(1, 2, 1, '2024-01-18', '2024-02-01', '2024-01-30'),
(2, 4, 2, '2024-01-20', '2024-02-03', NULL),
(3, 3, 3, '2024-01-22', '2024-02-05', '2024-02-04'),
(4, 5, 4, '2024-01-25', '2024-02-08', '2024-02-10'),
(5, 1, 5, '2024-01-28', '2024-02-11', '2024-02-09'),
(1, 5, 3, '2024-02-01', '2024-02-15', '2024-02-14'),
(2, 1, 4, '2024-02-03', '2024-02-17', NULL),
(3, 2, 5, '2024-02-05', '2024-02-19', '2024-02-18'),
(4, 4, 1, '2024-02-08', '2024-02-22', '2024-02-20'),
(5, 3, 2, '2024-02-10', '2024-02-24', '2024-02-24'),
(1, 4, 4, '2024-02-12', '2024-02-26', '2024-02-28'),
(2, 3, 5, '2024-02-15', '2024-02-29', NULL),
(3, 5, 1, '2024-02-18', '2024-03-03', '2024-03-01'),
(4, 1, 2, '2024-02-20', '2024-03-05', '2024-03-04'),
(5, 2, 3, '2024-02-22', '2024-03-07', '2024-03-10'),
(1, 1, 5, '2024-02-25', '2024-03-10', '2024-03-08'),
(2, 2, 1, '2024-02-28', '2024-03-13', NULL),
(3, 4, 2, '2024-03-02', '2024-03-16', '2024-03-15'),
(4, 3, 3, '2024-03-05', '2024-03-19', '2024-03-18'),
(5, 5, 4, '2024-03-08', '2024-03-22', '2024-03-25'),
(1, 2, 3, '2024-03-10', '2024-03-24', '2024-03-22'),
(2, 5, 4, '2024-03-12', '2024-03-26', NULL),
(3, 1, 5, '2024-03-15', '2024-03-29', '2024-03-30'),
(4, 4, 1, '2024-03-18', '2024-04-01', '2024-03-31'),
(5, 3, 2, '2024-03-20', '2024-04-03', '2024-04-01'),
(1, 3, 1, '2024-03-22', '2024-04-05', '2024-04-04'),
(2, 4, 2, '2024-03-25', '2024-04-08', NULL),
(3, 5, 3, '2024-03-28', '2024-04-11', '2024-04-10'),
(4, 2, 4, '2024-03-30', '2024-04-13', '2024-04-15'),
(5, 1, 5, '2024-04-02', '2024-04-16', '2024-04-14'),
(1, 4, 2, '2024-04-05', '2024-04-19', '2024-04-18'),
(2, 3, 3, '2024-04-08', '2024-04-22', NULL),
(3, 2, 4, '2024-04-10', '2024-04-24', '2024-04-23'),
(4, 5, 5, '2024-04-12', '2024-04-26', '2024-04-26'),
(5, 1, 1, '2024-04-15', '2024-04-29', '2024-04-28'),
(1, 5, 4, '2024-04-18', '2024-05-02', '2024-05-01'),
(2, 1, 5, '2024-04-20', '2024-05-04', NULL),
(3, 4, 1, '2024-04-22', '2024-05-06', '2024-05-05'),
(4, 3, 2, '2024-04-25', '2024-05-09', '2024-05-10'),
(5, 2, 3, '2024-04-28', '2024-05-12', '2024-05-11'),
(1, 2, 5, '2024-05-01', '2024-05-15', '2024-05-14'),
(2, 5, 1, '2024-05-03', '2024-05-17', NULL),
(3, 1, 2, '2024-05-05', '2024-05-19', '2024-05-18'),
(4, 4, 3, '2024-05-08', '2024-05-22', '2024-05-20'),
(5, 3, 4, '2024-05-10', '2024-05-24', '2024-05-24'),
(1, 3, 3, '2024-05-12', '2024-05-26', '2024-05-25'),
(2, 4, 4, '2024-05-15', '2024-05-29', NULL),
(3, 5, 5, '2024-05-18', '2024-06-01', '2024-05-31'),
(4, 2, 1, '2024-05-20', '2024-06-03', '2024-06-05'),
(5, 1, 2, '2024-05-22', '2024-06-05', '2024-06-04'),
(1, 1, 4, '2024-05-25', '2024-06-08', '2024-06-07'),
(2, 2, 5, '2024-05-28', '2024-06-11', NULL),
(3, 4, 1, '2024-05-30', '2024-06-13', '2024-06-12'),
(4, 3, 2, '2024-06-02', '2024-06-16', '2024-06-16'),
(5, 5, 3, '2024-06-05', '2024-06-19', '2024-06-18'),
(1, 4, 1, '2024-06-08', '2024-06-22', '2024-06-21'),
(2, 3, 2, '2024-06-10', '2024-06-24', NULL),
(3, 2, 3, '2024-06-12', '2024-06-26', '2024-06-25'),
(4, 5, 4, '2024-06-15', '2024-06-29', '2024-07-01'),
(5, 1, 5, '2024-06-18', '2024-07-02', '2024-06-30'),
(1, 5, 2, '2024-06-20', '2024-07-04', '2024-07-03'),
(2, 1, 3, '2024-06-22', '2024-07-06', NULL),
(3, 4, 4, '2024-06-25', '2024-07-09', '2024-07-08'),
(4, 3, 5, '2024-06-28', '2024-07-12', '2024-07-15'),
(5, 2, 1, '2024-06-30', '2024-07-14', '2024-07-13'),
(1, 2, 4, '2024-07-02', '2024-07-16', '2024-07-15'),
(2, 5, 5, '2024-07-05', '2024-07-19', NULL),
(3, 1, 1, '2024-07-08', '2024-07-22', '2024-07-21'),
(4, 4, 2, '2024-07-10', '2024-07-24', '2024-07-26'),
(5, 3, 3, '2024-07-12', '2024-07-26', '2024-07-25'),
(1, 3, 5, '2024-07-15', '2024-07-29', '2024-07-28'),
(2, 4, 1, '2024-07-18', '2024-08-01', NULL),
(3, 5, 2, '2024-07-20', '2024-08-03', '2024-08-02'),
(4, 2, 3, '2024-07-22', '2024-08-05', '2024-08-10'),
(5, 1, 4, '2024-07-25', '2024-08-08', '2024-08-07'),
(1, 1, 3, '2024-07-28', '2024-08-11', '2024-08-10'),
(2, 2, 4, '2024-07-30', '2024-08-13', NULL),
(3, 4, 5, '2024-08-02', '2024-08-16', '2024-08-15'),
(4, 3, 1, '2024-08-05', '2024-08-19', '2024-08-18'),
(5, 5, 2, '2024-08-08', '2024-08-22', '2024-08-25'),
(1, 4, 5, '2024-08-10', '2024-08-24', '2024-08-23'),
(2, 3, 1, '2024-08-12', '2024-08-26', NULL),
(3, 2, 2, '2024-08-15', '2024-08-29', '2024-08-28'),
(4, 5, 3, '2024-08-18', '2024-09-01', '2024-09-05'),
(5, 1, 4, '2024-08-20', '2024-09-03', '2024-09-02'),
(1, 5, 1, '2024-08-22', '2024-09-05', '2024-09-04'),
(2, 1, 2, '2024-08-25', '2024-09-08', NULL),
(3, 4, 3, '2024-08-28', '2024-09-11', '2024-09-10'),
(4, 3, 4, '2024-08-30', '2024-09-13', '2024-09-15'),
(5, 2, 5, '2024-09-02', '2024-09-16', '2024-09-16'),
(1, 2, 3, '2024-09-05', '2024-09-19', '2024-09-18'),
(2, 5, 4, '2024-09-08', '2024-09-22', NULL),
(3, 1, 5, '2024-09-10', '2024-09-24', '2024-09-23'),
(4, 4, 1, '2024-09-12', '2024-09-26', '2024-09-30'),
(5, 3, 2, '2024-09-15', '2024-09-29', '2024-09-28');