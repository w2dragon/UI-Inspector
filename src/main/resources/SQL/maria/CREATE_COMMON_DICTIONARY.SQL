DROP TABLE IF EXISTS tb_common_dict;

CREATE TABLE tb_common_dict (
   id INT AUTO_INCREMENT PRIMARY KEY,
   grp_id VARCHAR(20) ,
   grp_code VARCHAR(20) ,
   name VARCHAR(200) ,
   attr1 VARCHAR(200) ,
   attr2 VARCHAR(200) ,
   attr3 VARCHAR(200) 
);