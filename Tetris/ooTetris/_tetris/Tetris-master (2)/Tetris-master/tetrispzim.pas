{-------------------------------------------------------------
 Leonardo Pignataro's TETRIS - versão 1.0
 * Incluído para demonstrar os recursos do Pascal ZIM!

 Autor   : Leonardo Pignataro - Beta Tester
 Contato : leopignataro@brturbo.com

 Este código fonte teve de sofrer algumas adaptações para
 torná-lo compatível com o Pascalzim. A versão original
 pode ser encontrada no seguinte URL:
 http://www.geocities.com/leopignataro86/tetris.zip
 -------------------------------------------------------------}

{-------------------------------------------------------------
 Funcionamento geral do programa:
 Basicamente, há um grid, que armazena em memória o estado
 das 'casas' do jogo: quais estão preenchidas, e de que cor.
 Este grid é representado na tela, sendo que cada casa ocupa
 dois caracteres consecutivos, sendo eles caracteres #219.
 Há uma peça caindo no grid (tipo T_Object, variavel obj),
 controlada pelo usuário, e também uma outra fixa ao lado do
 grid (mesmo tipo, variavel next) que indica a próxima peça
 a cair no grid. A velocidade de queda está relacionada com
 o level em que está o jogador.
 Todas essas variáveis - grid, obj, next - entre outras,
 são globais e os módulos (procedures e functions) do progra-
 ma fazem acesso direto a elas. Geralmente, evita-se isso,
 passando variáveis como parâmetros, para que se crie módulos
 portáveis. Contudo, a modularização em prática nesse programa
 não visa portabilidade, visto que são módulos totalmente
 específicos, mas apenas simplificar o programa principal.
 NOTA: o sistema de coordenadas utilizado em todo o programa é
 cartesiano, e *não* segue a lógica de matrizes. Isto é, o ponto
 (1,4) significa x=1 e y=4, logo está na 1a coluna, 4a linha.
 - - - X  -->  (4,1) CORRETO
 - - - -       (1,4) ERRADO
 - - - -
 - - - -
 -------------------------------------------------------------}

program tetris;

uses
  display, math;

const
  HEIGHT        = 20; // Altura do grid (área interna, sem contar as bordas)
  HeightPlusOne = 21; // Altura do grid + 1
  WIDTH         = 11; // Largura do grid (área interna, sem contar as bordas)
  WidthPlusOne  = 12; // Largura do grid + 1

  _LEFT  = - 1; // Identificação dos movimentos horizontais
  _RIGHT = 1;   // (utilizado na chamada ao procedure move)

type

  T_coordinate = record // Coordenada cartesiana (x,y)
    x: integer;
    y: integer;
  end;

  T_objgrid = array[1 .. 4] of array[1 .. 4] of boolean;
  // Forma de peças. Constituida por uma array bidimensional
  // de 4x4 do tipo boolean. Por exemplo, a forma da peça "L"
  // é representada da seguinte maneira:    0 0 1 0
  // 1 1 1 0
  // (0 = FALSE, 1 = TRUE)                  0 0 0 0
  // 0 0 0 0

  T_grid = record    // Informações sobre um ponto do grid, se ele está
    status: boolean; // preenchido ou não (status) e de que cor ele está
    color: integer;  // preenchido, se for o caso.
  end;

  T_object = record    // Peças.
    pos: T_coordinate; // posição
    cell: T_objgrid;   // formato
    size: integer;     // tamanho (ver comentário abaixo)
    color: integer;    // cor
  end;

  {Quanto ao tamanho das peças, existem peças de 4x4 (size=4) e de 3x3 (size=3). No
   caso das de 4x4, o eixo de rotação é bem no meio da array. Exemplo (retângulo):
   |               |               |               |               |
   0 1 0 0   ->    0 0 0 0   ->    0 0 1 0   ->    0 0 0 0   ->    0 1 0 0
   _ 0 1 0 0 _ ->  _ 1 1 1 1 _ ->  _ 0 0 1 0 _ ->  _ 0 0 0 0 _ ->  _ 0 1 0 0 _
   0 1 0 0   ->    0 0 0 0   ->    0 0 1 0   ->    1 1 1 1   ->    0 1 0 0
   0 1 0 0   ->    0 0 0 0   ->    0 0 1 0   ->    0 0 0 0   ->    0 1 0 0
   |               |               |               |               |
   Já nas peças de 3x3, o eixo de rotação é na célula (2,2). Exemplo ("L"):
   |               |               |               |               |
   0 0 0 0   ->    1 0 0 0         1 1 1 0         0 1 1 0         0 0 0 0
   - 0 0 1 0 - ->  - 1 0 0 0 - ->  - 1 0 0 0 - ->  - 0 0 1 0 - ->  - 0 0 1 0 -
   1 1 1 0   ->    1 1 0 0   ->    0 0 0 0   ->    0 0 1 0   ->    1 1 1 0
   0 0 0 0   ->    0 0 0 0         0 0 0 0         0 0 0 0         0 0 0 0
   |               |               |               |               |
   Repare que a estrutura utilizada para representar as formas de 4x4 e de 3x3 é a
   mesma, uma array bidimensional de 4x4. Contudo, nas peças de 3x3, existem 7
   células (as da última coluna e as da úllima linha) que são inutilizadas.}

