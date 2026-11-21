/* Calcula as diferentes prevalências segundo a cobertura ou não de planos */

libname csc 'C:\Data\PNAD\SAS';

%Macro Recod(variavel);
if &variavel in (1,2) then &variavel.b = 1;
	else if &variavel. in (3,4) then &variavel.b = 0;
	else if &variavel. in (.,9) then delete;
%Mend Recod;


/******************  1998 ********************/
data csc.PREV_98;
     INFILE 'C:\Data\PNAD\1998\Dados\Pessoa98.txt' LRECL=1026 MISSOVER;
     INPUT
     @1          V0101    2.   /* ANO DA PESQUISA                */
     @3          UF       2.   /* CODIGO DA UNIDADE DA FEDERACAO */
     @5          V0102    6.   /* NUMERO DE CONTROLE             */
     @11         V0103    3.   /* NUMERO DE SERIE                */
     @14         V0301    2.   /* NUMERO DE ORDEM                */
     @16         V0302    1.   /* SEXO                           */
     @17         V3031    2.   /* DIA DE NASCIMENTO              */
     @19         V3032    2.   /* MES DE NASCIMENTO              */
     @21         V3033    3.   /* ANO DE NASCIMENTO              */
     @24         V8005    3.   /* IDADE DO MORADOR               */
     @27         V0401    1.   /* CONDICAO NA UNIDADE DOMICILIAR */
     @28         V0402    1.   /* CONDICAO NA FAMILIA            */
     @29         V0403    1.   /* NUMERO DA FAMILIA              */
     @30         V0404    1.   /* COR OU RACA                    */
	 @741        V4729    5.   /* PESO PESSOA                    */
     @764        V1309    1.   /* TEM DOENÇA DE COLUNA OU COSTAS */
     @765        V1310    1.   /* TEM ARTRITE OU REUMATISMO      */
     @766        V1311    1.   /* TEM CÂNCER                     */
     @767        V1312    1.   /* TEM DIABETES                   */
     @768        V1313    1.   /* TEM BRONQUITE OU ASMA          */
     @769        V1314    1.   /* TEM HIPERTENSÃO                */
     @770        V1315    1.   /* TEM DOENÇA DO CORAÇÃO          */
     @771        V1316    1.   /* TEM DOENÇA RENAL CRÔNICA       */
     @772        V1317    1.   /* TEM DEPRESSÃO                  */
     @773        V1318    1.   /* TEM TUBERCULOSE                */
     @774        V1319    1.   /* TEM TENDINITE OU TENOSSINOVITE */
     @775        V1320    1.   /* TEM CIRROSE                    */
 	 @776        V1321    1.   /* TEM DIREITO A PLANO DE SAÚDE   */
     @777        V1322    1.   /* PLANO DE ASSISTÊNCIA AO SERVIDOR PÚBLICO*/
	 @802        V1344    1.   /* TEM OUTRO PLANO APENAS ODONTOLÓGICO */
     @806        V1347    1.   /* CONSULTOU MÉDICO NOS ÚLTIMOS 12 MESES */
     @807        V1348    2.   /* QTAS VEZES CONSULTOU MÉDICO ÚLT.12 MESES */
     @835        V1369    1.   /* INTERNAÇÃO HOSPITALAR NOS ÚLT. 12 MESES */
	 @836        V1370    2.   /* QUANTAS INTERNAÇÕES HOSPITALARES */;

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;


%Recod(V1309);
%Recod(V1310);
%Recod(V1311);
%Recod(V1312);
%Recod(V1313);
%Recod(V1314);
%Recod(V1315);
%Recod(V1316);
%Recod(V1317);
%Recod(V1318);
%Recod(V1319);
%Recod(V1320);


run;

