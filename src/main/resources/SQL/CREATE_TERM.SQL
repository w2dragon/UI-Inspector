DROP TABLE IF EXISTS "tb_term";

CREATE TABLE "tb_term" (
   "term" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "domain_id" INTEGER NULL DEFAULT NULL,
   "word_decomposition_kor" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "word_decomposition_eng" VARCHAR NULL DEFAULT NULL,
   "definition" VARCHAR NULL DEFAULT NULL
) INHERITS (tb_request)

TABLESPACE pg_default;