var

  grid: array[0 .. WidthPlusOne] of array[0 .. HeightPlusOne] of T_grid; // Grid (incluindo bordas)
  obj: T_object; // Peça caindo no grid
  next: T_object; // Próxima peça (fixa)

  level: integer; // Nível em que se encontra o jogador
  score: integer; // Pontuação

  cyclerec: record
     freq: integer; // Intervalo entre decaimentos da peça.
  status: integer;  // Tempo decorrido desde último decaimento.
  _step: integer;   // Tempo entre ciclos de execução. É a cada ciclo o programa
  // checa se o usuário pressionou alguma tecla.
end; // (medidas em milisegundos)

orig:
T_coordinate; // Origem - posição do canto superior esquerdo do grid na tela.
gameover:
boolean; // O jogo acabou?
quit:
boolean; // O usuário deseja sair do jogo?

i, j: integer; // Contadores
c:
char; // Variavel auxiliar (recebe input)

{------------------------------------------------------------------
 Procedure Xclrscr: Fornecidos 4 pontos x1, y1, x2, y2, limpa uma
 área na tela equivalente ao retângulo de vértices superior
 direito = (x1, y1) e inferior esquerdo = (x2, y2).

 Equivale a:     window( x1, y1, x2, y2 );
 clrscr;
 ------------------------------------------------------------------}

procedure Xclrscr(x1, y1, x2, y2: integer);

var
  x, y: integer;

begin
  for y := y1 to y2 do
  begin
    gotoxy(x1, y);
    for x := x1 to x2 do
      write(' ');
  end;
end;

{------------------------------------------------------------------
 Function shock: Verifica se a peça está livre para mover-se
 horizontalmente xmov unidades e verticalmente ymov unidades.
 ------------------------------------------------------------------}

function shock(xmov, ymov: integer): boolean;

var
  i, j: integer;
  return: boolean;

begin
  gotoxy(1, 1);
  return := FALSE;
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (obj.cell[i, j])
         and (obj.pos.x + i + xmov >= 0)
         and (obj.pos.x + i + xmov <= WIDTH + 1)
         and (grid[obj.pos.x + i + xmov, obj.pos.y + j + ymov].status)
      // esta condição precisa aparecer por último!
      then
        return := TRUE;
  result := return;
end;

{------------------------------------------------------------------
 Procedure rotate: Roda a peça no sentido horário, se possível.
 ------------------------------------------------------------------}

procedure rotate;

var
  i, j: integer;
  old: T_objgrid;

begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      old[i, j] := obj.cell[i, j];

  for i := 1 to obj.size do
    for j := 1 to obj.size do
      obj.cell[i, j] := old[j, obj.size + 1 - i];

  if (shock(0, 0)) then
    for i := 1 to 4 do
      for j := 1 to 4 do
        obj.cell[i, j] := old[i, j];
end;

{------------------------------------------------------------------
 Procedure moveit: Move a peça para a direita ou para a esquerda,
 se possível.
 ------------------------------------------------------------------}

procedure moveit(xmov: integer);

begin
  if (not shock(xmov, 0))
  then
    obj.pos.x := obj.pos.x + xmov;
end;

