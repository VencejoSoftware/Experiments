unit IfTest;

interface

function CountryNameByCode(const Code: String): String;
function CountryCodeByName(const Name: String): String;

implementation

function CountryNameByCode(const Code: String): String;
begin
  if Code = '00019' then
    Result := 'BERKLEY ART'
  else if Code = '00027' then
    Result := 'PREVENCION'
  else if Code = '00035' then
    Result := 'LA CAJA'
  else if Code = '00051' then
    Result := 'PROVINCIA'
  else if Code = '00060' then
    Result := 'LA SEGUNDA'
  else if Code = '00086' then
    Result := 'INTERACCION'
  else if Code = '00094' then
    Result := 'FED. PATRONAL'
  else if Code = '00140' then
    Result := 'PROD. DE FRUTAS'
  else

    if Code = '00183' then
    Result := 'LA HOLANDO'
  else if Code = '00221' then
    Result := 'QBE ARGENTINA'
  else if Code = '00248' then
    Result := 'VICTORIA'
  else if Code = '00264' then
    Result := 'MAPFRE'
  else if Code = '00272' then
    Result := 'CONSOLIDAR'
  else if Code = '00280' then
    Result := 'LIBERTY'
  else if Code = '00310' then
    Result := 'INST. AUTARQ. E.R.'
  else

    if Code = '00396' then
    Result := 'ASOCIART'
  else // aca hay un problema ASOCIART no coincide con aar_art
    // if Code = '00396' then Result := 'GALENO ART' else

    if Code = '00418' then
      Result := 'HORIZONTE'
    else if Code = '00426' then
      Result := 'CAJA POPULAR'
    else if Code = '00450' then
      Result := 'LATITUD SUR'
    else if Code = '00469' then
      Result := 'RECONQUISTA'
    else if Code = '00477' then
      Result := 'SMG ART'
    else if Code = '00485' then
      Result := 'LIDERAR ART'
    else if Code = '00493' then
      Result := 'CAMINOS PROTEGIDOS'
    else if Code = '10014' then
      Result := 'SHELL'
    else

      if Code = '10022' then
      Result := 'AXION'
    else if Code = '50016' then
      Result := 'BANCO CIUDAD'
    else if Code = '50024' then
      Result := 'S. ESTERO'
    else if Code = '50032' then
      Result := 'M. ROSARIO'
    else if Code = '50040' then
      Result := 'GOB PCIA. BS. AS.'
    else

      // ** Aseguradoras que no estan en el XML oficial
      if Code = '00043' then
        Result := 'INCA'
      else if Code = '00116' then
        Result := 'BOSTON'
      else if Code = '00108' then
        Result := 'LA IBERO PLATENSE'
      else if Code = '00124' then
        Result := 'ITALO'
      else if Code = '00132' then
        Result := 'JUNCAL'
      else // Este puede ser LA ESTRELLA tambien
        if Code = '00159' then
          Result := 'LA REPUBLICA'
        else if Code = '00167' then
          Result := 'BERKLEY SEGUROS'
        else if Code = '00175' then
          Result := 'LA URUGUAYA'
        else if Code = '00183' then
          Result := 'LA HOLANDO'
        else if Code = '00191' then
          Result := 'LA CONSTRUCCION'
        else if Code = '00205' then
          Result := 'GENERALI'
        else if Code = '00213' then
          Result := 'SUL AMERICA'
        else if Code = '00230' then
          Result := 'RESP. PATRONAL'
        else if Code = '00256' then
          Result := 'LA MERIDIONAL'
        else if Code = '00302' then
          Result := 'LA BUENOS AIRES'
        else if Code = '00337' then
          Result := 'ESPAÑA y R. PLATA'
        else if Code = '00345' then
          Result := 'SOLART'
        else if Code = '00361' then
          Result := 'COPAN'
        else if Code = '00370' then
          Result := 'LA CONFIANZA'
        else if Code = '00388' then
          Result := 'QBE'
        else if Code = '00400' then
          Result := 'NATIVA'
        else if Code = '00434' then
          Result := 'CENIT'
        else if Code = '00442' then
          Result := 'LUZ'
        else if Code = '00481' then
          Result := 'LATITUD SUR'

end;

