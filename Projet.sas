/* Projet SAS 2020-2021 / Magistère 2 

PARTIE 1 : SAS SQL */

/* 1- Dans une librairie nommée « projet », créez les tables 
suivantes en vous servant des fichiers du projet. Utilisez « l’étape DATA »
combinée avec les instructions INFILE et INPUT. */
libname Projet "C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données";/*création de la librairie projet*/
options yearcutoff=1900;/*remplacement de l'année de référence de SAS 1960 par 1900*/

/* « ACCOUNT » */
data Projet.ACCOUNT;/*création de la table account dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\account.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input account_id: 10. district_id frequency: $50. date: yymmdd10.;/*on indique les différentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;/*on affiche la date au format yymmdd10.*/
run;

/* « CARD » */
data PROJET.CARD;/*création de la table card dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\card.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input card_id disp_id type:$10. issued: $15.; /*on indique les différentes colonnes de notre table et leurs formats*/
	issued_corr= input(substr(issued,1,6),yymmdd10.);/*on crée la colonne issued_corr en récupérant les 6 premiers charatères de issued qu'on met au format yymmdd10*/
	format issued_corr yymmdd10.;
run;

/* « CLIENT » */
data Projet.CLIENT;/*création de la table client dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\client.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input client_id birth_number:$8. district_id; /*on indique les différentes colonnes de notre table et leurs formats*/
	t = substr(birth_number,3,2);/*on crée une variable t qui récupère les valeurs du mois dans birth_number*/
	attrib sex format=$1.;/*on crée la variable sex alphanumérique avec taille 1*/
	attrib birth format=$8.;/*on crée la variable birth avec taille 8 et alphanumérique*/

	if t < 13 then/*on vérifie si la valeur du mois est inférieur à 13*/
		do;/*si oui, on affecte à la variable sex la valeur M et la variable birth la valeur de birth_number*/
			sex = 'M';
			birth =birth_number;
		end;
		else do;/*si non, on affecte à la variable sex la valeur F et la variable birth la valeur de birth_number-5000 afin de retirer les 50 ajouter aux mois pour les femmes*/
			sex = 'F';
			birth =birth_number-5000;
		end;

	birth_corr =input(birth,yymmdd10.);/*on crée la colonne birth_corr à partir de birth au format yymmdd10*/
	format birth_corr yymmdd10.;
	drop t birth;/*on supprime les variables t et birth dont on n'a plus besoin*/
run;

/* « DISP » */
data Projet.DISP;/*création de la table disp dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\disp.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input disp_id client_id account_id type:$9.;/*on indique les différentes colonnes de notre table et leurs formats*/
run;

/* « DISTRICT » */
data Projet.DISTRICT;/*création de la table district dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\district.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input district_id district_name:$30. region:$30. A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16;/*on indique les différentes colonnes de notre table et leurs formats*/
run;

/* « LOAN » */
data Projet.LOAN;/*création de la table loan dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\loan.txt' dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input loan_id account_id date: yymmdd10. amount duration payments status:$1.;/*on indique les différentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;
run;

/* « ORDER » */
data Projet.ORDER;/*création de la table order dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\order.txt'  dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input order_id account_id bank_to:$upcase2. account_to:$8. amount:numx5.2 k_symbol:$upcase10.;/*on indique les différentes colonnes de notre table et leurs formats*/
run;

/* « TRANS » */
data Projet.TRANS;/*création de la table trans dans la librairie projet*/
	infile 'C:\Users\ahoun\Documents\Cours\Semestre 2\SAS\Projet\Fichiers de données\trans.txt'  dsd delimiter=';' firstobs=2;/*on indique le fichier à partir duquel on souhaite créer la table, 
	avec l'option dsd qui permet de tenir compte des quotes, l'option delimiter pour spécifier le charactère qui sépare les différentes colonnes et l'option firsobs qui permet d'indiquer la 
	première observation de notre table*/
	input trans_id account_id date:yymmdd10. type:$upcase10. operation:$upcase10. amount balance k_symbol:$upcase10. bank:$upcase2. account:$8.;/*on indique les différentes colonnes de notre table et leurs formats*/
	format date yymmdd10.;
run;

/* 3- Ecrivez le programme SAS qui permet d’obtenir le nombre de client par district et sexe. Ordonnez par 
l’identifiant du district. */
proc sql;
	select district_id as di label = "Identifiant du district", sex as s label="Sexe du client", 
		count(client_id) as nb label="Nombre de client"
	from PROJET.CLIENT
	group by district_id , sex
	order by district_id
	;
quit;

