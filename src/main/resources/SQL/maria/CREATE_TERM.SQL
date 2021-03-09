DROP TABLE IF EXISTS tb_term;

CREATE TABLE tb_term (
   request_id INT AUTO_INCREMENT PRIMARY KEY,
   request_type VARCHAR(10) NULL,
   request_status VARCHAR(20) NULL,
   regist_status VARCHAR(10) NULL,
   is_normal VARCHAR(10) NULL,
   username VARCHAR(100) NULL,
   created_date DATETIME,
   approved_date DATETIME,
   rejection_reason VARCHAR(300) NULL,
   term VARCHAR(100) ,
   domain_id INT ,
   word_decomposition_kor VARCHAR(200) ,
   word_decomposition_eng VARCHAR(200) ,
   definition VARCHAR(500) 
) ;