function CountryCodeByName(const Name: String): String;
begin
  if Name = 'BERKLEY ART' then
    Result := '00019'
  else if Name = 'PREVENCION' then
    Result := '00027'
  else if Name = 'LA CAJA' then
    Result := '00035'
  else if Name = 'PROVINCIA' then
    Result := '00051'
  else if Name = 'LA SEGUNDA' then
    Result := '00060'
  else if Name = 'INTERACCION' then
    Result := '00086'
  else if Name = 'FED. PATRONAL' then
    Result := '00094'
  else if Name = 'PROD. DE FRUTAS' then
    Result := '00140'
  else

    if Name = 'LA HOLANDO' then
    Result := '00183'
  else if Name = 'QBE ARGENTINA' then
    Result := '00221'
  else if Name = 'VICTORIA' then
    Result := '00248'
  else if Name = 'MAPFRE' then
    Result := '00264'
  else if Name = 'CONSOLIDAR' then
    Result := '00272'
  else if Name = 'LIBERTY' then
    Result := '00280'
  else if Name = 'INST. AUTARQ. E.R.' then
    Result := '00310'
  else

    if Name = 'ASOCIART' then
    Result := '00396'
  else // estas son las mismas
    if Name = 'GALENO ART' then
      Result := '00396'
    else

      if Name = 'HORIZONTE' then
      Result := '00418'
    else if Name = 'CAJA POPULAR' then
      Result := '00426'
    else if Name = 'LATITUD SUR' then
      Result := '00450'
    else if Name = 'RECONQUISTA' then
      Result := '00469'
    else if Name = 'SMG ART' then
      Result := '00477'
    else if Name = 'LIDERAR ART' then
      Result := '00485'
    else if Name = 'CAMINOS PROTEGIDOS' then
      Result := '00493'
    else if Name = 'SHELL' then
      Result := '10014'
    else

      if Name = 'AXION' then
      Result := '10022'
    else if Name = 'BANCO CIUDAD' then
      Result := '50016'
    else if Name = 'S. ESTERO' then
      Result := '50024'
    else if Name = 'M. ROSARIO' then
      Result := '50032'
    else if Name = 'GOB PCIA. BS. AS.' then
      Result := '50040'
    else

      // ** Aseguradoras que no estan en el XML oficial
      if Name = 'INCA' then
        Result := '00043'
      else if Name = 'BOSTON' then
        Result := '00116'
      else if Name = 'LA IBERO PLATENSE' then
        Result := '00108'
      else if Name = 'ITALO' then
        Result := '00124'
      else if Name = 'JUNCAL' then
        Result := '00132'
      else // Este puede ser LA ESTRELLA tambien
        if Name = 'COMPAÑÍA ARGENTINA DE SEGUROS LA ESTRELLA S.A.' then
          Result := '00132'
        else

          if Name = 'LA REPUBLICA' then
          Result := '00159'
        else if Name = 'BERKLEY SEGUROS' then
          Result := '00167'
        else if Name = 'LA URUGUAYA' then
          Result := '00175'
        else if Name = 'LA HOLANDO' then
          Result := '00183'
        else if Name = 'LA CONSTRUCCION' then
          Result := '00191'
        else if Name = 'GENERALI' then
          Result := '00205'
        else if Name = 'SUL AMERICA' then
          Result := '00213'
        else if Name = 'RESP. PATRONAL' then
          Result := '00230'
        else if Name = 'LA MERIDIONAL' then
          Result := '00256'
        else if Name = 'LA BUENOS AIRES' then
          Result := '00302'
        else if Name = 'ESPAÑA y R. PLATA' then
          Result := '00337'
        else if Name = 'SOLART' then
          Result := '00345'
        else if Name = 'COPAN' then
          Result := '00361'
        else if Name = 'LA CONFIANZA' then
          Result := '00370'
        else if Name = 'QBE' then
          Result := '00388'
        else if Name = 'NATIVA' then
          Result := '00400'
        else if Name = 'CENIT' then
          Result := '00434'
        else if Name = 'LUZ' then
          Result := '00442'
        else if Name = 'LATITUD SUR' then
          Result := '00481'
        else
          //
          // Las que no se de donde salieron
          // ** CNA ART?
          if Name = 'CNA ART' then
            Result := '00388'
            // else // CNA fue comprada por QBE asi que los registros viejos tendran ese codigo
            // if Result = '' then
            // Result := ValorSqlEx
            // ('SELECT ar_codigosrt FROM afi.aar_art WHERE ar_artweb =:codigo',
            // [Name], '');
end;

end.
