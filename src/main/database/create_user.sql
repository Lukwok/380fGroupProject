CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    phone VARCHAR(8) DEFAULT NULL,
    fullname VARCHAR(255) DEFAULT NULL,
    address VARCHAR(255) DEFAULT NULL,
    
    PRIMARY KEY (username)
);

CREATE TABLE user_roles (
    user_role_id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_role_id),
    FOREIGN KEY (username) REFERENCES users(username)
);

CREATE TABLE photo(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
    filename VARCHAR(255) DEFAULT NULL,
    content_type VARCHAR(255) DEFAULT NULL,
    content BLOB DEFAULT NULL,
    item_id INTEGER DEFAULT NULL,
    PRIMARY KEY (id),
);

INSERT INTO users VALUES ('keith', '{noop}keithpw');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_USER');
INSERT INTO user_roles(username, role) VALUES ('keith', 'ROLE_ADMIN');

INSERT INTO users VALUES ('vanessa', '{noop}vanessapw');
INSERT INTO user_roles(username, role) VALUES ('vanessa', 'ROLE_ADMIN');

INSERT INTO users VALUES ('kevin', '{noop}kevinpw');
INSERT INTO user_roles(username, role) VALUES ('kevin', 'ROLE_USER');

INSERT INTO users VALUES ('user', '{noop}user');
INSERT INTO user_roles(username, role) VALUES ('user', 'ROLE_USER');

INSERT INTO users VALUES ('admin', '{noop}admin');
INSERT INTO user_roles(username, role) VALUES ('admin', 'ROLE_ADMIN');
