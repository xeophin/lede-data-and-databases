/*
Course: Data & Databases
Date: 2018-05-27
Author: Kaspar Manz
 */

/* PART ONE: WARM-UP (3 POINTS)
A explore the 'economy' table (\d economy) to get familiar with what columns are in there. Do a SELECT * FROM economy; to check out some rows, and press q to get back to the prompt. Then begin:
*/

-- 1) Find the top 10 countries by GDP using: SELECT -- FROM -- ORDER BY -- 
-- LIMIT --

SELECT country,
       gdp
FROM economy
ORDER BY gdp DESC NULLS LAST
LIMIT 10;

/*
USA	16720000
CN	9330000
J	5007000
D	3593000
F	2739000
GB	2490000
BR	2190000
R	2113000
I	2068000
CDN	1825000
 */

-- 2) Get a list of countries with the GDP below 20000 using: SELECT -- FROM --
--  WHERE --

SELECT country,
       gdp
FROM economy
WHERE gdp < 20000;

/*
country	gdp
AL	12800
MK	10650
MNE	4518
KOS	7150
AND	4800
FL	5113
BIH	18870
FARX	2320
MC	5748
GBZ	1106
GBG	2742
IS	14590
RSM	1866
GBJ	5100
M	9541
GBM	4076
MD	7932
TAD	8513
ARM	10440
GE	15950
BHT	2133
BRU	16560
LAO	10100
K	15640
KGZ	7234
MNG	11140
NEP	19340
GAZA	1700
TL	6129
PNG	16100
WEST	3700
MV	2270
AXA	175.4
AG	1220
ARU	2516
BS	8373
BDS	4262
BZ	1637
BERM	5600
BVIR	1095
CAYM	2250
NIC	11260
WD	495
RH	8287
HCA	18880
GROX	2160
WG	811
GUAD	3700
JA	14390
MART	3950
MNTS	29
CUR	5600
NLSM	794.7
SMAR	561.5
KN	767
WL	1377
SPMI	215.3
WV	742
TUCA	216
VIRG	1200
AMSA	462.2
COOK	183.2
FJI	4218
FPOL	5650
GUAM	4600
KIR	173
MH	193
FSM	339
NAU	100
NCA	9280
NIUE	10
NMIS	733
PAL	221
SLB	1099
TO	477
TUV	38
TOK	1.5
VU	828
WAFU	60
WS	705
FGU	800
GUY	3020
SME	5009
FALK	164.5
RMM	11370
RIM	4183
RN	7304
RCB	14250
NAM	12300
ZRE	18560
BEN	8359
BF	12130
RT	4299
RB	15530
ZW	10480
BI	2676
RWA	7700
RCA	2050
TCH	13590
GQ	17080
G	19970
CV	1955
SSD	11770
COM	658
RG	6544
LB	1977
DJI	1459
ER	3438
SP	2372
WAG	896
SN	15360
GNB	880
WAL	4607
LS	2457
RM	10530
MW	3683
MOC	14670
MS	11900
MAYO	953.6
SD	3807
REUN	2900
HELX	18
STP	311
SY	1271
 */

-- 3) Get a list of countries sorted by the highest rates inflation: SELECT -- 
-- FROM -- ORDER BY --

SELECT country,
       inflation
FROM economy
ORDER BY inflation DESC NULLS LAST;

