DROP TABLE IF EXISTS tb_domain;

CREATE TABLE tb_domain (
   request_id INT AUTO_INCREMENT PRIMARY KEY,
   request_type VARCHAR(10) NULL,
   request_status VARCHAR(20) NULL,
   regist_status VARCHAR(10) NULL,
   is_normal VARCHAR(10) NULL,
   username VARCHAR(100) NULL,
   created_date DATETIME,
   approved_date DATETIME,
   rejection_reason VARCHAR(300) NULL,
   domain VARCHAR(100) ,
   type VARCHAR(100) ,
   word_union_kor VARCHAR(200) ,
   word_union_eng VARCHAR(200) ,
   data_type VARCHAR(50) ,
   data_length VARCHAR(10) ,
   definition VARCHAR(500) ,
   word1_id INT ,
   word2_id INT 
) ;