/******************  2003 ********************/
data csc.PREV_03;
     INFILE 'C:\Data\PNAD\2003\Dados\PES2003.TXT' LRECL=901 MISSOVER;
     INPUT  
			@00001  V0101    4.  /* ANO DA PESQUISA                */
            @00005  UF       2.  /* UNIDADE DA FEDERAÇÃO           */
            @00005  V0102    8.  /* NÚMERO DE CONTROLE             */
            @00013  V0103    3.  /* NÚMERO DE SERIE                */
            @00016  V0301    2.  /* NÚMERO DE ORDEM                */
            @00018  V0302    1.  /* SEXO                           */
            @00019  V3031    2.  /* DIA DE NASCIMENTO              */
            @00021  V3032    2.  /* MÊS DE NASCIMENTO              */
            @00023  V3033    4.  /* ANO DE NASCIMENTO              */
            @00027  V8005    3.  /* IDADE DO MORADOR               */
            @00030  V0401    1.  /* CONDIÇÃO NA UNIDADE DOMICILIAR */
            @00031  V0402    1.  /* CONDIÇÃO NA FAMÍLIA            */
            @00032  V0403    1.  /* NÚMERO DA FAMÍLIA              */
            @00033  V0404    1.  /* COR OU RACA                    */
            @00686  V1309    1.  /*                                */
            @00687  V1310    1.  /*                                */
            @00688  V1311    1.  /*                                */
            @00689  V1312    1.  /*                                */
            @00690  V1313    1.  /*                                */
            @00691  V1314    1.  /*                                */
            @00692  V1315    1.  /*                                */
            @00693  V1316    1.  /*                                */
            @00694  V1317    1.  /*                                */
            @00695  V1318    1.  /*                                */
            @00696  V1319    1.  /*                                */
            @00697  V1320    1.  /*                                */
          	@00698  V1321    1.  /* Tem plano de saúde             */
           	@00699  V1322    1.  /* PLANO DE ASSISTÊNCIA AO SERVIDOR PÚBLICO  */
			@00726  V1344    1.  /* TEM OUTRO PLANO APENAS ODONTOLÓGICO  */
            @00730  V1347    1.  /*                                */
            @00731  V1348    2.  /*                                */
            @00759  V1369    1.  /*                                */
            @00760  V1370    2.  /*                                */
			@00887  V4729    5.  /* PESO DA PESSOA                 */;
     			

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

%Recod(V1309);
%Recod(V1310);
%Recod(V1311);
%Recod(V1312);
%Recod(V1313);
%Recod(V1314);
%Recod(V1315);
%Recod(V1316);
%Recod(V1317);
%Recod(V1318);
%Recod(V1319);
%Recod(V1320);

run;

/******************  2008 ********************/
data csc.PREV_08;
	INFILE 'C:\Data\PNAD\2008\Dados\PES2008.TXT' LRECL=1495 MISSOVER;
	INPUT
		   @00001  V0101   4. /* ANO DE REFERÊNCIA                                                     */
		   @00005  UF      2. /* UNIDADE DA FEDERAÇÃO                                                  */
		   @00005  V0102   8. /* NÚMERO DE CONTROLE                                                    */
		   @00013  V0103   3. /* NÚMERO DE SÉRIE                                                       */
		   @00016  V0301   2. /* NÚMERO DE ORDEM                                                       */
		   @00018  V0302   1. /* SEXO                                                                  */
		   @00019  V3031   2. /* DIA DE NASCIMENTO                                                     */
		   @00021  V3032   2. /* MÊS DE NASCIMENTO                                                     */
		   @00023  V3033   4. /* ANO DE NASCIMENTO                                                     */
		   @00027  V8005   3. /* IDADE DO MORADOR                                                      */
		   @00030  V0401   1. /* CONDIcAO NA UNIDADE DOMICILIAR                                        */
		   @00031  V0402   1. /* CONDIcAO NA FAMÍLIA                                                   */
		   @00032  V0403   1. /* NÚMERO DA FAMÍLIA                                                     */
		   @00033  V0404   1. /* COR OU RACA                                                           */
		   @01221  V1309   1. /*  ALG MÉD OU PROF SAÚ DIS TER DOENÇA COLUNA OU COSTA                   */
		   @01222  V1310   1. /*  ALG MÉD OU PROF SAÚ DIS TER ARTRITE OU REUMAST                       */
		   @01223  V1311   1. /*  ALG MÉD OU PROF SAÚ DIS TER CÂNCER                                   */
		   @01224  V1312   1. /*  ALG MÉD OU PROF SAÚ DIS TER DIABETES                                 */
		   @01225  V1313   1. /*  ALG MÉD OU PROF SAÚ DIS TER BRONQU OU ASMA                           */
		   @01226  V1314   1. /*  ALG MÉD OU PROF SAÚ DIS TER HIPERT (PRES ALT)                        */
		   @01227  V1315   1. /*  ALG MÉD OU PROF SAÚ DIS TER DOENÇA DO CORAÇÃO                        */
		   @01228  V1316   1. /*  ALG MÉD OU PROF SAÚ DIS TER INSUF RENAL CRON                         */
		   @01229  V1317   1. /*  ALG MÉD OU PROF SAÚ DIS TER DEPRESSÃO                                */
		   @01230  V1318   1. /*  ALG MÉD OU PROF SAÚ DIS TER TUBERCULOSE                              */
		   @01231  V1319   1. /*  ALG MÉD OU PROF SAÚ DIS TER TENDINITE OU TENOS                       */
		   @01232  V1320   1. /*  ALG MÉD OU PROF SAÚ DIS TER CIRROSE                                  */
		   @01233  V1321   1. /*  TEM DIR PL SAÚDE, MÉDI,ODONT,PART,EMPRE OU PUBL                      */
		   @01234  V1322   1. /*  PL SAÚ É MUNICIPAL,ESTADUAL MILITAR                                  */
		   @01264  V1344   1. /*  TEM PLANO SÓ PARA ODONTOLÓG                                          */
		   @01268  V1347   1. /*  ÚLTIMOS DOZES MES CONSULTOU MÉD                                      */
		   @01269  V1348   2. /*  QTAS VEZES  CONSULTOU NOS ÚLT DOZE MES                               */
		   @01306  V1369   1. /*  DOZE ÚLTIM MES ESTEV INTERNAD                                        */
		   @01307  V1370   2. /*  QTS VEZES ESTEV INTERN                                               */
		   @00741  V4728   1. /* CÓD. SITUACAO CENSITARIA                                              */
		   @00742  V4729   5. /* PESO DA PESSOA                                                        */;
     			