/*
SYR	59.1
YV	56.2
IR	42.3
MW	26.9
SUD	25
RA	20.8
BY	19
WEST	14
ER	13
MH	12.9
RG	11.9
YE	11.8
WAL	11.1
BHT	11
GH	11
UZB	10.1
IND	9.6
JA	9.4
BI	9.3
TM	9
ET	9
ANG	8.9
RM	8.8
WAN	8.7
STP	8.7
ZW	8.5
ETH	8.4
ROU	8.3
MNG	8.2
EAT	7.8
RI	7.7
PK	7.7
BD	7.6
TR	7.6
Z	7.1
ZRE	7.1
RCA	7
VN	6.8
AFG	6.8
KGZ	6.8
R	6.8
NEP	6.7
BOL	6.5
LAO	6.5
RH	6.3
BR	6.2
EAU	6.2
ARM	6.2
RB	6.1
TN	6.1
SD	6.1
WAG	6
C	6
GQ	6
RWA	5.9
JOR	5.9
EAK	5.8
RSA	5.8
KAZ	5.8
NIC	5.7
GAZA	5.7
MYA	5.7
CR	5.6
MACX	5.5
NAM	5.5
TT	5.4
WL	5.3
HCA	5.2
LB	5.2
MV	5.1
DOM	5
GBM	5
RL	5
LS	5
CL	4.7
MD	4.6
RIM	4.6
SPMI	4.5
MNTS	4.5
TL	4.5
TCH	4.5
HONX	4.4
MOC	4.4
GCA	4.4
SY	4.3
SME	4.2
PA	4.1
MEX	4
MNE	4
GUAM	4
NIUE	4
NLSM	4
MART	3.9
DZ	3.9
GUY	3.9
IS	3.9
PNG	3.8
TUV	3.8
GUAD	3.7
TAD	3.7
GBJ	3.7
SA	3.7
MS	3.5
FSM	3.4
EW	3.4
GBG	3.4
LAR	3.2
K	3.2
CUR	3.2
RO	3.2
Q	3.1
AXA	3.1
BRN	3.1
AG	3
FJI	3
PE	2.9
CI	2.9
GBZ	2.8
GROX	2.8
WV	2.8
WAFU	2.8
KWT	2.8
RP	2.8
RSM	2.8
MK	2.8
PAL	2.7
WS	2.7
EC	2.6
SLB	2.6
CAM	2.6
CN	2.6
COM	2.5
DJI	2.5
FGU	2.5
MA	2.5
NL	2.5
TUCA	2.5
AUS	2.4
WG	2.4
BEN	2.4
AZ	2.4
SGP	2.4
PY	2.3
FARX	2.3
KN	2.2
SF	2.2
HR	2.2
RT	2.2
CO	2.2
SRB	2.2
VIRG	2.2
COOK	2.2
MAL	2.2
THA	2.2
BF	2.1
BDS	2.1
A	2.1
IRQ	2
GB	2
TO	2
H	1.9
VU	1.9
N	1.9
RN	1.9
CV	1.9
GNB	1.9
CAYM	1.8
WD	1.8
E	1.8
L	1.8
BERM	1.8
SLO	1.8
KOS	1.8
SK	1.7
NCA	1.7
IL	1.7
RCH	1.7
AL	1.7
RCB	1.7
SSD	1.7
BVIR	1.6
D	1.6
OM	1.6
USA	1.5
MC	1.5
BG	1.5
CZ	1.4
B	1.3
NZ	1.3
UAE	1.3
BZ	1.3
G	1.2
FALK	1.2
LT	1.2
I	1.2
AND	1.1
ROK	1.1
FPOL	1.1
RC	1.1
CDN	1
BS	1
M	1
BRU	1
PL	1
ES	0.9
PR	0.9
F	0.9
SN	0.8
DK	0.8
UA	0.7
IRL	0.6
P	0.4
J	0.2
LV	0.2
KIR	0.2
CY	0.2
BIH	0.2
RMM	0.1
S	0
CH	-0.4
GE	-0.5
FL	-0.7
GR	-0.8
ARU	-2
NMIS	-2.7
NAU	-3.6
SP	
HELX	
SVAX	
REUN	
SMAR	
SBAR	
MEL	
CEU	
AMSA	
NOK	
XMAS	
COCO	
MAYO	
TOK	
V	
NORF	
WSA	
PITC	

 */

-- 4) List all countries with the majority of their GDP coming from agriculture: SELECT -- FROM -- WHERE --

