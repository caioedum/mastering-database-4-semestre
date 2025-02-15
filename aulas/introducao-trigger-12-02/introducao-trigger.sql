-- Introdu��o a Trigger - 12-02

-- Primeiro exemplo

CREATE TABLE ALUNO_NOVO AS SELECT * FROM ALUNO;

ALTER TABLE ALUNO_NOVO ADD STATUS VARCHAR2(30);

SELECT * FROM ALUNO_NOVO;

-- Primeiro comando de Trigger

CREATE OR REPLACE TRIGGER trg_aluno
    BEFORE INSERT ON ALUNO_NOVO
        FOR EACH ROW
BEGIN
    -- Atualiza o status do pedido para "Novo" ap�s a inser��o
    IF :NEW.STATUS IS NULL THEN
        :NEW.STATUS := 'Novo aluno';
    END IF;
END;

INSERT INTO ALUNO_NOVO (RA, NOME) VALUES (11, 'Devenue'); 

SELECT * FROM ALUNO_NOVO WHERE RA = 10;

-- Segundo exemplo

CREATE TABLE TB_AUDITORIA
(
    ID NUMBER GENERATED ALWAYS AS IDENTITY,
    TABELA VARCHAR2(30),
    OPERACAO VARCHAR2(30),
    DATA DATE,
    USUARIO VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER trg_auditoria
  AFTER INSERT OR UPDATE OR DELETE ON ALUNO_NOVO
  FOR EACH ROW
DECLARE
  operacao     VARCHAR2(30);
  nome_usuario VARCHAR2(100);

BEGIN
  -- Determina a opera��o realizada (INSERT, UPDATE ou DELETE)
  IF INSERTING THEN
    operacao := 'INSERT';
  ELSIF UPDATING THEN
    operacao := 'UPDATE';
  ELSIF DELETING THEN
    operacao := 'DELETE';
  END IF;

  -- Obt�m o nome de usu�rio da sess�o atual
  nome_usuario := SYS_CONTEXT('USERENV', 'SESSION_USER');

  -- Registra a auditoria na tabela de auditoria
  INSERT INTO TB_AUDITORIA
    (tabela, operacao, DATA, USUARIO)
  VALUES
    ('ALUNO NOVO', operacao, sysdate, nome_usuario);
END;

SELECT * FROM TB_AUDITORIA;

UPDATE ALUNO_NOVO SET RA = 5 WHERE RA = 10;

DELETE FROM ALUNO_NOVO WHERE RA = 5;