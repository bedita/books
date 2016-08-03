DROP TABLE IF EXISTS `books`;

CREATE TABLE books (
  id INTEGER UNSIGNED NOT NULL,
  isbn CHAR(13) NULL COMMENT 'International standard book number, can be NULL',
  year INT(4) NULL DEFAULT NULL COMMENT 'publication or edition year, can be NULL',
  series VARCHAR(255) NULL COMMENT 'book serie, can be NULL',
  location VARCHAR(255) NULL COMMENT 'book location (for library), can be NULL',
  book_type VARCHAR(255) NULL COMMENT 'type of book, can be NULL',
  digital_price FLOAT(10,2) NULL COMMENT 'digital item price',
  PRIMARY KEY(id),
  FOREIGN KEY(id)
    REFERENCES products(id)
      ON DELETE CASCADE
      ON UPDATE NO ACTION
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT = 'books' ;