SELECT country,
       agriculture
FROM economy
WHERE agriculture > service
  AND agriculture > industry
ORDER BY agriculture DESC;

/*
country	agriculture
LB	76.9
SP	59.3
GNB	58
RCA	56.6
COM	51
SLB	50
WAL	47.9
ETH	47
TCH	46.3
ZRE	44.3
RMM	38.5

 */

-- 5) Create a list of countries in order of highest unemployment, and join 
-- the table with the country table so you get the names of the countries not the country code: SELECT -- FROM -- JOIN - ON -- ORDER BY --

SELECT country.name,
       economy.unemployment
FROM economy
  JOIN country ON country.code = economy.country
ORDER BY unemployment DESC NULLS LAST;

/*
name	unemployment
Zimbabwe	95
Nauru	90
Liberia	85
Burkina Faso	77
Turkmenistan	60
Djibouti	59
Congo	53
Senegal	48
Nepal	46
Bosnia and Herzegovina	44.3
Haiti	40.6
Swaziland	40
Kenya	40
Marshall Islands	36
Yemen	35
Afghanistan	35
Grenada	33.5
Kosovo	30.9
Cameroon	30
Mauritania	30
Mali	30
Libya	30
American Samoa	29.8
Macedonia	28.6
Maldives	28
Greece	27.9
Namibia	27.4
Spain	26.3
Lesotho	25
South Africa	24.9
Nigeria	23.9
Dominica	23
Equatorial Guinea	22.3
Micronesia	22
Croatia	21.6
Cape Verde	21
Gabon	21
Serbia	20.1
Comoros	20
Sudan	20
Saint Lucia	20
Montenegro	19.1
Saint Vincent and the Grenadines	18.8
Timor-Leste	18.4
Botswana	17.8
Syria	17.8
Ethiopia	17.5
Cyprus	17.4
Armenia	17.3
Tunisia	17.2
New Caledonia	17.1
Mozambique	17
Albania	16.9
Portugal	16.8
Jamaica	16.3
Bahamas	16.2
Puerto Rico	16
Iran	16
Iraq	16
Belize	15.5
Oman	15
Bahrain	15
Zambia	15
Georgia	15
Dominican Republic	15
Slovakia	14.4
Jordan	14
Ireland	13.5
Egypt	13.4
Slovenia	13.1
Cook Islands	13.1
Curacao	13
Tonga	13
Lithuania	12.4
Italy	12.4
Wallis and Futuna	12.2
Niue	12
Sint Maarten	12
French Polynesia	11.7
Bulgaria	11.6
Barbados	11.4
Northern Mariana Islands	11.2
Antigua and Barbuda	11
Ghana	11
Guyana	11
Estonia	10.9
Hungary	10.5
Saudi Arabia	10.5
Poland	10.3
Algeria	10.3
France	10.2
Turks and Caicos Islands	10
Saint Pierre and Miquelon	9.9
Latvia	9.8
Colombia	9.7
Morocco	9.5
Greenland	9.4
Turkey	9.3
Mongolia	9
Suriname	9
India	8.8
Belgium	8.8
British Virgin Islands	8.7
Kyrgyzstan	8.6
Mauritius	8.3
Netherlands	8.3
Guam	8.2
Sweden	8.1
Finland	8.1
Central African Republic	8
Ukraine	8
Anguilla	8
Bermuda	8
Venezuela	7.9
Costa Rica	7.9
Fiji	7.6
Argentina	7.5
Bolivia	7.4
Philippines	7.4
United States	7.3
Romania	7.3
United Kingdom	7.2
Nicaragua	7.2
Czech Republic	7.1
Canada	7.1
San Marino	7
Aruba	6.9
Faroe Islands	6.8
Pakistan	6.6
Indonesia	6.6
Paraguay	6.6
Uruguay	6.5
New Zealand	6.4
Malta	6.4
El Salvador	6.3
Virgin Islands	6.2
Denmark	6
Azerbaijan	6
Chile	6
Montserrat	6
Trinidad and Tobago	5.9
Russia	5.8
Moldova	5.8
Israel	5.8
Brazil	5.7
Australia	5.7
Germany	5.3
Kazakhstan	5.3
Myanmar	5.2
Sri Lanka	5.1
Bangladesh	5
Austria	4.9
Luxembourg	4.9
Uzbekistan	4.9
Mexico	4.9
Honduras	4.5
Saint Kitts and Nevis	4.5
Iceland	4.5
Panama	4.5
Cuba	4.3
Palau	4.2
Ecuador	4.2
Japan	4.1
China	4.1
Guatemala	4.1
Taiwan	4.1
Falkland Islands	4.1
Andorra	4
Cayman Islands	4
Norway	3.6
Peru	3.6
Kuwait	3.4
Switzerland	3.2
South Korea	3.2
Hong Kong	3.1
Malaysia	3.1
Gibraltar	3
Brunei	2.6
Tajikistan	2.5
United Arab Emirates	2.4
Liechtenstein	2.3
Bhutan	2.1
Isle of Man	2
Seychelles	2
Monaco	2
Kiribati	2
Papua New Guinea	1.9
Singapore	1.9
Laos	1.9
Macao	1.8
Jersey	1.7
Vanuatu	1.7
Vietnam	1.3
Belarus	1
Guernsey	0.9
Thailand	0.7
Qatar	0.3
Cambodia	0
Benin	
Samoa	
Christmas Island	
Togo	
Cocos Islands	
Melilla	
Ceuta	
Cote d'Ivoire	
Holy See	
Burundi	
Rwanda	
Tanzania	
Chad	
Norfolk Island	
Gaza Strip	
French Guiana	
Saint Barthelemy	
South Sudan	
Saint Martin	
Guinea	
Lebanon	
Martinique	
Eritrea	
Somalia	
West Bank	
Gambia	
Pitcairn	
Guinea-Bissau	
Sierra Leone	
Uganda	
Guadeloupe	
Madagascar	
Malawi	
Solomon Islands	
Mayotte	
Tuvalu	
Reunion	
Saint Helena	
Sao Tome and Principe	
Niger	
Tokelau	
Svalbard	
Western Sahara	
Angola	
North Korea	
Zaire	

 */

