CREATE DATABASE fluxo_caixa;

CREATE TABLE IF NOT EXISTS public.lista_sistema (
  id SERIAL NOT NULL,
  tipo VARCHAR(100) NOT NULL,
  codigo VARCHAR(100) NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS public.movimentacao_financeira (
  id SERIAL NOT NULL,
  valor float NOT NULL,
  data timestamp without time zone NOT NULL,
  lista_forma_baixa integer,
  lista_tipo_especie integer,
  observacao VARCHAR(200) NOT NULL,
  PRIMARY KEY(id)
);

ALTER TABLE public.movimentacao_financeira
  ADD CONSTRAINT fk_lista_forma_baixa_movimentacao_financeira FOREIGN KEY (lista_forma_baixa)
    REFERENCES public.lista_sistema(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

ALTER TABLE public.movimentacao_financeira
  ADD CONSTRAINT fk_lista_tipo_especie_movimentacao_financeira FOREIGN KEY (lista_tipo_especie)
    REFERENCES public.lista_sistema(id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    NOT DEFERRABLE;

CREATE SEQUENCE movimentacao_financeira_id_seq OWNED BY public.movimentacao_financeira.id;

INSERT INTO public.lista_sistema ("codigo", "descricao", "tipo")
VALUES 
  (E'01', E'A VISTA', E'FORMA_BAIXA'),
  (E'02', E'A PRAZO', E'FORMA_BAIXA'),
  (E'01', E'DINHEIRO', E'TIPO_ESPECIE'),
  (E'02', E'CARTAO', E'TIPO_ESPECIE');
