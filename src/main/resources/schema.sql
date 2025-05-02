CREATE SCHEMA IF NOT EXISTS lostandfound;
USE lostandfound;

CREATE TABLE IF NOT EXISTS User (
                                    user_id INT PRIMARY KEY AUTO_INCREMENT,
                                    full_name VARCHAR(50) NOT NULL,
                                    email VARCHAR(50) UNIQUE NOT NULL,
                                    phone VARCHAR(20),
                                    address TEXT,
                                    username VARCHAR(50) UNIQUE NOT NULL,
                                    password VARCHAR(50) NOT NULL,
                                    dateofbirth DATE,
                                    gender ENUM('male', 'female', 'other'),
                                    profilePicture BLOB,
                                    role ENUM('admin', 'user') DEFAULT 'user',
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Report (
                                      report_id INT PRIMARY KEY AUTO_INCREMENT,
                                      user_id INT,
                                      req_type ENUM('lost', 'found') NOT NULL,
                                      location VARCHAR(50),
                                      date_reported DATE NOT NULL,
                                      status ENUM('unclaimed', 'claimed', 'returned') DEFAULT 'unclaimed',
                                      item_id INT NOT NULL,
                                      item_name VARCHAR(50) NOT NULL,
                                      image BLOB,
                                      description TEXT,
                                      item_type_id INT NOT NULL,
                                      item_type VARCHAR(50),
                                      FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ContactUS (
                                       contact_id INT PRIMARY KEY AUTO_INCREMENT,
                                       user_id INT,
                                       name VARCHAR(50),
                                       email VARCHAR(50),
                                       subject VARCHAR(50),
                                       message TEXT,
                                       msg_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

ALTER TABLE User MODIFY password VARCHAR(255);

ALTER TABLE user
    MODIFY profilePicture LONGBLOB;