-- 6) Invent your own query for the economy table--as simple or as complicated 
-- as you want it to be.

SELECT country.name,
       economy.service
FROM economy
  JOIN country ON country.code = economy.country
WHERE economy.service > 75
ORDER BY economy.service DESC NULLS LAST;

/*
name	service
Gibraltar	100
Jersey	96
Northern Mariana Islands	95
Bermuda	93.5
Macao	93.5
Hong Kong	93
Bahamas	90.8
Monaco	90
Isle of Man	88
Montenegro	87.9
British Virgin Islands	87.2
Guernsey	87
Luxembourg	86.4
Guadeloupe	85
Saint Martin	84
Curacao	83.8
Martinique	83
Saint Pierre and Miquelon	83
Barbados	83
Cook Islands	82.1
Cyprus	81.7
Antigua and Barbuda	81.4
Sint Maarten	81.3
Greece	80.5
Virgin Islands	80
Maldives	80
Djibouti	79.7
Saint Lucia	79.5
Seychelles	79.4
United States	79.4
France	79.4
United Kingdom	78.9
Grenada	78.5
Panama	78.4
French Polynesia	76.9
Denmark	76.8
Palau	76.8
Belgium	76.6
Turks and Caicos Islands	76.5
Lebanon	75.4
Portugal	75.2
Montserrat	75.1
Saint Kitts and Nevis	75.1

 */

/*
PART TWO: AGGREGATE QUERIES (3 POINTS)
Do the following for queries using the 'language' table.
*/

