DROP TABLE IF EXISTS "tb_word";

CREATE TABLE "tb_word" (
   "standard_word" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "standard_word_eng" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "abbrevation_eng" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "synonyms" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "is_classified" VARCHAR NULL DEFAULT NULL,
   "source" VARCHAR NULL DEFAULT NULL COLLATE "C",
   "definition" VARCHAR NULL DEFAULT NULL COLLATE "C",
   PRIMARY KEY ("request_id")
) INHERITS (tb_request)

TABLESPACE pg_default;