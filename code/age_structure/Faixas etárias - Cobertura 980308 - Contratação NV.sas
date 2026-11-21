/* Olha as faixas e a coberturas de planos */

libname csc 'C:\...\Artigo Ciência e Saúde Coletiva';


/******************  1998 ********************/
data csc.FE_98;
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
 	 @776        V1321    1.   /* TEM DIREITO A PLANO DE SAÚDE   */
     @777        V1322    1.   /* PLANO DE ASSISTÊNCIA AO SERVIDOR PÚBLICO*/
	 @779        V1324    1.   /* TITULAR OU DEPENDENTE NO PLANO */
	 @790        V1332    1.   /* QUEM PAGA O PLANO DE SAÚDE     */
	 @802        V1344    1.   /* TEM OUTRO PLANO APENAS ODONTOLÓGICO */;

If V8005 ne 999;                        /* Só obs. com idade */ 
If V8005 < 4 then FE=1;                /* [ 0, 3]  1*/       
	else if V8005 < 9 then FE=2;       /* [ 4, 8]  1*/       
	else if V8005 < 14 then FE=3;      /* [ 9,13]  1*/       
	else if V8005 < 19 then FE=4;      /* [14,18]  1*/       
	else if V8005 < 24 then FE=5;      /* [19,23]  2*/
	else if V8005 < 29 then FE=6;      /* [24,28]  3*/
	else if V8005 < 34 then FE=7;      /* [29,33]  4*/
	else if V8005 < 39 then FE=8;      /* [34,38]  5*/
	else if V8005 < 44 then FE=9;      /* [39,43]  6*/
	else if V8005 < 49 then FE=10;     /* [44,48]  7*/
	else if V8005 < 54 then FE=11;     /* [49,53]  8*/
	else if V8005 < 59 then FE=12;     /* [54,58]  9*/
	else if V8005 < 64 then FE=13;     /* [59,63] 10*/
	else if V8005 < 69 then FE=14;     /* [64,68] 10*/
	else if V8005 < 74 then FE=15;     /* [69,73] 10*/
	else FE=16;     				   /* [74,+ [ 10*/

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;

proc freq data = csc.fe_98;
	tables Contrat;
	where Plano = 1;
	*weight v4729;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = csc.fe_98;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;


/* Carrega V1332 do titular guardando a chave do domicílio */

data csc.temp_98;
	set csc.FE_98;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 V4729 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = csc.temp_98;
	tables Contrat2;
	*weight v4729;
run;


proc sort data = csc.FE_98;
	by V0101 UF V0102 V0103;
run;
proc sort data = csc.temp_98;
	by V0101 UF V0102 V0103;
run;


