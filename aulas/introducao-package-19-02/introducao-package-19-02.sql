-- Introdução a Package - 19-02

-- Primeiro exemplo

CREATE OR REPLACE PACKAGE pkg_exemplo AS
    v_count NUMBER := 0;  -- Variável pública
    FUNCTION fun_valida_nome2 (
        p_nome IN VARCHAR2
    ) RETURN BOOLEAN;  -- Função pública
    CURSOR cursor_vendas_publi IS
    SELECT
        *
    FROM
        tabela_vendas; --Cursor público
    PROCEDURE prc_insere_produtos_novos; -- Producedure sem parâmetros

    PROCEDURE prc_insere_pedido (
        p_cod_pedido             pedido.cod_pedido%TYPE,
        p_cod_pedido_relacionado pedido.cod_pedido%TYPE,
        p_cod_cliente            pedido.cod_cliente%TYPE,
        p_cod_usuario            pedido.cod_usuario%TYPE,
        p_cod_vendedor           pedido.cod_vendedor%TYPE,
        p_dat_pedido             pedido.dat_pedido%TYPE,
        p_dat_cancelamento       pedido.dat_cancelamento%TYPE,
        p_dat_entrega            pedido.dat_entrega%TYPE,
        p_val_total_pedido       pedido.val_total_pedido%TYPE,
        p_val_desconto           pedido.val_desconto%TYPE,
        p_seq_endereco_cliente   pedido.seq_endereco_cliente%TYPE) IS
BEGIN
        INSERT INTO Pedido_Novos
      (cod_pedido,
       cod_pedido_relacionado,
       cod_cliente,
       cod_usuario,
       cod_vendedor,
       dat_pedido,
       dat_cancelamento,
       dat_entrega,
       val_total_pedido,
       val_desconto,
       seq_endereco_cliente)
    VALUES
      (p_cod_pedido,
       p_cod_pedido_relacionado,
       p_cod_cliente,
       p_cod_usuario,
       p_cod_vendedor,
       p_dat_pedido,
       p_dat_cancelamento,
       p_dat_entrega,
       p_val_total_pedido,
       p_val_desconto,
       p_seq_endereco_cliente);  -- Procedimento público
END pkg_exemplo;

CALL PKG_EXEMPLO.PRC_INSERE_PRODUTOS_NOVOS()

SELECT * FROM PRODUTOS_NOVOS;

TRUNCATE TABLE PRODUTOS_NOVOS;

exec pkg_exemplo.PRC_INSERE_PEDIDO(10010, 5555, 55888, 5555, 6658, sysdate, sysdate+10, sysdate+1, 20000, 5, 55544);

COMMIT;