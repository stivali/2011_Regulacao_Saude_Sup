libname csc 'C:\...\Artigo Ciência e Saúde Coletiva\SAS';


/******************  1978 ********************/
data work.RD_78;
  	INFILE 'C:\Data\PNAD\1978\Dados\PNAD78BR.DAT' LRECL=295  MISSOVER;

	INPUT @12 TIPO 1. @;
    IF TIPO = 2;

    INPUT          
			    @001     UF     2.  /* CODIGO DA UNIDADE DA FEDERACAO */
				@013     V2203  1.  /* SEXO                           */
				@015     V2205  2.  /* CONDICAO NA UNIDADE DOMICILIAR */
				@017     V2206  2.  /* CONDICAO NA FAMILIA            */
				@019     V2207  1.  /* NUMERO DA FAMILIA              */
				@020     V2208  2.  /* MES DE NASCIMENTO              */
				@022     V2209  3.  /* ANO DE NASCIMENTO              */
				@269     V2805  3.  /* IDADE CALCULADA                */
				@272     V2983  6.  /* PESO PESSOA CONSERVADOR        */
           		@278     V2995  6.  /* NOVO PESO DO CHEFE             */
            	@284     V2996  6.  /* NOVO PESO DA FAMILIA           */
            	@290     V2997  6.  /* NOVO PESO DA PESSOA            */;   


/*******************************************/            

If V2805 ne 999;                        /* Só obs. com idade  */ 
If V2805 < 15 then FE = 1;				   /* Crianças     */
	else if V2805 < 65 then FE = 2;         /* Idade Ativa  */
	else if V2805 >= 65 then FE = 3;	       /* Velhos       */
Keep FE V2983 V2997;
proc contents data=work.RD_78;
proc freq data=work.RD_78;
	weight V2997;
	tables FE / nocum out=work.RD_78;
run;


/******************  1988 ********************/
data work.RD_88;

	INFILE 'C:\Data\PNAD\1988\Dados\PND1988N.DAT' LRECL=401  MISSOVER;

	INPUT @26 TIPO 1. @;
	IF TIPO = 3;
    INPUT
            @010     V0010  2.  /* CODIGO DA UNIDADE DA FEDERACAO */
			@014     V9991  4.  /* PESO PESSOA                    */
			@022     V9971  4.  /* PESO PESSOA NOVO CENSO 91      */
			@027     V0303  1.  /* SEXO                           */
	        @028     V0304  1. /* COR OU RACA                    */
	        @029     V0305  1. /* CONDICAO NA UNIDADE DOMICILIAR */
	        @030     V0306  1. /* CONDICAO NA FAMILIA            */
	        @031     V0307  1. /* NUMERO DA FAMILIA              */
	        @032     V0308  2. /* DIA DE NASCIMENTO              */
	        @034     V0309  2. /* MES DE NASCIMENTO              */
	        @036     V0310  3. /* ANO DE NASCIMENTO              */
	        @039     V0805  3. /* IDADE DO MORADOR               */;

If V0805 ne 999;                        /* Só obs. com idade  */ 
If V0805 < 15 then FE=1;				/* Crianças     */
	else if V0805 < 65 then FE=2;       /* Idade Ativa  */
	else if V0805 >= 65 then FE=3;	    /* Velhos       */
Keep FE V9991 V9971;
proc contents data=work.RD_88;
proc freq data=work.RD_88;
	weight V9971;
	tables FE / nocum out=work.RD_88;
run;







/******************  1998 ********************/
data work.RD_98;
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
	 @741        V4729    5.   /* PESO PESSOA                    */;

If V8005 ne 999;                           /* Só obs. com idade  */ 
If V8005 < 15 then FE=1;				   /* Crianças     */
	else if V8005 < 65 then FE=2;          /* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       /* Velhos       */
Keep FE V4729;
proc contents data=work.RD_98;
proc freq data=work.RD_98;
	weight V4729;
	tables FE / nocum out=work.RD_98;
run;
	

/******************  2003 ********************/
data work.RD_03;
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
			@00726  V1344    1.  /* TEM OUTRO PLANO APENAS ODONTOLÓGICO  */
			@00887  V4729    5.  /* PESO DA PESSOA                 */;

If V8005 ne 999;                           /* Só obs. com idade  */ 
If V8005 < 15 then FE=1;				   /* Crianças     */
	else if V8005 < 65 then FE=2;          /* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       /* Velhos       */
Keep FE V4729;
proc contents data=work.RD_03;
proc freq data=work.RD_03;
	weight V4729;
	tables FE / nocum out=work.RD_03;
run;



/******************  2008 ********************/
data work.RD_08;
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
		   @00742  V4729   5. /* PESO DA PESSOA                                                        */;

If V8005 ne 999;                           /* Só obs. com idade  */

/* Exclui Zona rural da região norte */
If UF in (11,12,13,14,15,16,17) and v4728 >= 4 then delete; 


If V8005 < 15 then FE=1;				   /* Crianças     */
	else if V8005 < 65 then FE=2;          /* Idade Ativa  */
	else if V8005 >= 65 then FE=3;	       /* Velhos       */
Keep FE V4729;
proc contents data=work.RD_08;
proc freq data=work.RD_08;
	weight V4729;
	tables FE / nocum out=work.RD_08;
run;



/******** Juntando os anos em 1 data set **********************/
data work.RD_78T;
	set RD_78;
	Ano=1978;
run;
data work.RD_88T;
	set RD_88;
	Ano=1988;
run;
data work.RD_98T;
	set RD_98;
	Ano=1998;
run;
data work.RD_03T;
	set RD_03;
	Ano=2003;
run;
data work.RD_08T;
	set RD_08;
	Ano=2008;
run;
data csc.RD_IE;
	set work.RD_78T work.RD_88T work.RD_98T work.RD_03T work.RD_08T;
proc export data = csc.RD_IE
		outfile = 'C:\...\Artigo Ciência e Saúde Coletiva\SAS\RD_IE.xls'
		dbms = excel2000 replace;
run;

