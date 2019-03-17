unit Data;

interface

const
  COUNTRY_COUNT = 245;
  COUNTRY_CODE: array [0 .. COUNTRY_COUNT] of string = ('AFG', 'ALB', 'DEU', 'DZA', 'AND', 'AGO', 'AIA', 'ATA', 'ATG',
    'ANT', 'SAU', 'ARG', 'ARM', 'ABW', 'AUS', 'AUT', 'AZE', 'BEL', 'BHS', 'BHR', 'BGD', 'BRB', 'BLZ', 'BEN', 'BTN',
    'BLR', 'MMR', 'BOL', 'BIH', 'BWA', 'BRA', 'BRN', 'BGR', 'BFA', 'BDI', 'CPV', 'KHM', 'CMR', 'CAN', 'TCD', 'CHL',
    'CHN', 'CYP', 'VAT', 'COL', 'COM', 'COG', 'COD', 'PRK', 'KOR', 'CIV', 'CRI', 'HRV', 'CUB', 'DNK', 'DMA', 'ECU',
    'EGY', 'SLV', 'ARE', 'ERI', 'SVK', 'SVN', 'ESP', 'USA', 'EST', 'ETH', 'PHL', 'FIN', 'FJI', 'FRA', 'GAB', 'GMB',
    'GEO', 'GHA', 'GIB', 'GRD', 'GRC', 'GRL', 'GLP', 'GUM', 'GTM', 'GUF', 'GGY', 'GIN', 'GNQ', 'GNB', 'GUY', 'HTI',
    'HND', 'HKG', 'HUN', 'IND', 'IDN', 'IRN', 'IRQ', 'IRL', 'BVT', 'IMN', 'CXR', 'NFK', 'ISL', 'BMU', 'CYM', 'CCK',
    'COK', 'ALA', 'FRO', 'SGS', 'HMD', 'MDV', 'FLK', 'MNP', 'MHL', 'PCN', 'SLB', 'TCA', 'UMI', 'VG', 'VIR', 'ISR',
    'ITA', 'JAM', 'JPN', 'JEY', 'JOR', 'KAZ', 'KEN', 'KGZ', 'KIR', 'KWT', 'LBN', 'LAO', 'LSO', 'LVA', 'LBR', 'LBY',
    'LIE', 'LTU', 'LUX', 'MEX', 'MCO', 'MAC', 'MKD', 'MDG', 'MYS', 'MWI', 'MLI', 'MLT', 'MAR', 'MTQ', 'MUS', 'MRT',
    'MYT', 'FSM', 'MDA', 'MNG', 'MNE', 'MSR', 'MOZ', 'NAM', 'NRU', 'NPL', 'NIC', 'NER', 'NGA', 'NIU', 'NOR', 'NCL',
    'NZL', 'OMN', 'NLD', 'PAK', 'PLW', 'PSE', 'PAN', 'PNG', 'PRY', 'PER', 'PYF', 'POL', 'PRT', 'PRI', 'QAT', 'GBR',
    'CAF', 'CZE', 'DOM', 'REU', 'RWA', 'ROU', 'RUS', 'ESH', 'WSM', 'ASM', 'BLM', 'KNA', 'SMR', 'MAF', 'SPM', 'VCT',
    'SHN', 'LCA', 'STP', 'SEN', 'SRB', 'SYC', 'SLE', 'SGP', 'SYR', 'SOM', 'LKA', 'ZAF', 'SDN', 'SWE', 'CHE', 'SUR',
    'SJM', 'SWZ', 'TJK', 'THA', 'TWN', 'TZA', 'IOT', 'ATF', 'TLS', 'TGO', 'TKL', 'TON', 'TTO', 'TUN', 'TKM', 'TUR',
    'TUV', 'UKR', 'UGA', 'URY', 'UZB', 'VUT', 'VEN', 'VNM', 'WLF', 'YEM', 'DJI', 'ZMB', 'ZWE');
  COUNTRY_NAME: array [0 .. COUNTRY_COUNT] of string = ('Afganist�n', 'Albania', 'Alemania', 'Algeria', 'Andorra',
    'Angola', 'Anguila', 'Ant�rtida', 'Antigua y Barbuda', 'Antillas Neerlandesas', 'Arabia Saudita', 'Argentina',
    'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbay�n', 'B�lgica', 'Bahamas', 'Bahrein', 'Bangladesh', 'Barbados',
    'Belice', 'Ben�n', 'Bhut�n', 'Bielorrusia', 'Birmania', 'Bolivia', 'Bosnia y Herzegovina', 'Botsuana', 'Brasil',
    'Brun�i', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Camboya', 'Camer�n', 'Canad�', 'Chad', 'Chile',
    'China', 'Chipre', 'Ciudad del Vaticano', 'Colombia', 'Comoras', 'Congo', 'Congo', 'Corea del Norte',
    'Corea del Sur', 'Costa de Marfil', 'Costa Rica', 'Croacia', 'Cuba', 'Dinamarca', 'Dominica', 'Ecuador', 'Egipto',
    'El Salvador', 'Emiratos �rabes Unidos', 'Eritrea', 'Eslovaquia', 'Eslovenia', 'Espa�a',
    'Estados Unidos de Am�rica', 'Estonia', 'Etiop�a', 'Filipinas', 'Finlandia', 'Fiyi', 'Francia', 'Gab�n', 'Gambia',
    'Georgia', 'Ghana', 'Gibraltar', 'Granada', 'Grecia', 'Groenlandia', 'Guadalupe', 'Guam', 'Guatemala',
    'Guayana Francesa', 'Guernsey', 'Guinea', 'Guinea Ecuatorial', 'Guinea-Bissau', 'Guyana', 'Hait�', 'Honduras',
    'Hong kong', 'Hungr�a', 'India', 'Indonesia', 'Ir�n', 'Irak', 'Irlanda', 'Isla Bouvet', 'Isla de Man',
    'Isla de Navidad', 'Isla Norfolk', 'Islandia', 'Islas Bermudas', 'Islas Caim�n', 'Islas Cocos (Keeling)',
    'Islas Cook', 'Islas de �land', 'Islas Feroe', 'Islas Georgias del Sur y Sandwich del Sur',
    'Islas Heard y McDonald', 'Islas Maldivas', 'Islas Malvinas', 'Islas Marianas del Norte', 'Islas Marshall',
    'Islas Pitcairn', 'Islas Salom�n', 'Islas Turcas y Caicos', 'Islas Ultramarinas Menores de Estados Unidos',
    'Islas V�rgenes Brit�nicas', 'Islas V�rgenes de los Estados Unidos', 'Israel', 'Italia', 'Jamaica', 'Jap�n',
    'Jersey', 'Jordania', 'Kazajist�n', 'Kenia', 'Kirgizst�n', 'Kiribati', 'Kuwait', 'L�bano', 'Laos', 'Lesoto',
    'Letonia', 'Liberia', 'Libia', 'Liechtenstein', 'Lituania', 'Luxemburgo', 'M�xico', 'M�naco', 'Macao', 'Maced�nia',
    'Madagascar', 'Malasia', 'Malawi', 'Mali', 'Malta', 'Marruecos', 'Martinica', 'Mauricio', 'Mauritania', 'Mayotte',
    'Micronesia', 'Moldavia', 'Mongolia', 'Montenegro', 'Montserrat', 'Mozambique', 'Namibia', 'Nauru', 'Nepal',
    'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Noruega', 'Nueva Caledonia', 'Nueva Zelanda', 'Om�n', 'Pa�ses Bajos',
    'Pakist�n', 'Palau', 'Palestina', 'Panam�', 'Pap�a Nueva Guinea', 'Paraguay', 'Per�', 'Polinesia Francesa',
    'Polonia', 'Portugal', 'Puerto Rico', 'Qatar', 'Reino Unido', 'Rep�blica Centroafricana', 'Rep�blica Checa',
    'Rep�blica Dominicana', 'Reuni�n', 'Ruanda', 'Ruman�a', 'Rusia', 'Sahara Occidental', 'Samoa', 'Samoa Americana',
    'San Bartolom�', 'San Crist�bal y Nieves', 'San Marino', 'San Mart�n (Francia)', 'San Pedro y Miquel�n',
    'San Vicente y las Granadinas', 'Santa Elena', 'Santa Luc�a', 'Santo Tom� y Pr�ncipe', 'Senegal', 'Serbia',
    'Seychelles', 'Sierra Leona', 'Singapur', 'Siria', 'Somalia', 'Sri lanka', 'Sud�frica', 'Sud�n', 'Suecia', 'Suiza',
    'Surin�m', 'Svalbard y Jan Mayen', 'Swazilandia', 'Tadjikist�n', 'Tailandia', 'Taiw�n', 'Tanzania',
    'Territorio Brit�nico del Oc�ano �ndico', 'Territorios Australes y Ant�rticas Franceses', 'Timor Oriental', 'Togo',
    'Tokelau', 'Tonga', 'Trinidad y Tobago', 'Tunez', 'Turkmenist�n', 'Turqu�a', 'Tuvalu', 'Ucrania', 'Uganda',
    'Uruguay', 'Uzbekist�n', 'Vanuatu', 'Venezuela', 'Vietnam', 'Wallis y Futuna', 'Yemen', 'Yibuti', 'Zambia',
    'Zimbabue');

implementation

end.