-- 1) Find the top 10 most dominant languages (highest percentage) in their respective countries. This isn't an aggregate query, use ORDER BY along with other stuff.

SELECT country,
       name,
       percentage
FROM language
ORDER BY percentage DESC NULLS LAST;

/*
country	name	percentage
R	Russian	100
STP	Portuguese	100
RCH	Spanish	100
RA	Spanish	100
PITC	Pitkern	100
TUCA	English	100
SPMI	French	100
KN	English	100
MNTS	English	100
DOM	Spanish	100
C	Spanish	100
BVIR	English	100
BDS	English	100
AG	English	100
AXA	English	100
J	Japanese	100
SA	Arabic	100
D	German	100
NEP	Nepali	100
NOK	Korean	100
MYA	Burmese	100
FL	German	100
P	Portuguese	100
GBM	English	100
RSM	Italian	100
IS	Icelandic	100
NL	Dutch	100
PL	Polish	100
HELX	English	100
MOC	Portuguese	100
RG	French	100
FALK	English	100
FGU	French	100
CR	Spanish	99
BIH	Serbo-Croatian	99
EC	Spanish	99
YV	Spanish	99
ROU	Spanish	99
BR	Portuguese	99
N	Norwegian	99
GAZA	Arabic	99
CO	Spanish	99
GUAD	French	99
HCA	Spanish	99
ES	Spanish	99
GR	Greek	99
AL	Albanian	98.8
F	French	98
DK	Danish	98
I	Italian	98
ARM	Armenian	97.7
NIC	Spanish	97.5
HR	Croatian	96.1
S	Swedish	96
HONX	Chinese	95.6
MEX	Spanish	95
CAYM	English	95
IRL	English	95
GB	English	95
CZ	Czech	94.9
GBJ	English	94.5
H	Hungarian	93.6
KOS	Albanian	92
NZ	English	91.2
SLO	Slovenian	91
RO	Romanian	91
AMSA	Samoan	90.6
AZ	Azeri	90.3
M	Maltese	90.2
MNG	Khalkha Mongol	90
RH	Creole	90
SF	Finnish	90
PY	Spanish	90
A	German	88.6
SRB	Serbian	88.3
PE	Spanish	84.1
PA	Spanish	84
SK	Slovak	83.8
USA	English	82.1
LT	Lithuanian	82
CUR	Papiamento	81.2
TR	Turkish	80
RMM	Bambara	80
AUS	English	78.5
CY	Greek	78
L	Luxembourgish	77
BG	Bulgarian	76.8
IL	Hebrew	76
MD	Romanian	75.8
WEST	Arabic	75
CL	Sinhala	74.9
UZB	Uzbek	74.3
E	Spanish	74
TM	Turkmen	72
GE	Georgian	71
GQ	Spanish	67.6
NLSM	English	67.5
EW	Estonian	67.3
UA	Ukrainian	67
MK	Macedonian	66.5
KGZ	Kyrgyz	64.7
KAZ	Kazakh	64.4
CH	German	64
MNE	Serbian	63.6
BY	Russian	62.8
FPOL	French	61.1
BOL	Spanish	60.7
GCA	Spanish	60
NAM	Afrikaans	60
WAFU	Wallisian	58.9
CDN	English	58.8
LV	Latvian	58.2
IR	Persian	58
B	Dutch	56
AFG	Afghan Persian	50
MC	French	50
PK	Punjabi	48
BZ	Spanish	46
AND	Catalan	44
GCA	Amerindian	40
GUAM	English	38.3
LV	Russian	37.5
BY	Belorussian	36.7
AFG	Pashtu	35
AND	Spanish	33
BZ	Creole	32.9
NAM	German	32
B	French	32
FPOL	Polynesian	31.4
WAFU	Futunian	30.1
IND	Hindi	30
EW	Russian	29.7
IR	Turkic	26
MK	Albanian	25.1
CL	Tamil	24.6
NMIS	Philipine Language	24.4
UA	Russian	24
NMIS	Chinese Language	23.4
IL	Arabic	23
NMIS	Chamorro	22.4
GUAM	Chamorro	22.2
GUAM	Philipine Language	22.2
MNE	Montenegrin	22
MC	Monegasque	21.6
CDN	French	21.6
BOL	Quechua	21.2
LB	English	20
CH	French	20
MC	Italian	19
E	Catalan	19
CY	Turkish	18
WEST	Hebrew	17
MD	Russian	16
TR	Kurdish	15
BOL	Aymara	14.6
UZB	Russian	14.2
PA	English	14
KGZ	Uzbek	13.6
PE	Quechua	13
NLSM	Spanish	12.9
KGZ	Russian	12.5
TM	Russian	12
PK	Sindhi	12
AFG	Turkic	11
AND	Portuguese	11
NMIS	English	10.8
WAFU	French	10.8
USA	Spanish	10.7
SK	Hungarian	10.7
RH	French	10
PK	Siraiki	10
NMIS	Other Pacific Island Language	9.5
IR	Kurdish	9
GE	Russian	9
TM	Uzbek	9
BZ	Mayan Dialects	8.9
MC	English	8.5
NLSM	Creole	8.2
BG	Turkish	8.2
PK	Pashtu	8
CUR	Dutch	8
PY	Guarani	8
L	Portuguese	8
LT	Russian	8
PK	Urdu	8
CH	Italian	7
GE	Armenian	7
AND	French	7
SLO	Croatian	7
NAM	English	7
RO	Hungarian	6.7
M	English	6
GE	Azeri	6
L	French	6
LT	Polish	5.6
MNE	Bosnian	5.5
SF	Swedish	5.4
MNE	Albanian	5.3
KOS	Serbian	5
E	Galician	5
GBJ	Portuguese	4.6
UZB	Tajik	4.4
NLSM	Dutch	4.2
L	German	4
MACX	Portuguese	4
CUR	Spanish	4
MD	Ukrainian	4
NZ	Maori	3.9
BZ	English	3.9
BG	Roma	3.8
SRB	Hungarian	3.8
MC	German	3.5
MK	Turkish	3.5
BZ	Garifuna	3.4
BZ	German	3.3
CAYM	Spanish	3.2
HONX	English	3.2
PK	Balochi	3
MD	Gagauz	3
AMSA	English	2.9
CUR	English	2.9
S	Finnish	2.6
AUS	Chinese	2.5
A	Croatian	2.5
AMSA	Tongan	2.4
A	Turkish	2.3
NLSM	Papiamento	2.2
AZ	Lezgi	2.2
A	Serbian	2.2
NZ	Samoan	2.1
NZ	Chinese	2.1
MC	Dutch	2
AND	Galician	2
E	Basque	2
PK	Hindko	2
IR	Luri	2
CZ	Slovak	2
MK	Roma	1.9
AZ	Russian	1.8
SK	Roma	1.8
SRB	Bosnian	1.8
SF	Russian	1.8
PE	Aymara	1.7
NIC	Miskito	1.7
AUS	Italian	1.6
NLSM	French	1.5
AZ	Armenian	1.5
NZ	French	1.3
AUS	Greek	1.3
MK	Serbian	1.2
AUS	Arabic	1.2
SRB	Roma	1.1
RO	Roma	1.1
NZ	Hindi	1.1
KGZ	Dungun	1
SLB	English	1
ARM	Kurd	1
PK	Brahui	1
IR	Arabic	1
IR	Balochi	1
IR	Turkish	1
PNG	English	1
SK	Ukrainian	1
AUS	Vietnamese	1
CH	Romansch	1
HR	Serbian	1
L	English	1
B	German	1
ARM	Russian	0.9
I	German	0.7
SF	Estonian	0.6
GAZA	Hebrew	0.6
F	Occitan	0.5
AL	Greek	0.5
DK	German	0.4
SF	Somali	0.3
SF	English	0.3
SF	Arabic	0.3
A	Slovene	0.3
I	Slovenian	0.2
I	French	0.2
A	Hungarian	0.1
I	Albanian	0.1

 */

