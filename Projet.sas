/* Projet SAS 2020-2021 / Magist�re 2 

AHOUNOU M�ryl & BENDAO Chalom & KEVORKIAN Amandine 

PARTIE 1 : SAS SQL */

/* 1- Dans une librairie nomm�e � projet �, cr�ez les tables 
suivantes en vous servant des fichiers du projet. Utilisez � l��tape DATA �
combin�e avec les instructions INFILE et INPUT. */
libname Projet "C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es";/*cr�ation de la librairie projet*/
options yearcutoff=1900;/*remplacement de l'ann�e de r�f�rence de SAS 1960 par 1900*/

/* � ACCOUNT � */
data Projet.ACCOUNT;/*cr�ation de la table account dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\account.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input account_id: 10. district_id frequency: $50. date: yymmdd10.;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;/*on affiche la date au format yymmdd10.*/
run;

/* � CARD � */
data PROJET.CARD;/*cr�ation de la table card dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\card.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input card_id disp_id type:$10. issued: $15.; /*on indique les diff�rentes colonnes de notre table et leurs formats*/
	issued_corr= input(substr(issued,1,6),yymmdd10.);/*on cr�e la colonne issued_corr en r�cup�rant les 6 premiers charat�res de issued qu'on met au format yymmdd10*/
	format issued_corr yymmdd10.;
run;

/* � CLIENT � */
data Projet.CLIENT;/*cr�ation de la table client dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\client.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input client_id birth_number:$8. district_id; /*on indique les diff�rentes colonnes de notre table et leurs formats*/
	t = substr(birth_number,3,2);/*on cr�e une variable t qui r�cup�re les valeurs du mois dans birth_number*/
	attrib sex format=$1.;/*on cr�e la variable sex alphanum�rique avec taille 1*/
	attrib birth format=$8.;/*on cr�e la variable birth avec taille 8 et alphanum�rique*/

	if t < 13 then/*on v�rifie si la valeur du mois est inf�rieur � 13*/
		do;/*si oui, on affecte � la variable sex la valeur M et la variable birth la valeur de birth_number*/
			sex = 'M';
			birth =birth_number;
		end;
		else do;/*si non, on affecte � la variable sex la valeur F et la variable birth la valeur de birth_number-5000 afin de retirer les 50 ajouter aux mois pour les femmes*/
			sex = 'F';
			birth =birth_number-5000;
		end;

	birth_corr =input(birth,yymmdd10.);/*on cr�e la colonne birth_corr � partir de birth au format yymmdd10*/
	format birth_corr yymmdd10.;
	drop t birth;/*on supprime les variables t et birth dont on n'a plus besoin*/
run;

/* � DISP � */
data Projet.DISP;/*cr�ation de la table disp dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\disp.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input disp_id client_id account_id type:$9.;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
run;

/* � DISTRICT � */
data Projet.DISTRICT;/*cr�ation de la table district dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\district.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input district_id district_name:$30. region:$30. A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
run;

/* � LOAN � */
data Projet.LOAN;/*cr�ation de la table loan dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\loan.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input loan_id account_id date: yymmdd10. amount duration payments status:$1.;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;
run;

/* � ORDER � */
data Projet.ORDER;/*cr�ation de la table order dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\order.txt'  dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input order_id account_id bank_to:$upcase2. account_to:$8. amount:numx5.2 k_symbol:$upcase10.;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
run;

/* � TRANS � */
data Projet.TRANS;/*cr�ation de la table trans dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de donn�es\trans.txt'  dsd delimiter=';' firstobs=2;/*on indique le fichier � partir duquel on souhaite cr�er la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour sp�cifier le charact�re qui s�pare les diff�rentes colonnes et l'option firsobs qui permet d'indiquer la 
	premi�re observation de notre table*/
	input trans_id account_id date:yymmdd10. type:$upcase10. operation:$upcase10. amount balance k_symbol:$upcase10. bank:$upcase2. account:$8.;/*on indique les diff�rentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;
run;

/* 3- Ecrivez le programme SAS qui permet d�obtenir le nombre de client par district et sexe. Ordonnez par 
l�identifiant du district. */
proc sql;
	select district_id as di label = "Identifiant du district", sex as s label="Sexe du client", 
		count(client_id) as nb label="Nombre de client"
	from PROJET.CLIENT
	group by district_id , sex
	order by district_id
	;
