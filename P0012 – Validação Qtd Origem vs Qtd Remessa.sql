

CREATE OR REPLACE PROCEDURE STP_VALIDA_ITENS_ENT_FUT_2 (P_NUNOTA INT, P_SEQUENCIA INT, P_SUCESSO OUT VARCHAR,P_MENSAGEM OUT VARCHAR2,
P_CODUSULIB OUT NUMBER)

CREATE OR REPLACE PROCEDURE TESTE.STP_VALIDA_ITENS_ENT_FUT_2 (
P_CODUSU NUMBER,
P_IDSESSAO VARCHAR2,
P_QTDLINHAS NUMBER,
P_MENSAGEM OUT VARCHAR2
) AS




	P_SUM1 INT;
	P_SUM2 INT;
BEGIN
	BEGIN
       	SELECT 
	       	SUM(ITE1.QTDNEG-ITE1.QTDENTREGUE) INTO P_SUM1
        FROM TGFITE ITE
	        INNER JOIN TGFVAR VAR ON ITE.NUNOTA = VAR.NUNOTA AND ITE.SEQUENCIA = VAR.SEQUENCIA 
			INNER JOIN TGFITE ITE1 ON VAR.NUNOTAORIG = ITE1.NUNOTA AND VAR.SEQUENCIAORIG = ITE1.SEQUENCIA
        WHERE ITE.NUNOTA = P_NUNOTA AND ITE.SEQUENCIA = P_SEQUENCIA;
        SELECT 
        	SUM(VAR.QTDATENDIDA) INTO P_SUM2
        FROM TGFVAR VAR
        WHERE VAR.NUNOTA = P_NUNOTA AND VAR.SEQUENCIA = P_SEQUENCIA;

		IF P_SUM2 > P_SUM1 THEN 
		    P_MENSAGEM := 'A qtd. nota remessa não pode ser maior que a qtd. pendente nota de origem!';
		--ELSE
		--    P_MENSAGEM := 'Ok, prossiga!';
		END IF;
	
	--EXCEPTION
    --   WHEN NO_DATA_FOUND THEN
    --        DBMS_OUTPUT.PUT_LINE('Nenhum dado encontrado.');
    --   WHEN OTHERS THEN
    --        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);	
	END;
END;



----/*chamar procedure para testar:
DECLARE

	P_NUNOTA INT := 19125;
	P_SEQUENCIA INT := 1;

BEGIN
   TESTE.STP_VALIDA_ITENS_ENT_FUT_2 (P_NUNOTA,P_SEQUENCIA);
END;
--*/

CREATE OR REPLACE PROCEDURE STP_VALIDA_ITENS_ENT_FUT_3(P_NUNOTA INT, P_SEQUENCIA INT, 
P_SUCESSO OUT VARCHAR, P_MENSAGEM OUT VARCHAR2, P_CODUSULIB OUT NUMBER)

AS

  BEGIN  

 --DA MESMA FORMA QUE NA ANTERIOR, AQUI TERIA A ROTINA EM SI...
 P_SUCESSO := 'N';
 P_MENSAGEM := 'A REGRA FALHOU DE PROPÓSITO, SÓ PARA TESTAR.';
 P_CODUSULIB := 0;
END; 

