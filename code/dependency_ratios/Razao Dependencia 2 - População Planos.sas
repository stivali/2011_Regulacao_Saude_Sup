libname csc 'C:\...\Artigo Ciência e Saúde Coletiva';


/******************  1998 ********************/
data work.RD_98p;
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

If V8005 ne 999;                           		/* Só obs. com idade  */ 
If (V1321 = 1 and V1344 ne 2) or (V1321 = 3);	/* Só com plano       */
If V8005 < 15 then FE=1;				   		/* Crianças     */
	else if V8005 < 65 then FE=2;          		/* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       		/* Velhos       */
If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;

proc freq data = work.RD_98p;
	tables Contrat;
	where Plano = 1;
	*weight v4729;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = work.RD_98p;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;


/* Carrega V1332 do titular guardando a chave do domicílio */

data work.RD_98ptemp;
	set work.RD_98p;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 V4729 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = work.RD_98ptemp;
	tables Contrat2;
	*weight v4729;
run;


proc sort data = work.RD_98p;
	by V0101 UF V0102 V0103;
run;
proc sort data = work.RD_98ptemp;
	by V0101 UF V0102 V0103;
run;


data work.RD_98p;
	merge work.RD_98p (In=A) work.RD_98ptemp (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc freq data = work.RD_98p;
	tables Contrat;
	where Plano = 1;
run;

proc freq data=work.RD_98p;
	weight V4729;
	tables FE*Contrat / nocum out=work.RD_98ptemp;
run;
	


/******************  2003 ********************/
data work.RD_03p;
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

If V8005 ne 999;                           		/* Só obs. com idade  */
If (V1321 = 1 and V1344 ne 2) or (V1321 = 3);	/* Só com plano       */
If V8005 < 15 then FE=1;				   		/* Crianças     */
	else if V8005 < 65 then FE=2;          		/* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       		/* Velhos       */

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;

proc freq data = work.RD_03p;
	tables Contrat;
	where Plano = 1;
	*weight v4729;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = work.RD_03p;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;


/* Carrega V1332 do titular guardando a chave do domicílio */

data work.RD_03ptemp;
	set work.RD_03p;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 V4729 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = work.RD_03ptemp;
	tables Contrat2;
	*weight v4729;
run;


proc sort data = work.RD_03p;
	by V0101 UF V0102 V0103;
run;
proc sort data = work.RD_03ptemp;
	by V0101 UF V0102 V0103;
run;


data work.RD_03p;
	merge work.RD_03p (In=A) work.RD_03ptemp (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc freq data = work.RD_03p;
	tables Contrat;
	where Plano = 1;
run;

proc freq data=work.RD_03p;
	weight V4729;
	tables FE*Contrat / nocum out=work.RD_03ptemp;
run;


/******************  2008 ********************/
data work.RD_08p;
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
		   @00741  V4728   1. /* CÓD. SITUACAO CENSITARIA                                              */
		   @00742  V4729   5. /* PESO DA PESSOA                                                        */
		   @01233  V1321   1. /*  TEM DIR PL SAÚDE, MÉDI,ODONT,PART,EMPRE OU PUBL                      */
		   @01234  V1322   1. /*  PL SAÚ É MUNICIPAL,ESTADUAL MILITAR                                  */
		   @01237  V1324   1. /*  É TITULAR OU DEPEND                                                  */
		   @01248  V1332   1. /*  QUEM PAGA MENSALIDADE                                                */
		   @01264  V1344   1. /*  TEM PLANO SÓ PARA ODONTOLÓG                                          */;

If V8005 ne 999;                           		/* Só obs. com idade  */
If (V1321 = 1 and V1344 ne 2) or (V1321 = 3);	/* Só com plano       */

/* Exclui Zona rural da região norte */
If UF in (11,12,13,14,15,16,17) and v4728 >= 4 then delete; 


If V8005 < 15 then FE=1;				 		/* Crianças     */
	else if V8005 < 65 then FE=2;          		/* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       		/* Velhos       */

If (V1321 = 1 and V1344 ne 2) or (V1321 = 3)  then Plano = 1;
	else Plano = 0;

If V1332 in (1,2,3) then Contrat = "Col";
	else Contrat = "Ind";

Keep V0101 UF V0102 V0103 FE Contrat Plano V0302 V1324 V1332 V4729;
run;

proc freq data = work.RD_08p;
	tables Contrat;
	where Plano = 1;
	*weight v4729;
run;

/* As informações da V1332 só estão disponíveis para os titulares */
*proc freq data = work.RD_08p;
*	tables V1332;
*	where Plano = 1;
*	where V1324 = 4;
*run;


/* Carrega V1332 do titular guardando a chave do domicílio */

data work.RD_08ptemp;
	set work.RD_08p;
	if Plano = 1 and V1324 = 2;
	keep V0101 UF V0102 V0103 V4729 Contrat;
	rename Contrat = Contrat2;
run;

proc freq data = work.RD_08ptemp;
	tables Contrat2;
	*weight v4729;
run;


proc sort data = work.RD_08p;
	by V0101 UF V0102 V0103;
run;
proc sort data = work.RD_08ptemp;
	by V0101 UF V0102 V0103;
run;


data work.RD_08p;
	merge work.RD_08p (In=A) work.RD_08ptemp (In=B);
	by V0101 UF V0102 V0103;
	if (A=1) and (B=1) and V1324 ne 2 then Contrat = Contrat2;
	drop Contrat2;
run;

proc freq data = work.RD_08p;
	tables Contrat;
	where Plano = 1;
run;

proc freq data=work.RD_08p;
	weight V4729;
	tables FE*Contrat / nocum out=work.RD_08ptemp;
run;
	




/******** Juntando os anos em 1 data set **********************/
data work.RD_98T;
	set RD_98ptemp;
	Ano=1998;
run;
data work.RD_03T;
	set RD_03ptemp;
	Ano=2003;
run;
data work.RD_08T;
	set RD_08ptemp;
	Ano=2008;
run;
data csc.RD_IEp;
	set work.RD_98T work.RD_03T work.RD_08T;
run;

proc export data = csc.RD_IEp
		outfile = 'C:\...\Artigo Ciência e Saúde Coletiva\RD_IEp.xls'
		dbms = excel2000 replace;
run;