quit;

/* 4- R��crivez le programme pr�c�dent en y rajoutant le nom et la r�gion du district, exactement comme ci-dessous. */
proc sql;
	select distinct c.district_id as di label = "Identifiant du district", d.district_name as dn label="Nom du district",
		d.region as Region , c.sex as s label="Sexe du client", count(c.client_id) as nc label="Nombre de client"
	from PROJET.CLIENT as c, PROJET.DISTRICT as d
	where d.district_id=c.district_id
	group by c.district_id, c.sex
	order by c.district_id
	;
quit;

/* 5- Ecrivez le programme SAS qui affiche les districts qui ont un nombre total de clients sup�rieur � 100, en 
pr�cisant les caract�ristiques du district, le nombre de femmes et le nombre d�hommes. */
proc sql;
	select distinct c.district_id as di label = "Identifiant du district", d.district_name as dn label="Nom du district",
		d.region as Region, count(c.client_id) as ntc label="Nombre total de clients", 
		count(case when c.sex="M" then 1 end)as nh label='Nombre de clients Hommes',
		count(case when c.sex="F" then 1 end)as nf label='Nombre de clients Femmes'
	from PROJET.CLIENT as c, PROJET.DISTRICT as d
	where d.district_id=c.district_id
	group by c.district_id
	having ntc>100
	order by c.district_id
	;
quit;

/*6- Ecrivez le programme SAS qui affiche le nombre d�ordres pour les clients qui poss�dent au moins un compte. 
Affichez par ordre croissant d��ge des clients au 01-01-2010. */
proc sql;
	select  ceil(yrdif(c.birth_corr,mdy(01,01,2010),'AGE')) as age label="Age des clients", 
		count(distinct c.client_id) as nc label="Nombre de clients",
		count(o.order_id) as not label="Nombre d'ordres"
	from PROJET.ORDER as o ,PROJET.CLIENT as c,PROJET.DISP as d,PROJET.ACCOUNT as a
	where d.account_id=o.account_id 
		and a.account_id=d.account_id
		and c.client_id=d.client_id
	group by age
	order by age asc
	;
quit;


/*7- Par type de carte de cr�dit, affichez le nombre de compte ayant b�n�fici� d�un pr�t, le montant et dur�e 
minimum, moyen et maximum du pr�t; ainsi que le nombre de d�emprunt par statut.*/
proc sql;
	select c.type as type,count(l.account_id) as nce label="Nombre de compte avec un emprunt",min(l.amount) as mmie 
		label="Montant minimum des emprunts" format=dollar10., 
		mean(l.amount) as mmee label="Montant moyen des emprunts" format=dollar10.,
		max(l.amount) as mmae label="Montant maximum des emprunts" format=dollar10.,min(l.duration) as mmid 
		label="Dur�e minimum des emprunts", mean(l.duration) as mmed label="Dur�e moyen des emprunts" format=4.,
		max(l.duration) as mmad label="Dur�e maximum des emprunts",
		count(case when l.status="A" then 1 end) as na label="Nombre d'emprunt cat�gorie A",
		count(case when l.status="B" then 1 end) as na label="Nombre d'emprunt cat�gorie B",
		count(case when l.status="C" then 1 end) as na label="Nombre d'emprunt cat�gorie C",
		count(case when l.status="D" then 1 end) as na label="Nombre d'emprunt cat�gorie D"
	from PROJET.LOAN as l,PROJET.CARD as c,PROJET.ACCOUNT as a,PROJET.DISP as d
	where l.account_id=a.account_id
		and d.account_id=a.account_id
		and d.disp_id=c.disp_id
	group by c.type
	order by c.type
	;
