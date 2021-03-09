DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    username character varying(31) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    role character varying(31) COLLATE pg_catalog."default" NOT NULL DEFAULT 'ROLE_USER'::character varying,
    is_enabled boolean NOT NULL DEFAULT true,
    firstname character varying(31) COLLATE pg_catalog."default",
    lastname character varying(31) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (username)
)

TABLESPACE pg_default;