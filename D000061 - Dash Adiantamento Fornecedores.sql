

select sum(fin.vlrdesdob)vlrdesdob from tgffin fin
inner join tgfnat nat on fin.codnat = nat.codnat
where 
fin.codnat in (9020000)
and fin.dhbaixa is NULL

SELECT * FROM TGFFIN

select 
fin.CODEMP,
fin.NUFIN,
fin.NUMNOTA,
fin.DTNEG,
fin.DTVENC,
fin.CODPARC,
par.RAZAOSOCIAL,
fin.CODTIPOPER,
fin.CODBCO,
fin.CODCTABCOINT,
fin.CODNAT,
fin.CODCENCUS,
fin.CODTIPTIT,
fin.VLRDESDOB,
((nvl(FIN.VLRDESDOB,0) + (CASE WHEN FIN.TIPMULTA = '1' THEN nvl(FIN.VLRMULTA,0) ELSE 0 END) 
+ (CASE WHEN FIN.TIPJURO = '1' THEN nvl(FIN.VLRJURO,0) ELSE 0 END) + nvl(FIN.DESPCART,0) 
+ nvl(FIN.VLRVENDOR,0) - nvl(FIN.VLRDESC,0) 
- (CASE WHEN FIN.IRFRETIDO = 'S' THEN nvl(FIN.VLRIRF,0) ELSE 0 END) 
- (CASE WHEN FIN.ISSRETIDO = 'S' THEN nvl(FIN.VLRISS,0) ELSE 0 END) 
- (CASE WHEN FIN.INSSRETIDO = 'S' THEN nvl(FIN.VLRINSS,0) ELSE 0 END) 
- nvl(FIN.CARTAODESC,0) 
+ nvl((SELECT ROUND(SUM(I.VALOR * I.TIPIMP),2) FROM TGFIMF I WHERE I.NUFIN = FIN.NUFIN),0) 
+ nvl(FIN.VLRMULTANEGOC,0) + nvl(FIN.VLRJURONEGOC,0) 
- nvl(FIN.VLRMULTALIB,0) - nvl(FIN.VLRJUROLIB,0) 
+ nvl(FIN.VLRVARCAMBIAL,0)) * nvl(FIN.RECDESP,0))VLRLIQ
from tgffin fin
inner join tgfnat nat on fin.codnat = nat.codnat
INNER JOIN tgfpar par ON fin.codparc = par.codparc
where 
fin.codnat in (9020000)
and fin.dhbaixa is null