quit;

/*8- Par type de carte de cr�dit et par cat�gorie d�emprunt, affichez le nombre de compte ayant b�n�fici� d�un pr�t, 
ainsi que les statistiques quantitatives sur le montant et la dur�e du pr�t. */
proc sql;
	select l.status as status,c.type as type,count(l.account_id) as nce label="Nombre de compte avec un emprunt",
		mean(l.amount) as mmee label="Montant moyen des emprunts" format=dollar10., 
		min(l.amount) as mmie label="Montant minimum des emprunts" format=dollar10.,
		max(l.amount) as mmae label="Montant maximum des emprunts" format=dollar10.,
		var(l.amount) as mmae label="Variance des montants",
		std(l.amount) as mmae label="Ecart moyen des montants",
		mean(l.duration) as mmed label="Dur�e moyen des emprunts" format=4.,
		min(l.duration) as mmid label="Dur�e minimum des emprunts", 
		max(l.duration) as mmad label="Dur�e maximum des emprunts",
		var(l.duration) as mmae label="Variance des dur�es",
		std(l.duration) as mmae label="Ecart moyen des dur�es"
	from PROJET.LOAN as l,PROJET.CARD as c,PROJET.ACCOUNT as a,PROJET.DISP as d
	where l.account_id=a.account_id
		and d.account_id=a.account_id
		and d.disp_id=c.disp_id
	group by l.status,c.type
	order by l.status,c.type
	;
quit;

/*9- Cr�ez une table nomm�e � client_macro � qui regroupe les diff�rentes informations des tables � client �, 
� disp � et � card � en y rajoutant une colonne qui calcule l��ge du client au 01 Janvier 2010. On souhaite 
conserver toutes les lignes de la table des clients. Attention aux doublons de nom de colonne, les supprimer 
ou les renommer si besoin. */
proc sql;
	create table PROJET.client_macro as
		select c.client_id, c.birth_number, c.district_id, c.birth_corr,d.disp_id, d.account_id, d.type as typedisp, 
			ca.card_id, ca.disp_id, ca.type as typecard, ca.issued, ca.issued_corr,
			ceil(yrdif(c.birth_corr,mdy(01,01,2010),'AGE')) as age_client
		from PROJET.CLIENT as c
			left join PROJET.DISP as d on c.client_id=d.client_id
			left join PROJET.CARD as ca on d.disp_id=ca.disp_id
	;
quit;





/*Partie 2 : SAS Macro

A-/ Sondage al�atoire simple (AS)

1- Programme ASV1
Cr�ez un programme SAS sans macro langage qui : cr�e une variable al�atoire (utiliser la fonction ranuni(0) de SAS), 
triez par cette variable et cr�e un �chantillon avec les 200 premi�res observations.*/
options symbolgen;/*activation de l'option symbolgen pour v�rifier avoir plus d'indications sur la r�solution des macros*/

data PROJET.AVS1;/*cr�ation de la table AVS1*/
	set PROJET.client_macro;/*a partir de la table client_macro dans la librairie projet*/
	x = ranuni(0);/*cr�ation de la colonne x qui affecte � chaque individu d'une valeur al�atoire entre 0 et 1 */
run;

proc sort data=PROJET.AVS1;/*trie de la table AVS1 en fonction de la variable al�atoire x */
	by x ;
run;

data PROJET.AVS1;/*cr&ation de la table AVS1 � partir de l'ancienne table AVS1 en r�cup�rant 200 observations � partir de la premi�re observation*/
	set PROJET.AVS1 (firstobs=1 obs=200);
run;

proc print data=PROJET.AVS1;/*affichage de la table AVS1*/
run;