/* 4- Réécrivez le programme précédent en y rajoutant le nom et la région du district, exactement comme ci-dessous. */
proc sql;
	select distinct c.district_id as di label = "Identifiant du district", d.district_name as dn label="Nom du district",
		d.region as Region , c.sex as s label="Sexe du client", count(c.client_id) as nc label="Nombre de client"
	from PROJET.CLIENT as c, PROJET.DISTRICT as d
	where d.district_id=c.district_id
	group by c.district_id, c.sex
	order by c.district_id
	;
quit;

/* 5- Ecrivez le programme SAS qui affiche les districts qui ont un nombre total de clients supérieur à 100, en 
précisant les caractéristiques du district, le nombre de femmes et le nombre d’hommes. */
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

/*6- Ecrivez le programme SAS qui affiche le nombre d’ordres pour les clients qui possèdent au moins un compte. 
Affichez par ordre croissant d’âge des clients au 01-01-2010. */
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


/*7- Par type de carte de crédit, affichez le nombre de compte ayant bénéficié d’un prêt, le montant et durée 
minimum, moyen et maximum du prêt; ainsi que le nombre de d’emprunt par statut.*/
proc sql;
	select c.type as type,count(l.account_id) as nce label="Nombre de compte avec un emprunt",min(l.amount) as mmie 
		label="Montant minimum des emprunts" format=dollar10., 
		mean(l.amount) as mmee label="Montant moyen des emprunts" format=dollar10.,
		max(l.amount) as mmae label="Montant maximum des emprunts" format=dollar10.,min(l.duration) as mmid 
		label="Durée minimum des emprunts", mean(l.duration) as mmed label="Durée moyen des emprunts" format=4.,
		max(l.duration) as mmad label="Durée maximum des emprunts",
		count(case when l.status="A" then 1 end) as na label="Nombre d'emprunt catégorie A",
		count(case when l.status="B" then 1 end) as na label="Nombre d'emprunt catégorie B",
		count(case when l.status="C" then 1 end) as na label="Nombre d'emprunt catégorie C",
		count(case when l.status="D" then 1 end) as na label="Nombre d'emprunt catégorie D"
	from PROJET.LOAN as l,PROJET.CARD as c,PROJET.ACCOUNT as a,PROJET.DISP as d
	where l.account_id=a.account_id
		and d.account_id=a.account_id
		and d.disp_id=c.disp_id
	group by c.type
	order by c.type
	;
quit;

/*8- Par type de carte de crédit et par catégorie d’emprunt, affichez le nombre de compte ayant bénéficié d’un prêt, 
ainsi que les statistiques quantitatives sur le montant et la durée du prêt. */
proc sql;
	select l.status as status,c.type as type,count(l.account_id) as nce label="Nombre de compte avec un emprunt",
		mean(l.amount) as mmee label="Montant moyen des emprunts" format=dollar10., 
		min(l.amount) as mmie label="Montant minimum des emprunts" format=dollar10.,
		max(l.amount) as mmae label="Montant maximum des emprunts" format=dollar10.,
		var(l.amount) as mmae label="Variance des montants",
		std(l.amount) as mmae label="Ecart moyen des montants",
		mean(l.duration) as mmed label="Durée moyen des emprunts" format=4.,
		min(l.duration) as mmid label="Durée minimum des emprunts", 
		max(l.duration) as mmad label="Durée maximum des emprunts",
		var(l.duration) as mmae label="Variance des durées",
		std(l.duration) as mmae label="Ecart moyen des durées"
	from PROJET.LOAN as l,PROJET.CARD as c,PROJET.ACCOUNT as a,PROJET.DISP as d
	where l.account_id=a.account_id
		and d.account_id=a.account_id
		and d.disp_id=c.disp_id
	group by l.status,c.type
	order by l.status,c.type
	;
quit;

/*9- Créez une table nommée « client_macro » qui regroupe les différentes informations des tables « client », 
« disp » et « card » en y rajoutant une colonne qui calcule l’âge du client au 01 Janvier 2010. On souhaite 
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

A-/ Sondage aléatoire simple (AS)

1- Programme ASV1
Créez un programme SAS sans macro langage qui : crée une variable aléatoire (utiliser la fonction ranuni(0) de SAS), 
triez par cette variable et crée un échantillon avec les 200 premières observations.*/
options symbolgen;/*activation de l'option symbolgen pour vérifier avoir plus d'indications sur la résolution des macros*/

data PROJET.AVS1;/*création de la table AVS1*/
	set PROJET.client_macro;/*a partir de la table client_macro dans la librairie projet*/
	x = ranuni(0);/*création de la colonne x qui affecte à chaque individu d'une valeur aléatoire entre 0 et 1 */
run;

proc sort data=PROJET.AVS1;/*trie de la table AVS1 en fonction de la variable aléatoire x */
	by x ;
run;

data PROJET.AVS1;/*cr&ation de la table AVS1 à partir de l'ancienne table AVS1 en récupérant 200 observations à partir de la première observation*/
	set PROJET.AVS1 (firstobs=1 obs=200);