/* Exclui Zona rural da região norte */
If UF in (11,12,13,14,15,16,17) and v4728 >= 4 then delete; 

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

%Recod(V1309);
%Recod(V1310);
%Recod(V1311);
%Recod(V1312);
%Recod(V1313);
%Recod(V1314);
%Recod(V1315);
%Recod(V1316);
%Recod(V1317);
%Recod(V1318);
%Recod(V1319);
%Recod(V1320);

run;

%Macro Preval(Data=,Ano=,Morb=);

proc freq data=csc.&Data;
			weight V4729;
			tables &Morb*Plano / out = work.&Morb;
run;

data &Morb (RENAME = (&Morb = cod) DROP = Percent);
			set &Morb;
			Morbi = "&Morb";
			Ano = &Ano;
run;

proc transpose data = &Morb out = &Morb;
	by Ano Morbi cod plano;
run;

%Mend Preval;

%Preval(Data=PREV_98,Ano=1998,Morb=V1309b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1310b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1311b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1312b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1313b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1314b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1315b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1316b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1317b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1318b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1319b);
%Preval(Data=PREV_98,Ano=1998,Morb=V1320b);

data preval_98 (DROP = _NAME_ _LABEL_);
	set V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;

proc delete data = V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;

%Preval(Data=PREV_03,Ano=2003,Morb=V1309b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1310b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1311b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1312b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1313b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1314b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1315b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1316b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1317b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1318b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1319b);
%Preval(Data=PREV_03,Ano=2003,Morb=V1320b);

data preval_03 (DROP = _NAME_ _LABEL_);
	set V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;

proc delete data = V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;


%Preval(Data=PREV_08,Ano=2008,Morb=V1309b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1310b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1311b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1312b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1313b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1314b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1315b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1316b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1317b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1318b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1319b);
%Preval(Data=PREV_08,Ano=2008,Morb=V1320b);

data preval_08 (DROP = _NAME_ _LABEL_);
	set V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;

proc delete data = V1309b V1310b V1311b V1312b V1313b V1314b V1315b V1316b V1317b V1318b V1319b V1320b;
run;


proc export data = work.Preval_98
		outfile = 'C:\Data\PNAD\Prevalencias.xls'
		dbms = excel2000 replace;
		sheet = "1998";
proc export data = work.Preval_03
		outfile = 'C:\Data\PNAD\Prevalencias.xls'
		dbms = excel2000 replace;
		sheet = "2003";
proc export data = work.Preval_08
		outfile = 'C:\Data\PNAD\Prevalencias.xls'
		dbms = excel2000 replace;
		sheet = "2008";
run;
