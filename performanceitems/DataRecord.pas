unit DataRecord;

interface

uses
  Data;

type
  TCountry = record
    ID: String;
    Name: String;
  end;

const
  ARRAY_COUNTRY: array [0 .. COUNTRY_COUNT] of TCountry = ( //
    (ID: '93'; Name: 'Afganistán'), //
    (ID: '355'; Name: 'Albania'), //
    (ID: '49'; Name: 'Alemania'), //
    (ID: '213'; Name: 'Algeria'), //
    (ID: '376'; Name: 'Andorra'), //
    (ID: '244'; Name: 'Angola'), //
    (ID: '1 264'; Name: 'Anguila'), //
    (ID: '672'; Name: 'Antártida'), //
    (ID: '1 268'; Name: 'Antigua y Barbuda'), //
    (ID: '599'; Name: 'Antillas Neerlandesas'), //
    (ID: '966'; Name: 'Arabia Saudita'), //
    (ID: '54'; Name: 'Argentina'), //
    (ID: '374'; Name: 'Armenia'), //
    (ID: '297'; Name: 'Aruba'), //
    (ID: '61'; Name: 'Australia'), //
    (ID: '43'; Name: 'Austria'), //
    (ID: '994'; Name: 'Azerbayán'), //
    (ID: '32'; Name: 'Bélgica'), //
    (ID: '1 242'; Name: 'Bahamas'), //
    (ID: '973'; Name: 'Bahrein'), //
    (ID: '880'; Name: 'Bangladesh'), //
    (ID: '1 246'; Name: 'Barbados'), //
    (ID: '501'; Name: 'Belice'), //
    (ID: '229'; Name: 'Benín'), //
    (ID: '975'; Name: 'Bhután'), //
    (ID: '375'; Name: 'Bielorrusia'), //
    (ID: '95'; Name: 'Birmania'), //
    (ID: '591'; Name: 'Bolivia'), //
    (ID: '387'; Name: 'Bosnia y Herzegovina'), //
    (ID: '267'; Name: 'Botsuana'), //
    (ID: '55'; Name: 'Brasil'), //
    (ID: '673'; Name: 'Brunéi'), //
    (ID: '359'; Name: 'Bulgaria'), //
    (ID: '226'; Name: 'Burkina Faso'), //
    (ID: '257'; Name: 'Burundi'), //
    (ID: '238'; Name: 'Cabo Verde'), //
    (ID: '855'; Name: 'Camboya'), //
    (ID: '237'; Name: 'Camerún'), //
    (ID: '1'; Name: 'Canadá'), //
    (ID: '235'; Name: 'Chad'), //
    (ID: '56'; Name: 'Chile'), //
    (ID: '86'; Name: 'China'), //
    (ID: '357'; Name: 'Chipre'), //
    (ID: '39'; Name: 'Ciudad del Vaticano'), //
    (ID: '57'; Name: 'Colombia'), //
    (ID: '269'; Name: 'Comoras'), //
    (ID: '242'; Name: 'Congo'), //
    (ID: '243'; Name: 'Congo'), //
    (ID: '850'; Name: 'Corea del Norte'), //
    (ID: '82'; Name: 'Corea del Sur'), //
    (ID: '225'; Name: 'Costa de Marfil'), //
    (ID: '506'; Name: 'Costa Rica'), //
    (ID: '385'; Name: 'Croacia'), //
    (ID: '53'; Name: 'Cuba'), //
    (ID: '45'; Name: 'Dinamarca'), //
    (ID: '1 767'; Name: 'Dominica'), //
    (ID: '593'; Name: 'Ecuador'), //
    (ID: '20'; Name: 'Egipto'), //
    (ID: '503'; Name: 'El Salvador'), //
    (ID: '971'; Name: 'Emiratos Árabes Unidos'), //
    (ID: '291'; Name: 'Eritrea'), //
    (ID: '421'; Name: 'Eslovaquia'), //
    (ID: '386'; Name: 'Eslovenia'), //
    (ID: '34'; Name: 'España'), //
    (ID: '1'; Name: 'Estados Unidos de América'), //
    (ID: '372'; Name: 'Estonia'), //
    (ID: '251'; Name: 'Etiopía'), //
    (ID: '63'; Name: 'Filipinas'), //
    (ID: '358'; Name: 'Finlandia'), //
    (ID: '679'; Name: 'Fiyi'), //
    (ID: '33'; Name: 'Francia'), //
    (ID: '241'; Name: 'Gabón'), //
    (ID: '220'; Name: 'Gambia'), //
    (ID: '995'; Name: 'Georgia'), //
    (ID: '233'; Name: 'Ghana'), //
    (ID: '350'; Name: 'Gibraltar'), //
    (ID: '1 473'; Name: 'Granada'), //
    (ID: '30'; Name: 'Grecia'), //
    (ID: '299'; Name: 'Groenlandia'), //
    (ID: ''; Name: 'Guadalupe'), //
    (ID: '1 671'; Name: 'Guam'), //
    (ID: '502'; Name: 'Guatemala'), //
    (ID: ''; Name: 'Guayana Francesa'), //
    (ID: ''; Name: 'Guernsey'), //
    (ID: '224'; Name: 'Guinea'), //
    (ID: '240'; Name: 'Guinea Ecuatorial'), //
    (ID: '245'; Name: 'Guinea-Bissau'), //
    (ID: '592'; Name: 'Guyana'), //
    (ID: '509'; Name: 'Haití'), //
    (ID: '504'; Name: 'Honduras'), //
    (ID: '852'; Name: 'Hong kong'), //
    (ID: '36'; Name: 'Hungría'), //
    (ID: '91'; Name: 'India'), //
    (ID: '62'; Name: 'Indonesia'), //
    (ID: '98'; Name: 'Irán'), //
    (ID: '964'; Name: 'Irak'), //
    (ID: '353'; Name: 'Irlanda'), //
    (ID: ''; Name: 'Isla Bouvet'), //
    (ID: '44'; Name: 'Isla de Man'), //
    (ID: '61'; Name: 'Isla de Navidad'), //
    (ID: ''; Name: 'Isla Norfolk'), //
    (ID: '354'; Name: 'Islandia'), //
    (ID: '1 441'; Name: 'Islas Bermudas'), //
    (ID: '1 345'; Name: 'Islas Caimán'), //
    (ID: '61'; Name: 'Islas Cocos (Keeling)'), //
    (ID: '682'; Name: 'Islas Cook'), //
    (ID: ''; Name: 'Islas de Åland'), //
    (ID: '298'; Name: 'Islas Feroe'), //
    (ID: ''; Name: 'Islas Georgias del Sur y Sandwich del Sur'), //
    (ID: ''; Name: 'Islas Heard y McDonald'), //
    (ID: '960'; Name: 'Islas Maldivas'), //
    (ID: '500'; Name: 'Islas Malvinas'), //
    (ID: '1 670'; Name: 'Islas Marianas del Norte'), //
    (ID: '692'; Name: 'Islas Marshall'), //
    (ID: '870'; Name: 'Islas Pitcairn'), //
    (ID: '677'; Name: 'Islas Salomón'), //
    (ID: '1 649'; Name: 'Islas Turcas y Caicos'), //
    (ID: ''; Name: 'Islas Ultramarinas Menores de Estados Unidos'), //
    (ID: '1 284'; Name: 'Islas Vírgenes Británicas'), //
    (ID: '1 340'; Name: 'Islas Vírgenes de los Estados Unidos'), //
    (ID: '972'; Name: 'Israel'), //
    (ID: '39'; Name: 'Italia'), //
    (ID: '1 876'; Name: 'Jamaica'), //
    (ID: '81'; Name: 'Japón'), //
    (ID: ''; Name: 'Jersey'), //
    (ID: '962'; Name: 'Jordania'), //
    (ID: '7'; Name: 'Kazajistán'), //
    (ID: '254'; Name: 'Kenia'), //
    (ID: '996'; Name: 'Kirgizstán'), //
    (ID: '686'; Name: 'Kiribati'), //
    (ID: '965'; Name: 'Kuwait'), //
    (ID: '961'; Name: 'Líbano'), //
    (ID: '856'; Name: 'Laos'), //
    (ID: '266'; Name: 'Lesoto'), //
    (ID: '371'; Name: 'Letonia'), //
    (ID: '231'; Name: 'Liberia'), //
    (ID: '218'; Name: 'Libia'), //
    (ID: '423'; Name: 'Liechtenstein'), //
    (ID: '370'; Name: 'Lituania'), //
    (ID: '352'; Name: 'Luxemburgo'), //
    (ID: '52'; Name: 'México'), //
    (ID: '377'; Name: 'Mónaco'), //
    (ID: '853'; Name: 'Macao'), //
    (ID: '389'; Name: 'Macedônia'), //
    (ID: '261'; Name: 'Madagascar'), //
    (ID: '60'; Name: 'Malasia'), //
    (ID: '265'; Name: 'Malawi'), //
    (ID: '223'; Name: 'Mali'), //
    (ID: '356'; Name: 'Malta'), //
    (ID: '212'; Name: 'Marruecos'), //
    (ID: ''; Name: 'Martinica'), //
    (ID: '230'; Name: 'Mauricio'), //
    (ID: '222'; Name: 'Mauritania'), //
    (ID: '262'; Name: 'Mayotte'), //
    (ID: '691'; Name: 'Micronesia'), //
    (ID: '373'; Name: 'Moldavia'), //
    (ID: '976'; Name: 'Mongolia'), //
    (ID: '382'; Name: 'Montenegro'), //
    (ID: '1 664'; Name: 'Montserrat'), //
    (ID: '258'; Name: 'Mozambique'), //
    (ID: '264'; Name: 'Namibia'), //
    (ID: '674'; Name: 'Nauru'), //
    (ID: '977'; Name: 'Nepal'), //
    (ID: '505'; Name: 'Nicaragua'), //
    (ID: '227'; Name: 'Niger'), //
    (ID: '234'; Name: 'Nigeria'), //
    (ID: '683'; Name: 'Niue'), //
    (ID: '47'; Name: 'Noruega'), //
    (ID: '687'; Name: 'Nueva Caledonia'), //
    (ID: '64'; Name: 'Nueva Zelanda'), //
    (ID: '968'; Name: 'Omán'), //
    (ID: '31'; Name: 'Países Bajos'), //
    (ID: '92'; Name: 'Pakistán'), //
    (ID: '680'; Name: 'Palau'), //
    (ID: ''; Name: 'Palestina'), //
    (ID: '507'; Name: 'Panamá'), //
    (ID: '675'; Name: 'Papúa Nueva Guinea'), //
    (ID: '595'; Name: 'Paraguay'), //
    (ID: '51'; Name: 'Perú'), //
    (ID: '689'; Name: 'Polinesia Francesa'), //
    (ID: '48'; Name: 'Polonia'), //
    (ID: '351'; Name: 'Portugal'), //
    (ID: '1'; Name: 'Puerto Rico'), //
    (ID: '974'; Name: 'Qatar'), //
    (ID: '44'; Name: 'Reino Unido'), //
    (ID: '236'; Name: 'República Centroafricana'), //
    (ID: '420'; Name: 'República Checa'), //
    (ID: '1 809'; Name: 'República Dominicana'), //
    (ID: ''; Name: 'Reunión'), //
    (ID: '250'; Name: 'Ruanda'), //
    (ID: '40'; Name: 'Rumanía'), //
    (ID: '7'; Name: 'Rusia'), //
    (ID: ''; Name: 'Sahara Occidental'), //
    (ID: '685'; Name: 'Samoa'), //
    (ID: '1 684'; Name: 'Samoa Americana'), //
    (ID: '590'; Name: 'San Bartolomé'), //
    (ID: '1 869'; Name: 'San Cristóbal y Nieves'), //
    (ID: '378'; Name: 'San Marino'), //
    (ID: '1 599'; Name: 'San Martín (Francia)'), //
    (ID: '508'; Name: 'San Pedro y Miquelón'), //
    (ID: '1 784'; Name: 'San Vicente y las Granadinas'), //
    (ID: '290'; Name: 'Santa Elena'), //
    (ID: '1 758'; Name: 'Santa Lucía'), //
    (ID: '239'; Name: 'Santo Tomé y Príncipe'), //
    (ID: '221'; Name: 'Senegal'), //
    (ID: '381'; Name: 'Serbia'), //
    (ID: '248'; Name: 'Seychelles'), //
    (ID: '232'; Name: 'Sierra Leona'), //
    (ID: '65'; Name: 'Singapur'), //
    (ID: '963'; Name: 'Siria'), //
    (ID: '252'; Name: 'Somalia'), //
    (ID: '94'; Name: 'Sri lanka'), //
    (ID: '27'; Name: 'Sudáfrica'), //
    (ID: '249'; Name: 'Sudán'), //
    (ID: '46'; Name: 'Suecia'), //
    (ID: '41'; Name: 'Suiza'), //
    (ID: '597'; Name: 'Surinám'), //
    (ID: ''; Name: 'Svalbard y Jan Mayen'), //
    (ID: '268'; Name: 'Swazilandia'), //
    (ID: '992'; Name: 'Tadjikistán'), //
    (ID: '66'; Name: 'Tailandia'), //
    (ID: '886'; Name: 'Taiwán'), //
    (ID: '255'; Name: 'Tanzania'), //
    (ID: ''; Name: 'Territorio Británico del Océano Índico'), //
    (ID: ''; Name: 'Territorios Australes y Antárticas Franceses'), //
    (ID: '670'; Name: 'Timor Oriental'), //
    (ID: '228'; Name: 'Togo'), //
    (ID: '690'; Name: 'Tokelau'), //
    (ID: '676'; Name: 'Tonga'), //
    (ID: '1 868'; Name: 'Trinidad y Tobago'), //
    (ID: '216'; Name: 'Tunez'), //
    (ID: '993'; Name: 'Turkmenistán'), //
    (ID: '90'; Name: 'Turquía'), //
    (ID: '688'; Name: 'Tuvalu'), //
    (ID: '380'; Name: 'Ucrania'), //
    (ID: '256'; Name: 'Uganda'), //
    (ID: '598'; Name: 'Uruguay'), //
    (ID: '998'; Name: 'Uzbekistán'), //
    (ID: '678'; Name: 'Vanuatu'), //
    (ID: '58'; Name: 'Venezuela'), //
    (ID: '84'; Name: 'Vietnam'), //
    (ID: '681'; Name: 'Wallis y Futuna'), //
    (ID: '967'; Name: 'Yemen'), //
    (ID: '253'; Name: 'Yibuti'), //
    (ID: '260'; Name: 'Zambia'), //
    (ID: '263'; Name: 'Zimbabue') //
    );

implementation

end.
