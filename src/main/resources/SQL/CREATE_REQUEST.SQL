DROP TABLE IF EXISTS "tb_request";

CREATE TABLE "tb_request" (
   "request_id" SERIAL NOT NULL,
   "request_type" VARCHAR NULL DEFAULT NULL,
   "request_status" VARCHAR NULL DEFAULT NULL,
   "regist_status" VARCHAR NULL DEFAULT NULL,
   "is_normal" VARCHAR NULL DEFAULT NULL,
   "username" VARCHAR NULL DEFAULT NULL,
   "created_date" timestamp(0),
   "approved_date" timestamp(0),
   "rejection_reason" VARCHAR NULL DEFAULT NULL,
   PRIMARY KEY ("request_id")
)

TABLESPACE pg_default;