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
  COUNTRY_NAME: array [0 .. COUNTRY_COUNT] of string = ('Afganistán', 'Albania', 'Alemania', 'Algeria', 'Andorra',
    'Angola', 'Anguila', 'Antártida', 'Antigua y Barbuda', 'Antillas Neerlandesas', 'Arabia Saudita', 'Argentina',
    'Armenia', 'Aruba', 'Australia', 'Austria', 'Azerbayán', 'Bélgica', 'Bahamas', 'Bahrein', 'Bangladesh', 'Barbados',
    'Belice', 'Benín', 'Bhután', 'Bielorrusia', 'Birmania', 'Bolivia', 'Bosnia y Herzegovina', 'Botsuana', 'Brasil',
    'Brunéi', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Camboya', 'Camerún', 'Canadá', 'Chad', 'Chile',
    'China', 'Chipre', 'Ciudad del Vaticano', 'Colombia', 'Comoras', 'Congo', 'Congo', 'Corea del Norte',
    'Corea del Sur', 'Costa de Marfil', 'Costa Rica', 'Croacia', 'Cuba', 'Dinamarca', 'Dominica', 'Ecuador', 'Egipto',
    'El Salvador', 'Emiratos Árabes Unidos', 'Eritrea', 'Eslovaquia', 'Eslovenia', 'España',
    'Estados Unidos de América', 'Estonia', 'Etiopía', 'Filipinas', 'Finlandia', 'Fiyi', 'Francia', 'Gabón', 'Gambia',
    'Georgia', 'Ghana', 'Gibraltar', 'Granada', 'Grecia', 'Groenlandia', 'Guadalupe', 'Guam', 'Guatemala',
    'Guayana Francesa', 'Guernsey', 'Guinea', 'Guinea Ecuatorial', 'Guinea-Bissau', 'Guyana', 'Haití', 'Honduras',
    'Hong kong', 'Hungría', 'India', 'Indonesia', 'Irán', 'Irak', 'Irlanda', 'Isla Bouvet', 'Isla de Man',
    'Isla de Navidad', 'Isla Norfolk', 'Islandia', 'Islas Bermudas', 'Islas Caimán', 'Islas Cocos (Keeling)',
    'Islas Cook', 'Islas de Åland', 'Islas Feroe', 'Islas Georgias del Sur y Sandwich del Sur',
    'Islas Heard y McDonald', 'Islas Maldivas', 'Islas Malvinas', 'Islas Marianas del Norte', 'Islas Marshall',
    'Islas Pitcairn', 'Islas Salomón', 'Islas Turcas y Caicos', 'Islas Ultramarinas Menores de Estados Unidos',
    'Islas Vírgenes Británicas', 'Islas Vírgenes de los Estados Unidos', 'Israel', 'Italia', 'Jamaica', 'Japón',
    'Jersey', 'Jordania', 'Kazajistán', 'Kenia', 'Kirgizstán', 'Kiribati', 'Kuwait', 'Líbano', 'Laos', 'Lesoto',
    'Letonia', 'Liberia', 'Libia', 'Liechtenstein', 'Lituania', 'Luxemburgo', 'México', 'Mónaco', 'Macao', 'Macedônia',
    'Madagascar', 'Malasia', 'Malawi', 'Mali', 'Malta', 'Marruecos', 'Martinica', 'Mauricio', 'Mauritania', 'Mayotte',
    'Micronesia', 'Moldavia', 'Mongolia', 'Montenegro', 'Montserrat', 'Mozambique', 'Namibia', 'Nauru', 'Nepal',
    'Nicaragua', 'Niger', 'Nigeria', 'Niue', 'Noruega', 'Nueva Caledonia', 'Nueva Zelanda', 'Omán', 'Países Bajos',
    'Pakistán', 'Palau', 'Palestina', 'Panamá', 'Papúa Nueva Guinea', 'Paraguay', 'Perú', 'Polinesia Francesa',
    'Polonia', 'Portugal', 'Puerto Rico', 'Qatar', 'Reino Unido', 'República Centroafricana', 'República Checa',
    'República Dominicana', 'Reunión', 'Ruanda', 'Rumanía', 'Rusia', 'Sahara Occidental', 'Samoa', 'Samoa Americana',
    'San Bartolomé', 'San Cristóbal y Nieves', 'San Marino', 'San Martín (Francia)', 'San Pedro y Miquelón',
    'San Vicente y las Granadinas', 'Santa Elena', 'Santa Lucía', 'Santo Tomé y Príncipe', 'Senegal', 'Serbia',
    'Seychelles', 'Sierra Leona', 'Singapur', 'Siria', 'Somalia', 'Sri lanka', 'Sudáfrica', 'Sudán', 'Suecia', 'Suiza',
    'Surinám', 'Svalbard y Jan Mayen', 'Swazilandia', 'Tadjikistán', 'Tailandia', 'Taiwán', 'Tanzania',
    'Territorio Británico del Océano Índico', 'Territorios Australes y Antárticas Franceses', 'Timor Oriental', 'Togo',
    'Tokelau', 'Tonga', 'Trinidad y Tobago', 'Tunez', 'Turkmenistán', 'Turquía', 'Tuvalu', 'Ucrania', 'Uganda',
    'Uruguay', 'Uzbekistán', 'Vanuatu', 'Venezuela', 'Vietnam', 'Wallis y Futuna', 'Yemen', 'Yibuti', 'Zambia',
    'Zimbabue');

implementation

end.
