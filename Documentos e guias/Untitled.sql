CREATE TABLE "pais" (
  "id" int PRIMARY KEY,
  "nome" text
);

CREATE TABLE "estado" (
  "id" int PRIMARY KEY,
  "nome" text,
  "pais_id" int
);

CREATE TABLE "municipio" (
  "id" int PRIMARY KEY,
  "nome" text,
  "estado_id" int
);

CREATE TABLE "cnes_estabelecimentos" (
  "cnes" char(7) PRIMARY KEY,
  "nome" text,
  "municipio_id" int
);

CREATE TABLE "cnes_equipamentos" (
  "cnes" char(7),
  "competencia" int,
  "codequip" int,
  PRIMARY KEY ("cnes", "competencia", "codequip")
);

CREATE TABLE "cnes_leitos" (
  "cnes" char(7),
  "competencia" int,
  "codleito" int,
  PRIMARY KEY ("cnes", "competencia", "codleito")
);

CREATE TABLE "cnes_servicos" (
  "cnes" char(7),
  "competencia" int,
  "servico" int,
  PRIMARY KEY ("cnes", "competencia", "servico")
);

CREATE TABLE "cnes_profissionais" (
  "cnes" char(7),
  "competencia" int,
  "cpf_hash" char(64),
  PRIMARY KEY ("cnes", "competencia", "cpf_hash")
);

CREATE TABLE "sia" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "co_proced" char(10),
  "quantidade" int,
  "valor_total" decimal,
  PRIMARY KEY ("cnes", "competencia", "co_proced")
);

CREATE TABLE "sih" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "internacoes" int,
  "diarias" int,
  "valor_total" decimal,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "sim" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "obitos" int,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "sinan" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "casos" int,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "sisab" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "atendimentos" int,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "sipni" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "doses" int,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "sisvan" (
  "id" int PRIMARY KEY,
  "cnes" char(7),
  "competencia" int,
  "registros" int,
  PRIMARY KEY ("cnes", "competencia")
);

CREATE TABLE "analise_por_hospital" (
  "cnes" char(7),
  "competencia" int,
  "indicadores" jsonb
);

CREATE TABLE "analise_consolidada" (
  "competencia" int,
  "municipio_id" int,
  "agregados" jsonb
);

ALTER TABLE "estado" ADD FOREIGN KEY ("pais_id") REFERENCES "pais" ("id");

ALTER TABLE "municipio" ADD FOREIGN KEY ("estado_id") REFERENCES "estado" ("id");

ALTER TABLE "cnes_estabelecimentos" ADD FOREIGN KEY ("municipio_id") REFERENCES "municipio" ("id");

ALTER TABLE "cnes_equipamentos" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "cnes_leitos" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "cnes_servicos" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "cnes_profissionais" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sia" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sih" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sim" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sinan" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sisab" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sipni" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "sisvan" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "analise_por_hospital" ADD FOREIGN KEY ("cnes") REFERENCES "cnes_estabelecimentos" ("cnes");

ALTER TABLE "analise_consolidada" ADD FOREIGN KEY ("municipio_id") REFERENCES "municipio" ("id");
