CREATE TABLE users (
	user_id int(10) AUTO_INCREMENT NOT NULL,
	user_name varchar(255) NOT NULL,
	user_phone varchar(255),
	username varchar(255) NOT NULL,
	password varchar(255) NOT NULL,
	time_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (user_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE posts (
	post_id int(10) AUTO_INCREMENT NOT NULL,
    	user_id int(10) NOT NULL,
	post_title varchar(255),
	post_descript varchar(255),
	time_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE images (
	img_id int(10) AUTO_INCREMENT NOT NULL,
	user_id int(10) NOT NULL,
	post_id int(10) NOT NULL,
	img_descript varchar(255),
	img_address varchar(255),
	time_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (img_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE post_comments(
	pcm_id int(10) AUTO_INCREMENT NOT NULL,
	user_id int(10) NOT NULL,
	post_id int(10) NOT NULL,
	pcm_comment varchar(255),
	time_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (pdt_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE post_likes(
	post_like_id int(10) AUTO_INCREMENT NOT NULL,
	user_id int(10) NOT NULL,
	post_id int(10) NOT NULL,
	post_like int(1),
	time_reg TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (post_like_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (post_id) REFERENCES posts(post_id)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;