-- 2) Get a list of the 10 countries with the most languages according to this database. This is an aggregate query. This should have two columns, the country and the number of languages in the country. Hint: you will be using COUNT() and GROUP BY along with other stuff.

SELECT country,
       COUNT(name) AS number_of_languages
FROM language
GROUP BY country
ORDER BY number_of_languages DESC
LIMIT 10;

/*
country	number_of_languages
PK	8
IR	7
SF	7
A	6
AUS	6
NLSM	6
MC	6
NZ	6
BZ	6
NMIS	5

 */

-- 3) Get the same list, but join the country code to the country table so 
-- you get the full names of the countries.

SELECT country.name,
       COUNT(language.name) AS number_of_language
FROM language
  JOIN country ON country.code = language.country
GROUP BY country.name
ORDER BY number_of_language DESC
LIMIT 10;

/*
name	number_of_language
Pakistan	8
Finland	7
Iran	7
Austria	6
New Zealand	6
Sint Maarten	6
Australia	6
Monaco	6
Belize	6
Italy	5

 */

-- 4) Get a list of the 10 languages that are most commonly found from 
-- country to country. This should have two columns, the language and the number of countries it appears in.

SELECT name,
       COUNT(country) AS number_of_countries
FROM language
GROUP BY name
ORDER BY number_of_countries DESC
LIMIT 10;