run;

proc print data=PROJET.AVS1;/*affichage de la table AVS1*/
run;

/*2- Programme ASV2
Reprenez le programme AVS1, toujours sans créer de macro programme, ajouter en paramètre (utilisez « %let ») le 
nom de la table en entrée et le nom de la table en sortie, la taille de l’échantillon en nombres d’observations.*/
%let tableint=PROJET.client_macro;/*création de la macro variable tableint qui prend en valeur la table d'entrée qui est ici la table client_macro*/
%let tableout=PROJET.AVS2;/*création de la macro variable tableout qui prend en valeur la table de sortie qui est ici AVS2*/
%let nobs=200;/*création de la macro variable nobs qui prend en valeur la taille d'échantillon qui est ici 200*/

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
Reprenez le programme ASV2 en remplaçant le paramètre nombre d’observation par le pourcentage d’observation. 
Ainsi la valeur 20 de ce paramètre permettra d’obtenir un échantillon avec 20% des observations de la table d’entrée.*/
proc sql noprint;/*avec la proc sql on récupère la taille de la table client_macro dans la macro variable numberobs*/
	select count(*) as c
	into : numberobs
	from PROJET.client_macro
	;
quit;
%let tableint=PROJET.client_macro;
%let tableout=PROJET.AVS3;
%let pobs=20;/*création de la macro variable pobs qui prend en valeur le pourcentage d'observation*/

data &tableout.;
	set &tableint.;
	x = ranuni(0);
run;

proc sort data=&tableout.;
	by x ;
run;

data &tableout.;
	call symput('nobs',%eval(&pobs. * &numberobs. /100));/*création de la macro variable nobs qui permet d'avoir la taille de l'échantillon à partir du pourcentage d'observation et du nombre d'observations de la table*/
	set &tableout. (firstobs=1 obs=&nobs.);
run;

proc print data=&tableout.;
run;

/*4- Programme ASV4
Transformez le programme ASV3 en un macro-programme appelé « %AS », avec les trois paramètres : table en entrée, 
table en sortie et taux d’échantillonnage.*/
%macro AS (tableint=, tableout=, pobs=);/*création de la macro avec en paramètre la table en entrée tableint, la table en sortie tableout et le pourcentage d'observation pobs*/
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


/*B-/ Sondage aléatoire stratifié (ASTR)
1- Programme ASTRV01
Créez un macro programme « %ASTR » qui permet de collecter dans des macro variables le nombre de valeurs prises 
et les valeurs correspondantes à la variable de stratification choisie. Attention à ne pas prendre en compte les 
valeurs manquantes*/

%macro ASTR(tableint=, var_strat=);/*création de la macro ASTR avec en paramètre la table en entrée tableint et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on récupère les différentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
    	select distinct &var_strat., count(distinct &var_strat. )
		into :type1- , :nv
		from &tableint.
		where &var_strat. <>""/*on élimine les valeurs manquantes de la table en entrée*/ 
		;
	quit;
	%put Le nombre de valeur prise est &nv ;/*affichage du nombre de valeur total prise par la variable de stratification*/

	%do i=1 %to &nv.;
		%put Le type de carte &i est &&type&i;/*affichage des différents modalités prises par la variable de stratification*/
	%end;

%mend;

%ASTR(tableint=PROJET.client_macro, var_strat=typecard);/*on teste la macro avec la table client_macro et la variable typecard comme variable de stratification*/

/*2- Programme ASTRV02
Reprenez macro programme « %ASTR » et y ajoutez une partie qui éclate la table en entrée en strates. Il 
créera donc une table par strate.*/

