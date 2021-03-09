DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    username VARCHAR(100) NOT NULL PRIMARY KEY,
    password VARCHAR(300) NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'ROLE_USER',
    is_enabled VARCHAR(5) NOT NULL DEFAULT '1',
    firstname VARCHAR(100),
    lastname VARCHAR(100)
    
)
;