  
CREATE TABLE users (
  id integer NOT NULL,
  nome character varying(255) NOT NULL,
  email character varying(255) NOT NULL,
  senha character varying(255) NOT NULL,
  useradmin boolean NOT NULL DEFAULT false,
  usuario_id bigint NOT NULL DEFAULT 1,
  perfil character varying(255),
  sexo character varying(200),
  fotouser text,
  extensaofotouser character varying(255),
  cep character varying(255),
  logradouro character varying(255),
  bairro character varying(255),
  cidade character varying(255),
  uf character varying(255),
  numero character varying(255),
  datanascimento date,
  rendamensal double precision,
  CONSTRAINT users_pkey PRIMARY KEY (id),
  CONSTRAINT usuario_fk FOREIGN KEY (usuario_id)
      REFERENCES public.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT email_unique UNIQUE (email)
);

CREATE SEQUENCE users_id_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
  ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);
  
  INSERT INTO users (email, senha, nome, perfil, sexo, useradmin) VALUES ('admin', 'admin', 'Cesar Montaldi', 'ADMIN', 'MASCULINO', 'TRUE');
  
  CREATE TABLE telefone (
  id integer NOT NULL ,
  numero character varying(50) NOT NULL,
  usuario_id bigint NOT NULL,
  usuario_cad bigint NOT NULL,
  CONSTRAINT telefone_pkey PRIMARY KEY (id),
  CONSTRAINT usuario_cad_fk FOREIGN KEY (usuario_cad)
      REFERENCES public.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT usuario_id_fk FOREIGN KEY (usuario_id)
      REFERENCES public.users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE SEQUENCE telefone_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
  ALTER TABLE telefone ALTER COLUMN id SET DEFAULT nextval('telefone_seq'::regclass);