%macro ASTR2(tableint=, var_strat=);/*création de la macro ASTR2 avec en paramètre la table en entrée tableint et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on récupère les différentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
    	select distinct &var_strat., count(distinct &var_strat.)
		into :type1- , :nv
		from &tableint.
		where &var_strat. <>"" 
		;
	quit;
	%put Le nombre de valeur prise est &nv ;

	%do i=1 %to &nv.;/*on crée des strates pour chaque valeur prise par la variable de stratification*/
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
Reprenez le programme ASTRV02 et ajoutez une partie qui crée les sous échantillons (un échantillon pour chaque strate).
Utiliser la fonction ranuni(0) de SAS en vous inspirant du A-/ */
%macro ASTR3(tableint=, tableout=, pobs=20, var_strat=);/*création de la macro ASTR3 avec en paramètre la table en entrée tableint, la table en sortie tableout , le pourcentage d'observation qui par défaut est égal à 20 et la variable de stratification var_strat*/
	proc sql noprint;/*avec la proc sql on récupère les différentes valeurs prises par la variable de stratification dans les macros variables type (1 au nombre de valeurs prises) et le nombre total de valeur prise par la variable dans la macro variable nv*/
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
Reprenez le programme ASTRV03 et ajoutez une partie qui recolle les sous échantillons en une seule table SAS.*/
%macro ASTR4(tableint=, tableout=, pobs=20, var_strat=);/*création de la macro ASTR4 avec en paramètre la table en entrée tableint, la table en sortie tableout , le pourcentage d'observation qui par défaut est égal à 20 et la variable de stratification var_strat*/
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
	
	data &tableout.;/*on crée une nouvelle table de sortie à partir de la première table echantillonéé*/
			set &tableout.1;
		run;
	
	%do i=2 %to &nv.;
		proc sql noprint;/*on ajoute à la table en sortie les autres tables échantillonées*/
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
Reprenez le programme ASTRV04 et ajoutez en paramètre le type de variable de stratification, c’est-à-dire une 
paramètre qui précise si la variable de stratification est une caractère ou numérique. Modifiez le macro programme 
en conséquence.*/
%macro ASTR5(tableint=, tableout=, pobs=20, type_var= , var_strat=, nbstrat=4);/*création de la macro ASTR5 avec en paramètre la table en entrée tableint, la table en sortie tableout , le pourcentage d'observation qui par défaut est égal à 20, le type de variable d'observation ,la variable de stratification var_strat et le nombre de strate désirée qui par défaut est égal à 4 ce qui correspond à regrouper en quartiles*/
	data _NULL_ ;/*on crée une macro variable qui récupère le type de la variable de stratification*/
		set &tableint.;
		call symput('type',vtype(&var_strat.));
	run;
	%if %upcase(&type_var.)=&type. %then /*on compare le type de valeur entrée au type réel de la variable, lorsque les deux correspondent on procède à l'échantillonnage suivant la nature charactère ou numérique de la variable de stratification*/
	%do;
		%if &type.=C %then/*échantillonnage avec une variable charactère*/
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
		%else %if &type.=N %then /*échantillonnage avec une variable numérique*/
		%do;
			proc sort data=&tableint.;/*on trie la table en entrée suivant la variable de stratification*/
				by &var_strat. ;
			run;
			proc sql noprint;/*on élimine les valeurs manquantes de la table en entrée*/
				create table &tableint. as 
				select *
				from &tableint.
				where &var_strat. <>"" 
				;
			quit; 
			data _NULL_;/*on récupère dans la macro nb la taille de la table entrée*/
				set &tableint.;
				call symput('nb',_N_ );
				;
			run;
			data _NULL_;/*on récupère dans la macro n la taille que dois avoir chaque strate*/
				set &tableint.;
				call symput('n',&nb./&nbstrat.);
			run;
			%let n1=%eval(&nbstrat.-1);
			data PROJET.strate1;/*on crée la première strate en prenant les n premiers observations*/
				set &tableint.;
				if 1 <= _N_ < &n.;
			run;
			
			%do i=2 %to &n1.;/*on crée une boucle ou on crée du deuxième à l'avant dernier strates en regroupant les n observations suivantes*/
				%let j=%eval(&i.-1);
				data PROJET.strate&i.;/*on crée la dernière strate en prenant les n derniers observations*/
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
		variable caractere et "n" pour une variable numérique;
	%end;
%mend;

%ASTR5(tableint=PROJET.client_macro,tableout=PROJET.ech,var_strat=typecard, type_var=c);


/*6- Programme ASTRV06
Reprenez le programme ASTRV05 en informant l’utilisateur dans le journal des tailles des différents échantillons 
et de la taille de l’échantillon final.*/
%macro ASTR6(tableint=, tableout=, pobs=20, type_var= , var_strat=, nbstrat=4);/*création de la macro ASTR5 avec en paramètre la table en entrée tableint, la table en sortie tableout , le pourcentage d'observation qui par défaut est égal à 20, le type de variable d'observation ,la variable de stratification var_strat et le nombre de strate désirée qui par défaut est égal à 4 ce qui correspond à regrouper en quartiles*/
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
			data _NULL_ ;/*on récupère dans la macro ttotal la taille de l'échantillon final*/
				set &tableout. ;
				call symput('ttotal',_N_);
			run;
			%do i=1 %to &nv.;/*on affiche sucessivement la taille de chaque échantillon récupéré dans la macro variable te*/
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
			data _NULL_ ;/*on récupère dans la macro ttotal la taille de l'échantillon final*/
				set &tableout. ;
				call symput('ttotal',_N_);
			run;
			%do i=1 %to &nbstrat.;/*on affiche sucessivement la taille de chaque échantillon récupéré dans la macro variable te*/
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
		variable caractere et "n" pour une variable numérique;
	%end;
%mend;

%ASTR6(tableint=PROJET.client_macro ,tableout=projet.ech, var_strat=typecard, type_var=c);	