/*
name	number_of_countries
English	34
Spanish	26
French	17
Russian	14
German	11
Portuguese	8
Arabic	7
Serbian	6
Turkish	6
Dutch	5

 */

-- 5) Get a list of the 20 languages that are most commonly found from 
-- country to country. This is just like the previous query, except it should have a third column that has the average percentage of the population that speaks the language.

SELECT name,
       COUNT(country)  AS number_of_countries,
       AVG(percentage) AS average_percentage
FROM language
GROUP BY name
ORDER BY number_of_countries DESC
LIMIT 20;

/*
name	number_of_countries	average_percentage
English	34	55.2470588235294118
Spanish	26	73.6807692307692308
French	17	42.2647058823529412
Russian	14	23.5857142857142857
German	11	36.1363636363636364
Portuguese	8	53.325
Arabic	7	42.7857142857142857
Serbian	6	26.8833333333333333
Turkish	6	18.8333333333333333
Albanian	5	44.26
Hungarian	5	22.98
Dutch	5	34.04
Italian	5	45.12
Roma	5	1.94
Greek	4	44.7
Armenian	3	35.4
Ukrainian	3	24
Hebrew	3	31.2
Croatian	3	35.2
Chinese	3	33.4

 */

-- 6) Finally, modify that last query so that you only get languages that are spoken in more than four countries, but order the results by the highest average percentage of speakers. Hint: you need to use HAVING along with other stuff.

SELECT name,
       COUNT(country)  AS number_of_countries,
       AVG(percentage) AS average_percentage
FROM language
GROUP BY name
HAVING COUNT(country) > 4
ORDER BY average_percentage DESC;

/*
name	number_of_countries	average_percentage
Spanish	26	73.6807692307692308
English	34	55.2470588235294118
Portuguese	8	53.325
Italian	5	45.12
Albanian	5	44.26
Arabic	7	42.7857142857142857
French	17	42.2647058823529412
German	11	36.1363636363636364
Dutch	5	34.04
Serbian	6	26.8833333333333333
Russian	14	23.5857142857142857
Hungarian	5	22.98
Turkish	6	18.8333333333333333
Roma	5	1.94

 */

--region Class from 2018-05-29
