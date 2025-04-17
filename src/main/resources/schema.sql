CREATE SCHEMA IF NOT EXISTS lostandfound;
USE lostandfound;

CREATE TABLE IF NOT EXISTS User (
                                    user_id INT PRIMARY KEY AUTO_INCREMENT,
                                    full_name VARCHAR(50) NOT NULL,
                                    email VARCHAR(50) UNIQUE NOT NULL,
                                    username VARCHAR(50) UNIQUE NOT NULL,
                                    password VARCHAR(50) NOT NULL,
                                    role ENUM('admin', 'user') DEFAULT 'user',
                                    phone VARCHAR(20),
                                    address TEXT,
                                    dateofbirth DATE,
                                    gender ENUM('male', 'female', 'other'),
                                    profilePicture BLOB,
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Report (
                                      report_id INT PRIMARY KEY AUTO_INCREMENT,
                                      user_id INT,
                                      req_type ENUM('lost', 'found') NOT NULL,
                                      location VARCHAR(150),
                                      date_reported DATE NOT NULL,
                                      status ENUM('unclaimed', 'claimed', 'returned') DEFAULT 'unclaimed',
                                      item_name VARCHAR(100) NOT NULL,
                                      item_type VARCHAR(50),
                                      description TEXT,
                                      image BLOB,
                                      FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Contact (
                                       contact_id INT PRIMARY KEY AUTO_INCREMENT,
                                       user_id INT,
                                       name VARCHAR(100),
                                       email VARCHAR(100),
                                       subject VARCHAR(150),
                                       message TEXT,
                                       msg_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE
);