{------------------------------------------------------------------
 Procedure consolidate: Prende a peça ao local onde ela se
 encontra. Após isso, a peça perde seu status de peça e passa a
 ser apenas parte do grid. Este procedimento é chamado quando a
 peça chega ao fundo do grid, ou encontra com outra abaixo dela.
 ------------------------------------------------------------------}

procedure consolidate;

var
  i, j: integer;

begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (obj.cell[i, j]) then
      begin
        grid[obj.pos.x + i, obj.pos.y + j].status := TRUE;
        grid[obj.pos.x + i, obj.pos.y + j].color := obj.color;
      end;
end;

{------------------------------------------------------------------
 Procedure checklines: Checa se alguma linha do grid foi
 completada. Se sim, apaga o conteudo dela, trazendo todas as
 linhas acima para baixo (as linhas que estão acima da que foi
 completada 'caem'). Também recalcula o score, o level e o
 cycle.freq.
 ------------------------------------------------------------------}

procedure checklines;

var
  i, j, down: integer;
  LineCleared: boolean;

begin
  down := 0;

  for j := HEIGHT downto 1 do
  begin
    LineCleared := TRUE;

    for i := 1 to WIDTH do
      if not (grid[i, j].status)
      then
        LineCleared := FALSE;

    if (LineCleared)
    then
    begin
      down := down + 1;
      score := score + 10;
    end
    else
      for i := 1 to WIDTH do
      begin
        grid[i, j + down].status := grid[i, j].status;
        grid[i, j + down].color := grid[i, j].color;
      end;
  end;

  level := score div 200;
  cyclerec.freq := trunc(500 * exp(level * ln(0.85)));
  textcolor(YELLOW);
  gotoxy(orig.x + (WIDTH + 2)* 2 + 18, orig.y + 15);
  write(level);
  gotoxy(orig.x + (WIDTH + 2)* 2 + 30, orig.y + 15);
  write(score);
end;

{------------------------------------------------------------------
 Procedure hideobj: esconde a peça da tela.
 ------------------------------------------------------------------}

procedure hideobj(obj: T_object);

var
  i, j: integer;

begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (obj.cell[i, j]) then
      begin
        gotoxy(orig.x + (obj.pos.x + i) * 2, orig.y + obj.pos.y + j);
        write('  ');
      end;
  gotoxy(orig.x, orig.y);
end;

{------------------------------------------------------------------
 Procedure drawobj: desenha a peça na tela.
 ------------------------------------------------------------------}

procedure drawobj(obj: T_object);

var
  i, j: integer;

