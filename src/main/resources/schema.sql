CREATE SCHEMA IF NOT EXISTS lostandfound;
USE lostandfound;

CREATE TABLE IF NOT EXISTS User (
                                    user_id INT PRIMARY KEY AUTO_INCREMENT,
                                    full_name VARCHAR(100) NOT NULL,
                                    email VARCHAR(100) UNIQUE NOT NULL,
                                    phone VARCHAR(15),
                                    role ENUM('student', 'staff') NOT NULL,
                                    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS ItemType (
                                        item_type_id INT PRIMARY KEY AUTO_INCREMENT,
                                        type_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS Item (
                                    item_id INT PRIMARY KEY AUTO_INCREMENT,
                                    item_name VARCHAR(100) NOT NULL,
                                    item_type_id INT NOT NULL,
                                    description TEXT,
                                    image_path VARCHAR(255),
                                    FOREIGN KEY (item_type_id) REFERENCES ItemType(item_type_id)
);

CREATE TABLE IF NOT EXISTS Report (
                                      report_id INT PRIMARY KEY AUTO_INCREMENT,
                                      user_id INT NOT NULL,
                                      item_id INT NOT NULL,
                                      report_type ENUM('lost', 'found') NOT NULL,
                                      location VARCHAR(100) NOT NULL,
                                      date_reported DATE NOT NULL,
                                      status ENUM('pending', 'resolved') DEFAULT 'pending',
                                      FOREIGN KEY (user_id) REFERENCES User(user_id),
                                      FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE IF NOT EXISTS Contact (
                                       contact_id INT PRIMARY KEY AUTO_INCREMENT,
                                       user_id INT NOT NULL,
                                       name VARCHAR(100) NOT NULL,
                                       email VARCHAR(100) NOT NULL,
                                       subject VARCHAR(200) NOT NULL,
                                       message TEXT NOT NULL,
                                       date_sent DATETIME DEFAULT CURRENT_TIMESTAMP,
                                       FOREIGN KEY (user_id) REFERENCES User(user_id)
);