DROP TABLE IF EXISTS tb_word;

CREATE TABLE tb_word (
   request_id INT AUTO_INCREMENT PRIMARY KEY,
   request_type VARCHAR(10) NULL,
   request_status VARCHAR(20) NULL,
   regist_status VARCHAR(10) NULL,
   is_normal VARCHAR(10) NULL,
   username VARCHAR(100) NULL,
   created_date DATETIME,
   approved_date DATETIME,
   rejection_reason VARCHAR(300) NULL,
   standard_word VARCHAR(300) ,
   standard_word_eng VARCHAR(300) ,
   abbrevation_eng VARCHAR(300) ,
   synonyms VARCHAR(300) ,
   is_classified VARCHAR(100) ,
   source VARCHAR(300) ,
   definition VARCHAR(500) 
   
) ;