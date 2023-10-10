SELECT
  xt.cnpj
FROM
  tgfnfe,
  XMLTable(
    XMLNamespaces(DEFAULT 'http://www.portalfiscal.inf.br/nfe'),
    '/NFe/infNFe/emit'
    PASSING XMLTYPE(xml)
    COLUMNS
      cnpj VARCHAR2(14) PATH 'CNPJ'
  ) xt
WHERE
  nunota = 5759  ---escolha seu nunota... 

-- Neste caso a hierarquia do xml foi:
--<NFe><infNFe><emit><CNPJ></CNPJ></emit></infNFe></NFe>  
--SELECT * FROM tgfnfe