/*2- Programme ASV2
Reprenez le programme AVS1, toujours sans cr�er de macro programme, ajouter en param�tre (utilisez � %let �) le 
nom de la table en entr�e et le nom de la table en sortie, la taille de l��chantillon en nombres d�observations.*/
%let tableint=PROJET.client_macro;/*cr�ation de la macro variable tableint qui prend en valeur la table d'entr�e qui est ici la table client_macro*/
%let tableout=PROJET.AVS2;/*cr�ation de la macro variable tableout qui prend en valeur la table de sortie qui est ici AVS2*/
%let nobs=200;/*cr�ation de la macro variable nobs qui prend en valeur la taille d'�chantillon qui est ici 200*/

data &tableout.;
	set &tableint.;
	x = ranuni(0);
run;

proc sort data=&tableout.;
	by x ;
run;

data &tableout.;
	set &tableout. (firstobs=1 obs=&nobs.);
run;

proc print data=&tableout.;
run;

/*3- Programme ASV3
Reprenez le programme ASV2 en rempla�ant le param�tre nombre d�observation par le pourcentage d�observation. 
Ainsi la valeur 20 de ce param�tre permettra d�obtenir un �chantillon avec 20% des observations de la table d�entr�e.*/
proc sql noprint;/*avec la proc sql on r�cup�re la taille de la table client_macro dans la macro variable numberobs*/
	select count(*) as c
	into : numberobs
	from PROJET.client_macro
	;
quit;
%let tableint=PROJET.client_macro;
%let tableout=PROJET.AVS3;
%let pobs=20;/*cr�ation de la macro variable pobs qui prend en valeur le pourcentage d'observation*/

data &tableout.;
	set &tableint.;
	x = ranuni(0);
run;

proc sort data=&tableout.;
	by x ;
run;

data &tableout.;
	call symput('nobs',%eval(&pobs. * &numberobs. /100));/*cr�ation de la macro variable nobs qui permet d'avoir la taille de l'�chantillon � partir du pourcentage d'observation et du nombre d'observations de la table*/
	set &tableout. (firstobs=1 obs=&nobs.);
run;

proc print data=&tableout.;
run;

/*4- Programme ASV4
Transformez le programme ASV3 en un macro-programme appel� � %AS �, avec les trois param�tres : table en entr�e, 
table en sortie et taux d��chantillonnage.*/
%macro AS (tableint=, tableout=, pobs=);/*cr�ation de la macro avec en param�tre la table en entr�e tableint, la table en sortie tableout et le pourcentage d'observation pobs*/
	proc sql noprint;
		select count(*) as c
		into : numberobs
		from &tableint.
		;
	quit;

	data &tableout.;
		set &tableint.;
		x = ranuni(0);
	run;

	proc sort data=&tableout.;
		by x ;
	run;

	data &tableout.;
		call symput('nobs',%eval(&pobs. * &numberobs. /100));
		set &tableout. (firstobs=1 obs=&nobs.);
	run;

	proc print data=&tableout.;
	run;
%mend;

%AS(tableint=PROJET.client_macro, tableout=PROJET.AVS3, pobs=20);/*on test la macro avec la table client_macro , en sortie la table projet AVS3 et 20 d'observation*/


/*B-/ Sondage al�atoire stratifi� (ASTR)
1- Programme ASTRV01
Cr�ez un macro programme � %ASTR � qui permet de collecter dans des macro variables le nombre de valeurs prises 
et les valeurs correspondantes � la variable de stratification choisie. Attention � ne pas prendre en compte les 
valeurs manquantes*/

%macro ASTR(tableint=, var_strat=);/*cr�ation de la macro ASTR avec en param�tre la table en entr�e tableint et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on r�cup�re les diff�rentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
    	select distinct &var_strat., count(distinct &var_strat. )
		into :type1- , :nv
		from &tableint.
		where &var_strat. <>""/*on �limine les valeurs manquantes de la table en entr�e*/ 
		;
	quit;
	%put Le nombre de valeur prise est &nv ;/*affichage du nombre de valeur total prise par la variable de stratification*/

	%do i=1 %to &nv.;
		%put Le type de carte &i est &&type&i;/*affichage des diff�rents modalit�s prises par la variable de stratification*/
	%end;

%mend;