data csc.FE_98;
	merge csc.FE_98 (In=A) csc.temp_98 (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc delete data = csc.temp_98;

proc freq data = csc.FE_98;
	tables Contrat;
	where Plano = 1;
run;


/*  Homens  */
proc freq data=csc.FE_98;
	weight V4729;
	tables FE*Plano*Contrat / nocum out=csc.FE_H98;
	where V0302 = 2;
run;

/* Mulheres */
proc freq data=csc.FE_98;
	weight V4729;
	tables FE*Plano*Contrat/ nocum out=csc.FE_M98;
	where V0302 = 4;
run;

/**** Juntando Mulheres e Homens ****/

data work.FE_H98;
	set csc.FE_H98;
	POP=-COUNT;
	PERCENT=-PERCENT;
	Sexo='H';
	label POP='População';
	drop COUNT;
data work.FE_M98;
	set csc.FE_M98;
	POP=COUNT;
	Sexo='M';
	label POP='População';
	drop COUNT;
run;

data csc.FE_MH98;
	set work.FE_H98 work.FE_M98;	

proc delete data = csc.FE_98;

run;

proc export data = csc.FE_MH98
		outfile = 'C:\...\Artigo Ciência e Saúde Coletiva\FE_MH.xls'
		dbms = excel2000 replace;
		sheet = "fe1998";
run;



/******************  2003 ********************/
data csc.FE_03;
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
          	@00698  V1321    1.  /* Tem plano de saúde             */
           	@00699  V1322    1.  /* PLANO DE ASSISTÊNCIA AO SERVIDOR PÚBLICO  */
			@00701  V1324    1.  /*                                */
			@00712  V1332    1.  /*                                */
			@00726  V1344    1.  /* TEM OUTRO PLANO APENAS ODONTOLÓGICO  */
			@00887  V4729    5.  /* PESO DA PESSOA                 */;
     			
If V8005 ne 999;                        /* Só obs. com idade */ 
If V8005 < 4 then FE=1;                /* [ 0, 3]  1*/       
	else if V8005 < 9 then FE=2;       /* [ 4, 8]  1*/       
	else if V8005 < 14 then FE=3;      /* [ 9,13]  1*/       
	else if V8005 < 19 then FE=4;      /* [14,18]  1*/       
	else if V8005 < 24 then FE=5;      /* [19,23]  2*/
	else if V8005 < 29 then FE=6;      /* [24,28]  3*/
	else if V8005 < 34 then FE=7;      /* [29,33]  4*/
	else if V8005 < 39 then FE=8;      /* [34,38]  5*/
	else if V8005 < 44 then FE=9;      /* [39,43]  6*/
	else if V8005 < 49 then FE=10;     /* [44,48]  7*/
	else if V8005 < 54 then FE=11;     /* [49,53]  8*/
	else if V8005 < 59 then FE=12;     /* [54,58]  9*/
	else if V8005 < 64 then FE=13;     /* [59,63] 10*/
	else if V8005 < 69 then FE=14;     /* [64,68] 10*/
	else if V8005 < 74 then FE=15;     /* [69,73] 10*/
	else FE=16;     				   /* [74,+ [ 10*/

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;

proc freq data = csc.fe_03;
	tables Contrat;
	where Plano = 1;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = csc.fe_03;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;

/* Carrega V1332 do titular guardando a chave do domicílio */

data csc.temp_03;
	set csc.FE_03;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = csc.temp_03;
	tables Contrat2;
run;


proc sort data = csc.FE_03;
	by V0101 UF V0102 V0103;
run;
proc sort data = csc.temp_03;
	by V0101 UF V0102 V0103;
run;


data csc.FE_03;
	merge csc.FE_03 (In=A) csc.temp_03 (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc delete data = csc.temp_03;

proc freq data = csc.FE_03;
	tables Contrat;
	where Plano = 1;
run;

/* Homens */
proc freq data=csc.FE_03;
	weight V4729;
	tables FE*Plano*Contrat/ nocum out=csc.FE_H03;
	where V0302 = 2;
run;

/* Mulheres */
proc freq data=csc.FE_03;
	weight V4729;
	tables FE*Plano*Contrat/ nocum out=csc.FE_M03;
	where V0302 = 4;
run;

/**** Juntando Mulheres e Homens ****/

data work.FE_H03;
	set csc.FE_H03;
	POP=-COUNT;
	PERCENT=-PERCENT;
	Sexo='H';
	label POP='População';
	drop COUNT;
data work.FE_M03;
	set csc.FE_M03;
	POP=COUNT;
	Sexo='M';
	label POP='População';
	drop COUNT;
run;

data csc.FE_MH03;
	set work.FE_H03 work.FE_M03;	

proc delete data = csc.FE_03;

run;

proc export data = csc.FE_MH03
		outfile = 'C:\...\Artigo Ciência e Saúde Coletiva\FE_MH.xls'
		dbms = excel2000 replace;
		sheet = "fe2003";
run;


/******************  2008 ********************/

data csc.FE_08;
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
		   @01233  V1321   1. /*  TEM DIR PL SAÚDE, MÉDI,ODONT,PART,EMPRE OU PUBL                      */
		   @01234  V1322   1. /*  PL SAÚ É MUNICIPAL,ESTADUAL MILITAR                                  */
		   @01237  V1324   1. /*  É TITULAR OU DEPEND                                                  */
		   @01264  V1344   1. /*  TEM PLANO SÓ PARA ODONTOLÓG                                          */
		   @01248  V1332   1. /*  QUEM PAGA MENSALIDADE                                                */
		   @00741  V4728   1. /* CÓD. SITUACAO CENSITARIA                                              */
		   @00742  V4729   5. /* PESO DA PESSOA                                                        */;
     			

/* Exclui Zona rural da região norte */
If UF in (11,12,13,14,15,16,17) and v4728 >= 4 then delete; 

If V8005 ne 999;                        /* Só obs. com idade */
If V8005 < 4 then FE=1;                /* [ 0, 3]  1*/       
	else if V8005 < 9 then FE=2;       /* [ 4, 8]  1*/       
	else if V8005 < 14 then FE=3;      /* [ 9,13]  1*/       
	else if V8005 < 19 then FE=4;      /* [14,18]  1*/       
	else if V8005 < 24 then FE=5;      /* [19,23]  2*/
	else if V8005 < 29 then FE=6;      /* [24,28]  3*/
	else if V8005 < 34 then FE=7;      /* [29,33]  4*/
	else if V8005 < 39 then FE=8;      /* [34,38]  5*/
	else if V8005 < 44 then FE=9;      /* [39,43]  6*/
	else if V8005 < 49 then FE=10;     /* [44,48]  7*/
	else if V8005 < 54 then FE=11;     /* [49,53]  8*/
	else if V8005 < 59 then FE=12;     /* [54,58]  9*/
	else if V8005 < 64 then FE=13;     /* [59,63] 10*/
	else if V8005 < 69 then FE=14;     /* [64,68] 10*/
	else if V8005 < 74 then FE=15;     /* [69,73] 10*/
	else FE=16;     				   /* [74,+ [ 10*/

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;


proc freq data = csc.fe_08;
	tables Contrat;
	where Plano = 1;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = csc.fe_08;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;

/* Carrega V1332 do titular guardando a chave do domicílio */

data csc.temp_08;
	set csc.FE_08;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = csc.temp_08;
	tables Contrat2;
run;


proc sort data = csc.FE_08;
	by V0101 UF V0102 V0103;
run;
proc sort data = csc.temp_08;
	by V0101 UF V0102 V0103;
run;


data csc.FE_08;
	merge csc.FE_08 (In=A) csc.temp_08 (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc delete data = csc.temp_08;

proc freq data = csc.FE_08;
	tables Contrat;
	where Plano = 1;
run;

proc contents data=csc.FE_08;

/* Homens */
proc freq data=csc.FE_08;
	weight V4729;
	tables FE*Plano*Contrat/ nocum out=csc.FE_H08;
	where V0302 = 2;
run;

/* Mulheres */
proc freq data=csc.FE_08;
	weight V4729;
	tables FE*Plano*Contrat/ nocum out=csc.FE_M08;
	where V0302 = 4;
run;

/**** Juntando Mulheres e Homens ****/

data work.FE_H08;
	set csc.FE_H08;
	POP=-COUNT;
	PERCENT=-PERCENT;
	Sexo='H';
	label POP='População';
	drop COUNT;
data work.FE_M08;
	set csc.FE_M08;
	POP=COUNT;
	Sexo='M';
	label POP='População';
	drop COUNT;
run;

data csc.FE_MH08;
	set work.FE_H08 work.FE_M08;	

proc delete data = csc.FE_08;

run;

proc export data = csc.FE_MH08
		outfile = 'C:\...\Artigo Ciência e Saúde Coletiva\FE_MH.xls'
		dbms = excel2000 replace;
		sheet = "fe2008";
run;