begin
  textcolor(obj.color);
  for i := 1 to 4 do
    for j := 1 to 4 do
      if (obj.cell[i, j]) then
      begin
        gotoxy(orig.x + (obj.pos.x + i) * 2, orig.y + obj.pos.y + j);
        write(#219, #219);
      end;
  gotoxy(orig.x, orig.y);
end;

{------------------------------------------------------------------
 Procedure refresh: redesenha todo o grid na tela.
 ------------------------------------------------------------------}

procedure refresh;

var
  i, j: integer;

begin
  for i := 0 to WIDTH + 1 do
    for j := 0 to HEIGHT + 1 do
    begin
      gotoxy(orig.x + 2 * i, orig.y + j);
      if (grid[i, j].status)
      then
      begin
        textcolor(grid[i, j].color);
        write(#219, #219);
      end
      else
        write('  ');
    end;
  gotoxy(orig.x, orig.y);
end;

{------------------------------------------------------------------
 Procedure createtgt: pega a peça já gerada anteriormente que está
 na caixa "next" (variável next) e a transforma na peça atual.
 Depois, gera nova peça randomicamente, posicionando-a na caixa
 "next".
 ------------------------------------------------------------------}

procedure createtgt;

var
  i, j: integer;

begin

  hideobj(next);
  obj := next;

  obj.pos.x := WIDTH div 2 - 2;
  obj.pos.y := 0;

  next.pos.x := WIDTH + 4;
  next.pos.y := 6;

  for i := 1 to 4 do
    for j := 1 to 4 do
      next.cell[i, j] := FALSE;

  case random(7) of
    0:
      begin // Quadrado
        next.cell[2, 2] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[3, 2] := TRUE;
        next.cell[3, 3] := TRUE;
        next.size := 4;
        next.color := WHITE;
      end;
    1:
      begin // Retangulo
        next.cell[2, 1] := TRUE;
        next.cell[2, 2] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[2, 4] := TRUE;
        next.size := 4;
        next.color := LIGHTRED;
      end;
    2:
      begin // "L"
        next.cell[3, 2] := TRUE;
        next.cell[1, 3] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[3, 3] := TRUE;
        next.size := 3;
        next.color := LIGHTGREEN;
      end;
    3:
      begin // "L" invertido
        next.cell[1, 2] := TRUE;
        next.cell[1, 3] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[3, 3] := TRUE;
        next.size := 3;
        next.color := LIGHTBLUE;
      end;
    4:
      begin // "S"
        next.cell[2, 2] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[3, 1] := TRUE;
        next.cell[3, 2] := TRUE;
        next.size := 4;
        next.color := LIGHTCYAN;
      end;
    5:
      begin // "Z"
        next.cell[2, 2] := TRUE;
        next.cell[2, 3] := TRUE;
        next.cell[3, 3] := TRUE;
        next.cell[3, 4] := TRUE;
        next.size := 4;
        next.color := LIGHTMAGENTA;
      end;
    6:
      begin // "T"
        next.cell[1, 2] := TRUE;
        next.cell[2, 1] := TRUE;
        next.cell[2, 2] := TRUE;
        next.cell[2, 3] := TRUE;
        next.size := 3;
        next.color := LIGHTGRAY;
      end;
  end;

  drawobj(next);

end;

{------------------------------------------------------------------
 Procedure prninfo: imprime as informações presentes ao lado
 do grid (contorno da caixa "next" e comandos do jogo).
 ------------------------------------------------------------------}

procedure prninfo(xpos, ypos: integer);

begin

  // window( xpos, ypos, 80, 40 );
  Xclrscr(xpos, ypos, 80, 24);
  textcolor(WHITE);

  gotoxy(xpos, ypos + 0);
  write(#218, #196, #196, ' Next ', #196, #196, #191);
  gotoxy(xpos, ypos + 1);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 2);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 3);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 4);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 5);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 6);
  write(#179, '          ', #179);
  gotoxy(xpos, ypos + 7);
  write(#192, #196, #196, #196, #196, #196, #196, #196, #196, #196, #196, #217);
  textcolor(YELLOW);
  gotoxy(xpos, ypos + 10);
  write('       Level: 0    Score: 0');
  textcolor(WHITE);
  gotoxy(xpos, ypos + 13);
  write('Autor   : Leonardo Pignataro');
  gotoxy(xpos, ypos + 14);
  write('          Pascalzim Beta Tester');
  gotoxy(xpos, ypos + 16);
  write('Contato : secret_doom@hotmail.com');

  // window( xpos+17, ypos+1, 80, 40 );
  gotoxy(xpos + 17, ypos + 1);
  write('Controles:');
  gotoxy(xpos + 17, ypos + 2);
  write('  Mover : [setas]');
  gotoxy(xpos + 17, ypos + 3);
  write('  Girar : [space]');
  gotoxy(xpos + 17, ypos + 4);
  write('  Cair  : [enter]');
  gotoxy(xpos + 17, ypos + 5);
  write('  Pausa : "P"');
  gotoxy(xpos + 17, ypos + 6);
  write('  Sair  : [esc]');
  // window(1,1,80,40);

end;

{------------------------------------------------------------------
 Procedure prnGameover: imprime mensagem de "game over" ao lado
 do grid.
 ------------------------------------------------------------------}

procedure prnGameover(xpos, ypos: integer);

begin

  // window( xpos, ypos, 80, 40 );
  Xclrscr(xpos, ypos, 80, 24);
  textcolor(WHITE);

  gotoxy(xpos, ypos + 2);
  writeln('    * * *   FIM DE JOGO  * * *');
  gotoxy(xpos, ypos + 6);
  write('Deseja iniciar um ');
  textcolor(LIGHTRED);
  write('N');
  textcolor(WHITE);
  write('ovo jogo ou ');
  textcolor(LIGHTRED);
  write('S');
  textcolor(WHITE);
  write('air?');
  // window( 1, 1, 80, 40 );

end;

{------------------------------------------------------------------
 PROGRAMA PRINCIPAL
 ------------------------------------------------------------------}

begin

  randomize;

  orig.x := 2;
  orig.y := 2;

  clrscr;
  gotoxy(orig.x + (WIDTH + 2)* 2 + 5, orig.y + 1);
  textcolor(WHITE);
  write('> > >  Pascalzim Tetris  < < <');

  repeat

    prninfo(orig.x + (WIDTH + 2)* 2 + 4, orig.y + 5);

    for i := 0 to WIDTH + 1 do // Preenche todo o grid (inclusive bordas)
      for j := 0 to HEIGHT + 1 do
      begin
        grid[i, j].status := TRUE;
        grid[i, j].color := DARKGRAY;
      end;

    for i := 1 to WIDTH do    // Esvazia área interna do grid (deixando apenas
      for j := 1 to HEIGHT do // as bordas preenchidas)
        grid[i, j].status := FALSE;

    refresh;

    gameover := FALSE;
    quit := FALSE;
    cyclerec.freq := 500;
    cyclerec._step := 50;
    cyclerec.status := 0;
    score := 0;
    createtgt;
    createtgt;
    refresh;

    while not (gameover or quit) do
    begin

      if (keypressed) then // Se o usuário pressionou uma tecla (keypressed = TRUE),
      begin                // é preciso agir de acordo com o comando correspondente.

        case upcase(readkey) of
          #0:
            case (readkey) of
              #75:
                begin // seta para esquerda
                  hideobj(obj);
                  moveit(_LEFT);
                  drawobj(obj);
                end;
              #77:
                begin // seta para direita
                  hideobj(obj);
                  moveit(_RIGHT);
                  drawobj(obj);
                end;
              #80:
                cyclerec.status := 0; // seta para baixo
            end;
          #13:
            begin // [enter]
              while (not shock(0, 1)) do
                obj.pos.y := obj.pos.y + 1;
              cyclerec.status := 0;
            end;
          #27:
            quit := TRUE; // [esc]
          #32:
            begin // espaço
              hideobj(obj);
              rotate;
              drawobj(obj);
            end;
          'P':
            begin
              textbackground(LIGHTGRAY);
              for i := 1 to WIDTH do
                for j := 1 to HEIGHT do
                begin
                  gotoxy(orig.x + 2 * i, orig.y + j);
                  write('  ');
                end;
              textbackground(BLACK);
              textcolor(LIGHTGRAY);
              gotoxy(orig.x + WIDTH - 2, orig.y + HEIGHT div 2 - 1);
              write('       ');
              gotoxy(orig.x + WIDTH - 2, orig.y + HEIGHT div 2);
              write(' PAUSE ');
              gotoxy(orig.x + WIDTH - 2, orig.y + HEIGHT div 2 + 1);
              write('       ');
              gotoxy(orig.x, orig.y);
              repeat
                c := upcase(readkey);
              until (c = 'P') or (c = #27);
              if (c = #27) then
                quit := TRUE;
              refresh;
              drawobj(obj);
            end;
        end;
      end;

      if (cyclerec.status < cyclerec._step) then // Já está na hora de fazer um decaimento?
      begin                                      // Se sim...
        hideobj(obj);                            // esconde peça
        if (shock(0, 1))
        then
        begin          // Se a peça não pode mover-se para baixo:
          consolidate; // ancora a peça
          checklines;  // checa por linhas completadas
          refresh;     // redesenha todo o grid
          createtgt;   // cria nova peça
          if shock(0, 0) then
            gameover := TRUE;         // caso já não haja espaço no grid para essa nova peça,
        end                           // o jogo está acabado
        else                          // Se a peça pode mover-se para baixo:
          obj.pos.y := obj.pos.y + 1; // move a peça para baixo
        drawobj(obj);                 // desenha peça
      end;

      cyclerec.status := (cyclerec.status + cyclerec._step) mod cyclerec.freq;
      delay(cyclerec._step);

    end;

    if (quit) then
      break;

    prnGameover(orig.x + (WIDTH + 2)* 2 + 4, orig.y + 5);
    repeat
      c := upcase(readkey);
    until (c = 'N') or (c = 'S');

  until (c = 'S');

  clrscr;
  gotoxy(25, 12);
  textcolor(WHITE);
  write('Pressione [ENTER] para sair . . .');

end.