%ASTR(tableint=PROJET.client_macro, var_strat=typecard);/*on teste la macro avec la table client_macro et la variable typecard comme variable de stratification*/

/*2- Programme ASTRV02
Reprenez macro programme � %ASTR � et y ajoutez une partie qui �clate la table en entr�e en strates. Il 
cr�era donc une table par strate.*/

%macro ASTR2(tableint=, var_strat=);/*cr�ation de la macro ASTR2 avec en param�tre la table en entr�e tableint et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on r�cup�re les diff�rentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
    	select distinct &var_strat., count(distinct &var_strat.)
		into :type1- , :nv
		from &tableint.
		where &var_strat. <>"" 
		;
	quit;
	%put Le nombre de valeur prise est &nv ;

	%do i=1 %to &nv.;/*on cr�e des strates pour chaque valeur prise par la variable de stratification*/
		%put Le type de carte &i est &&type&i;
		proc sql noprint;
			create table PROJET.strate&i. as
	    	select * 
			from &tableint.
			where &var_strat. ="&&type&i" 
			;
		quit;
	%end;

%mend;

%ASTR2(tableint=PROJET.client_macro, var_strat=typecard);

/*3- Programme ASTRV03
Reprenez le programme ASTRV02 et ajoutez une partie qui cr�e les sous �chantillons (un �chantillon pour chaque strate).
Utiliser la fonction ranuni(0) de SAS en vous inspirant du A-/ */
%macro ASTR3(tableint=, tableout=, pobs=20, var_strat=);/*cr�ation de la macro ASTR3 avec en param�tre la table en entr�e tableint, la table en sortie tableout , le pourcentage d'observation qui par d�faut est �gal � 20 et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on r�cup�re les diff�rentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
    	select distinct &var_strat., count(distinct &var_strat. )
		into :type1- , :nv 
		from &tableint.
		where &var_strat. <>"" 
		;
	quit;
	%put Le nombre de valeur prise est &nv ;

	%do i=1 %to &nv.;
		%put Le type de carte &i est &&type&i;
		proc sql noprint;
			create table PROJET.strate&i. as
	    	select * 
			from &tableint.
			where &var_strat. ="&&type&i" 
			;
		quit;
	
		data &tableout.&i.;
			set PROJET.strate&i.;
			x = ranuni(0);
		run;

		proc sort data=&tableout.&i.;
			by x ;
		run;

		data _NULL_ ;
			set PROJET.strate&i ;
			call symput('nbb',_N_) ;
		run;

		data _NULL_ ;
			set PROJET.strate&i ;
			call symput('nbs',%eval(&pobs. * &nbb. /100));
		run;

		data &tableout.&i.;
			set &tableout.&i. (firstobs=1 obs=&nbs.);
		run;

		proc print data=&tableout.&i.;
		run;
	%end;

%mend;

%ASTR3(tableint=PROJET.client_macro,tableout=PROJET.ech, var_strat=typecard);


/*4- Programme ASTRV04
Reprenez le programme ASTRV03 et ajoutez une partie qui recolle les sous �chantillons en une seule table SAS.*/
%macro ASTR4(tableint=, tableout=, pobs=20, var_strat=);/*cr�ation de la macro ASTR4 avec en param�tre la table en entr�e tableint, la table en sortie tableout , le pourcentage d'observation qui par d�faut est �gal � 20 et la variable de stratification var_strat*/
	proc sql noprint;
    	select distinct &var_strat., count(distinct &var_strat. )
		into :type1- , :nv
		from &tableint.
		where &var_strat. <>"" 
		;
	quit;
	%put Le nombre de valeur prise est &&nv ;

	%do i=1 %to &nv.;
		%put Le type de carte &i est &&type&i;
		proc sql noprint;
			create table PROJET.strate&i. as
	    	select *
			from &tableint.
			where &var_strat. ="&&type&i" 
			;
		quit;
	
		data &tableout.&i.;
			set PROJET.strate&i.;
			x = ranuni(0);
		run;

		proc sort data=&tableout.&i.;
			by x ;
		run;

		data _NULL_ ;
			set PROJET.strate&i. ;
			call symput('nbb',_N_ ) ;
		run;

		data _NULL_ ;
			set PROJET.strate&i. ;
			call symput('nbs',%eval(&pobs. * &nbb. /100));
		run;

		data &tableout.&i.;
			set &tableout.&i. (firstobs=1 obs=&nbs.);
		run;

	%end;
	
	data &tableout.;/*on cr�e une nouvelle table de sortie � partir de la premi�re table echantillon��*/
			set &tableout.1;
		run;
	
	%do i=2 %to &nv.;
		proc sql noprint;/*on ajoute � la table en sortie les autres tables �chantillon�es*/
			insert into &tableout.
			select *
			from &tableout.&i.
			;
		quit;
	%end;
		proc print data=&tableout.;
		run;

%mend;

%ASTR4(tableint=PROJET.client_macro,tableout=PROJET.ech, var_strat=typecard);

/*5- Programme ASTRV05
Reprenez le programme ASTRV04 et ajoutez en param�tre le type de variable de stratification, c�est-�-dire une 
param�tre qui pr�cise si la variable de stratification est une caract�re ou num�rique. Modifiez le macro programme 
en cons�quence.*/
%macro ASTR5(tableint=, tableout=, pobs=20, type_var= , var_strat=, nbstrat=4);/*cr�ation de la macro ASTR5 avec en param�tre la table en entr�e tableint, la table en sortie tableout , le pourcentage d'observation qui par d�faut est �gal � 20, le type de variable d'observation ,la variable de stratification var_strat et le nombre de strate d�sir�e qui par d�faut est �gal � 4 ce qui correspond � regrouper en quartiles*/
	data _NULL_ ;/*on cr�e une macro variable qui r�cup�re le type de la variable de stratification*/
		set &tableint.;
		call symput('type',vtype(&var_strat.));
	run;
	%if %upcase(&type_var.)=&type. %then /*on compare le type de valeur entr�e au type r�el de la variable, lorsque les deux correspondent on proc�de � l'�chantillonnage suivant la nature charact�re ou num�rique de la variable de stratification*/
	%do;
		%if &type.=C %then/*�chantillonnage avec une variable charact�re*/
		%do;
			proc sql noprint;
				select distinct &var_strat., count(distinct &var_strat. )
				into :type1- , :nv
				from &tableint.
				where &var_strat. <>"" 
				;
			quit; 
			%put Le nombre de valeur prise est &nv ;
			%do i=1 %to &nv.;
				%put Le type de carte &i est &&type&i;
				proc sql noprint;
					create table PROJET.strate&i. as
					select *
					from &tableint.
					where &var_strat. ="&&type&i" 
					;
				quit;
				data _NULL_ ;
					set PROJET.strate&i. ;
					call symput('nbb',_N_ ) ;
				run;
				data _NULL_ ;
					set PROJET.strate&i. ;
					call symput('nbs',%eval((&pobs. * &nbb.) / 100));
				run;
				data &tableout.&i.;
					set PROJET.strate&i.;
					x = ranuni(0);
				run;
				proc sort data=&tableout.&i.;
					by x ;
				run;
				data &tableout.&i.;
					set &tableout.&i. (firstobs=1 obs=&nbs.);
				run;
			%end;
			data &tableout.;
				set &tableout.1;
			run;
			%do i=2 %to &nv.;
				proc sql noprint;
					insert into &tableout.
					select *
					from &tableout.&i.
					;
				quit;
			%end;
			proc print data=&tableout.;
			run;
		%end;
		%else %if &type.=N %then /*�chantillonnage avec une variable num�rique*/
		%do;
			proc sort data=&tableint.;/*on trie la table en entr�e suivant la variable de stratification*/
				by &var_strat. ;
			run;
			proc sql noprint;/*on �limine les valeurs manquantes de la table en entr�e*/
				create table &tableint. as 
				select *
				from &tableint.
				where &var_strat. <>"" 
				;
			quit; 
			data _NULL_;/*on r�cup�re dans la macro nb la taille de la table entr�e*/
				set &tableint.;
				call symput('nb',_N_ );
				;
			run;
			data _NULL_;/*on r�cup�re dans la macro n la taille que dois avoir chaque strate*/
				set &tableint.;
				call symput('n',&nb./&nbstrat.);
			run;
			%let n1=%eval(&nbstrat.-1);
			data PROJET.strate1;/*on cr�e la premi�re strate en prenant les n premiers observations*/
				set &tableint.;
				if 1 <= _N_ < &n.;
			run;
			
			%do i=2 %to &n1.;/*on cr�e une boucle ou on cr�e du deuxi�me � l'avant dernier strates en regroupant les n observations suivantes*/
				%let j=%eval(&i.-1);
				data PROJET.strate&i.;/*on cr�e la derni�re strate en prenant les n derniers observations*/
					set &tableint.;
					if &n.*&j. <= _N_ < &n.*&i.;
				run;
			%end;
			data PROJET.strate&nbstrat.;
				set &tableint.;
				if &n.*&n1. < _N_ <= &n.*&nbstrat.;
			run;
			%do i=1 %to &nbstrat.;
				data _NULL_ ;
					set PROJET.strate&i ;
					call symput('nbbn',_N_) ;
				run;
				data _NULL_ ;
					set PROJET.strate&i ;
					call symput('nbsn',%eval(&pobs. * &nbbn. /100));
				run;
				data &tableout.&i.;
					set PROJET.strate&i.;
					x = ranuni(0);
				run;
				proc sort data=&tableout.&i.;
					by x ;
				run;
				data &tableout.&i.;
					set &tableout.&i. (firstobs=1 obs=&nbsn.);
				run;
			%end;
			data &tableout.;
				set &tableout.1;
			run;
			%do i=2 %to &nbstrat.;
				proc sql noprint;
					insert into &tableout.
					select *
					from &tableout.&i.
					;
				quit;
			%end; 
			proc print data=&tableout.;
			run;
		%end;
	%end;
	%else %do;
		%put le type de variable nest pas juste. veuillez entrer "c" pour une 
		variable caractere et "n" pour une variable num�rique;
	%end;
%mend;

%ASTR5(tableint=PROJET.client_macro,tableout=PROJET.ech,var_strat=typecard, type_var=c);


/*6- Programme ASTRV06
Reprenez le programme ASTRV05 en informant l�utilisateur dans le journal des tailles des diff�rents �chantillons 
et de la taille de l��chantillon final.*/
%macro ASTR6(tableint=, tableout=, pobs=20, type_var= , var_strat=, nbstrat=4);/*cr�ation de la macro ASTR5 avec en param�tre la table en entr�e tableint, la table en sortie tableout , le pourcentage d'observation qui par d�faut est �gal � 20, le type de variable d'observation ,la variable de stratification var_strat et le nombre de strate d�sir�e qui par d�faut est �gal � 4 ce qui correspond � regrouper en quartiles*/
	data _NULL_ ;
		set &tableint.;
		call symput('type',vtype(&var_strat.));
	run;
	%if %upcase(&type_var.)=&type. %then
	%do;
		%if &type.=C %then
		%do;
			proc sql noprint;
				select distinct &var_strat., count(distinct &var_strat. )
				into :type1- , :nv
				from &tableint.
				where &var_strat. <>"" 
				;
			quit; 
			%put Le nombre de valeur prise est &nv ;
			%do i=1 %to &nv.;
				%put Le type de carte &i est &&type&i;
				proc sql noprint;
					create table PROJET.strate&i. as
					select *
					from &tableint.
					where &var_strat. ="&&type&i" 
					;
				quit;
				data _NULL_ ;
					set PROJET.strate&i. ;
					call symput('nbb',_N_ ) ;
				run;
				data _NULL_ ;
					set PROJET.strate&i. ;
					call symput('nbs',%eval((&pobs. * &nbb.) / 100));
				run;
				data &tableout.&i.;
					set PROJET.strate&i.;
					x = ranuni(0);
				run;
				proc sort data=&tableout.&i.;
					by x ;
				run;
				data &tableout.&i.;
					set &tableout.&i. (firstobs=1 obs=&nbs.);
				run;
			%end;
			data &tableout.;
				set &tableout.1;
			run;
			%do i=2 %to &nv.;
				proc sql noprint;
					insert into &tableout.
					select *
					from &tableout.&i.
					;
				quit;
			%end;
			proc print data=&tableout.;
			run;
			data _NULL_ ;/*on r�cup�re dans la macro ttotal la taille de l'�chantillon final*/
				set &tableout. ;
				call symput('ttotal',_N_);
			run;
			%do i=1 %to &nv.;/*on affiche sucessivement la taille de chaque �chantillon r�cup�r� dans la macro variable te*/
				proc sql noprint;
					select count(*)
					into :te
					from &tableout.&i.
					;
				quit;
				%put la taille de &tableout.&i. est &te.;
		%end;
		%put la taille de &tableout. est &ttotal.;
		%end;
		%else %if &type.=N %then 
		%do;
			proc sort data=&tableint.;
				by &var_strat. ;
			run;
			proc sql noprint;
				create table &tableint. as 
				select *
				from &tableint.
				where &var_strat. <>"" 
				;
			quit; 
			data _NULL_;
				set &tableint.;
				call symput('nb',_N_ );
				;
			run;
			data _NULL_;
				set &tableint.;
				call symput('n',&nb./&nbstrat.);
			run;
			%let n1=%eval(&nbstrat.-1);
			data PROJET.strate1;
				set &tableint.;
				if 1 <= _N_ < &n.;
			run;
			
			%do i=2 %to &n1.;
				%let j=%eval(&i.-1);
				data PROJET.strate&i.;
					set &tableint.;
					if &n.*&j. <= _N_ < &n.*&i.;
				run;
			%end;
			data PROJET.strate&nbstrat.;
				set &tableint.;
				if &n.*&n1. < _N_ <= &n.*&nbstrat.;
			run;
			%do i=1 %to &nbstrat.;
				data _NULL_ ;
					set PROJET.strate&i ;
					call symput('nbbn',_N_) ;
				run;
				data _NULL_ ;
					set PROJET.strate&i ;
					call symput('nbsn',%eval(&pobs. * &nbbn. /100));
				run;
				data &tableout.&i.;
					set PROJET.strate&i.;
					x = ranuni(0);
				run;
				proc sort data=&tableout.&i.;
					by x ;
				run;
				data &tableout.&i.;
					set &tableout.&i. (firstobs=1 obs=&nbsn.);
				run;
			%end;
			data &tableout.;
				set &tableout.1;
			run;
			%do i=2 %to &nbstrat.;
				proc sql noprint;
					insert into &tableout.
					select *
					from &tableout.&i.
					;
				quit;
			%end; 
			proc print data=&tableout.;
			run;
			data _NULL_ ;/*on r�cup�re dans la macro ttotal la taille de l'�chantillon final*/
				set &tableout. ;
				call symput('ttotal',_N_);
			run;
			%do i=1 %to &nbstrat.;/*on affiche sucessivement la taille de chaque �chantillon r�cup�r� dans la macro variable te*/
				proc sql noprint;
					select count(*)
					into :te
					from &tableout.&i.
					;
				quit;
				%put la taille de &tableout.&i. est &te.;
			%end;
			%put la taille de &tableout. est &ttotal.;
		%end;
	%end;
	%else %do;
		%put le type de variable nest pas juste. veuillez entrer "c" pour une 
		variable caractere et "n" pour une variable num�rique;
	%end;
%mend;

%ASTR6(tableint=PROJET.client_macro ,tableout=projet.ech, var_strat=typecard, type_var=c);	


