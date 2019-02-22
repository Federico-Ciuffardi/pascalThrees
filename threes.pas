PROGRAM tarea2_test;
USES crt,sysutils;
CONST
  MAXtablero = 5;
TYPE
  Natural   = 0 .. Maxint;
  TipoColor = (roja, azul, blanca, gris);
  TipoCelda = record case color : TipoColor of
    roja,azul,gris  : ();
    blanca : (exponente : Natural);
    end;
  RangoIndice = 1 .. MAXtablero;
  TipoFila = array [RangoIndice] of TipoCelda;
  Tipotablero = array [RangoIndice] of TipoFila;
  TipoDireccion = (left,right,up,down);
  TipoPosicion = record
    fila, columna : RangoIndice;
    end;
  ListaSumables = ^ nodo;
  nodo = record
    posicion   : TipoPosicion;
    movimiento : TipoDireccion;
    suma       : Natural;
    siguiente  : ListaSumables
    end;
VAR
  i,j,i1,aux1,r1:integer;
  board: Tipotablero;
  bol:boolean;
  imp:char;
  hideHelp:boolean;
  ptg:integer;
PROCEDURE _write_(j1:integer;s:string;j2:integer);
  BEGIN
    case length(s) of
      1:
        BEGIN
        write('  ');
        write(s);
        write('  ')
        END;
      2:
        BEGIN
        write(' ');
        write(s);
        write('  ')
        END;
      3:
        BEGIN
        write(' ');
        write(s);
        write(' ')
        END;
      4:
        BEGIN
        write('');
        write(s);
        write(' ')
        END;
      5:
        BEGIN
        write('');
        write(s);
        write('')
        END;
      END
  END;

function contarcolores(tablero:Tipotablero):integer;
  var
  rcont,acont,res:integer;
  BEGIN
    acont:=0;
    rcont:=0;
    res:=0;
    FOR i := 1 TO MAXtablero DO
      FOR j := 1 TO MAXtablero DO
        case tablero[i,j].color of
        roja:
          rcont:=rcont+1;
        azul:
          acont:=acont+1;
        END;
    IF acont <> rcont THEN
      IF acont > rcont then
        res:=1
      else
        res:=2;
      contarcolores:=res;
    END;
PROCEDURE InsertarRandom(tablero :Tipotablero);
  var
    r:integer;
    bolaux:boolean;
  BEGIN
    repeat
      r:= trunc(random(MAXtablero))+1;
      bolaux:=tablero[r,MAXtablero].color = gris;
      IF bolaux then
      BEGIN
      case contarcolores(tablero) of
      0:case r1 of
          1,2,3:
            board[r,MAXtablero].color:= roja;
          4,5,6:
            board[r,MAXtablero].color:= azul;
          7,8,9:
           BEGIN
           board[r,MAXtablero].color:= blanca;
           board[r,MAXtablero].exponente:=  0;
           END;
          END;
      1:case r1 of
          1,2,3,4,5:
            board[r,MAXtablero].color:= roja;
          6:
            board[r,MAXtablero].color:= azul;
          7,8,9:
           BEGIN
           board[r,MAXtablero].color:= blanca;
           board[r,MAXtablero].exponente:=  0;
           END;
          END;
      2:case r1 of
          1:
            board[r,MAXtablero].color:= roja;
          2,3,4,5,6:
            board[r,MAXtablero].color:= azul;
          7,8,9:
           BEGIN
           board[r,MAXtablero].color:= blanca;
           board[r,MAXtablero].exponente:=  0;
           END;
          END;
      END;
      END;
    until bolaux;
    r1:=trunc(random(9))+1;
  END;
//-----------------TAREA2-------------------------------------------------------------
function potencia(base,exponente:integer):integer;
  BEGIN
    potencia := round(exp(exponente*ln(base)));
  END;

PROCEDURE DISPLAY;
  PROCEDURE dsplay_mid;
    BEGIN
          TextBackground(black);
          textcolor(white);
          write('|');
          case board[i,j].color of
            blanca:
              BEGIN
              TextBackground(white);
              TextColor(black);
              _write_(2,inttostr(3*potencia(2,board[i,j].exponente)),3)
              END;
            gris:
              BEGIN
              TextBackground(darkgray);
              TextColor(black);
              write('  -  ')
              END;
            roja:
              BEGIN
              TextBackground(lightred);
              TextColor(black);
              write('  2  ')
              END;
            azul:
              BEGIN
              TextBackground(cyan);
              TextColor(black);
              write('  1  ')
              END;
            END;
          TextBackground(black);
          textcolor(white);
          write('|')
    END;
  PROCEDURE display_topbot;
    BEGIN
          TextBackground(black);
          textcolor(white);
          write('|');
          case board[i,j].color of
            blanca:
              BEGIN
              TextBackground(white);
              TextColor(black);
              write('     ')
              END;
            gris:
              BEGIN
              TextBackground(darkgray);
              TextColor(black);
              write('     ')
              END;
            roja:
              BEGIN
              TextBackground(lightred);
              TextColor(black);
              write('     ')
              END;
            azul:
              BEGIN
              TextBackground(cyan);
              TextColor(black);
              write('     ')
              END;
            END;
          TextBackground(black);
          textcolor(white);
          write('|')
    END;
  BEGIN
  ClrScr;
    if not hideHelp then BEGIN 
      writeln('Threes');
      writeln('');
      writeln('Movment       : arrows');
      writeln('Hide help     : h     ');
      writeln('Quit          : q     ');
      writeln('')
    END else BEGIN
      writeln('  _______ _                        ');
      writeln(' |__   __| |                       ');
      writeln('    | |  | |__  _ __ ___  ___  ___ ');
      writeln('    | |  | ''_ \| ''__/ _ \/ _ \/ __|');
      writeln('    | |  | | | | | |  __/  __/\__ \');
      writeln('    |_|  |_| |_|_|  \___|\___||___/')
   END;
    for i1:= 1 to 37 - length('Points: ' + inttostr(ptg))do//harcoded lenght
      write(' ');
   writeln('Points: ' + inttostr(ptg));
  FOR i := 1 to MAXtablero do
    BEGIN
    for i1:= 1 to MAXtablero do
      write('-------');
    writeln('--');
    write('|');
      FOR j := 1 to MAXtablero do
        display_topbot;
      writeln('|');
      write('|');
      FOR j := 1 to MAXtablero do
        dsplay_mid;
      writeln('|');
      write('|');
      FOR j := 1 to MAXtablero do
        display_topbot;
      writeln('|');
    END;
  for i1:= 1 to MAXtablero do
    write('-------');
  writeln('--');
  END;//<===================================sacar

PROCEDURE write_until_Keypressed(s:string);
  var aux:string; i:integer;
  BEGIN
  i:=length(s);//no effect set to 1 to enable effect
  repeat
    aux:=s;
    Delete(aux,i,length(s));
    Delay(25);
    DISPLAY;
    write(aux);
    i:=i+1
    until (i > length(s)) or keypressed;
  DISPLAY;
  if not(i > length(s)) then aux:=ReadKey;
  write(s);
  repeat until ReadKey<>char(0);
  DISPLAY
  END;//writes til a ke is presed(excluding esc)

function Puntaje(tablero: Tipotablero) : Natural;
  VAR
    i,j,res:integer;
  BEGIN
    res := 0;
    FOR i := 1 TO MAXtablero DO
      FOR j := 1 TO MAXtablero DO
        IF tablero[i,j].color = blanca THEN
          res:= res + potencia(3,tablero[i,j].exponente+1);
    Puntaje:=res
  END;

procedure DesplazamientoIzquierda(var tablero :Tipotablero; var cambios :boolean);
  BEGIN
    cambios := FALSE;
    FOR i := 1 to MAXtablero do
      FOR j := 1 to MAXtablero do
        case tablero[i,j].color of
          gris:
            IF (j < MAXtablero) AND (tablero[i,j+1].color <> gris) THEN
            BEGIN
              tablero[i,j] := tablero[i,j+1];
              tablero[i,j+1].color := gris;
              cambios := TRUE
            END;
          azul:
            IF (j < MAXtablero) AND (tablero[i,j+1].color = roja) THEN
            BEGIN
              tablero[i,j].color := blanca;
              tablero[i,j].exponente := 0;
              tablero[i,j+1].color := gris;
              cambios := TRUE
            END;
          roja:
            IF (j < MAXtablero) AND (tablero[i,j+1].color = azul) THEN
            BEGIN
              tablero[i,j].color := blanca;
              tablero[i,j].exponente := 0;
              tablero[i,j+1].color := gris;
              cambios := TRUE
            END;
          blanca:
            IF (j < MAXtablero) AND (tablero[i,j+1].color = blanca) AND (tablero[i,j].exponente = tablero[i,j+1].exponente) THEN
            BEGIN
              tablero[i,j].exponente := tablero[i,j].exponente +1;
              tablero[i,j+1].color := gris;
              cambios := TRUE
            END;
        END;
  END;

procedure  SimetriaVertical(var tablero :Tipotablero);
  Var
    aux:tipocelda;
  BEGIN
    FOR i := 1 TO MAXtablero DO
      FOR j := 1 TO MAXtablero div 2 DO
      BEGIN
        aux := tablero[i,j];
        tablero[i,j]:= tablero[i,MAXtablero - j + 1];
        tablero[i,MAXtablero - j + 1] := aux;
      END;
  END;

procedure trasponer(var tablero:Tipotablero);
  VAR
    i,j:integer;
    aux:tipocelda;
  BEGIN
    FOR i := 1 TO MAXtablero DO
      FOR j := 1 TO i -1 DO
      BEGIN
        aux := tablero[i,j];
        tablero[i,j]:= tablero[j,i];
        tablero[j,i] := aux;
      END;
  END;

procedure RotacionDerecha(var tablero :Tipotablero);
  BEGIN
    trasponer(tablero);
    SimetriaVertical(tablero)
  END;

procedure RotacionIzquierda(var tablero :Tipotablero);
  BEGIN
    SimetriaVertical(tablero);
    trasponer(tablero)
  END;

function TerminaJuego(tablero: Tipotablero) :Boolean;
  VAR
    res:boolean;
  BEGIN
    res:=TRUE;
    j:=1;
    i:=1;
    WHILE (i<=MAXtablero) AND res DO
    BEGIN
      WHILE (j<=MAXtablero) AND res DO
      BEGIN
        case tablero[i,j].color of
         gris:
          res := FALSE;
         azul:
            res:=Not( ((j < MAXtablero) AND (tablero[i,j+1].color = roja)) OR ((i < MAXtablero) AND (tablero[i+1,j].color = roja)) );
         roja:
            res:=Not( ((j < MAXtablero) AND (tablero[i,j+1].color = azul)) OR ((i < MAXtablero) AND (tablero[i+1,j].color = azul)) );
         blanca:
            res:=Not( ((j < MAXtablero) AND (tablero[i,j+1].color = blanca) AND (tablero[i,j+1].exponente = tablero[i,j].exponente)) OR ((i < MAXtablero) AND (tablero[i+1,j].color = blanca) AND (tablero[i+1,j].exponente = tablero[i,j].exponente)) );
        END;
        j:= j + 1
      END;
      j := 1 ;
      i := i + 1
    END;
    TerminaJuego:=res
  END;

function PosiblesSumas(tablero : TipoTablero) :ListaSumables;
  VAR
    upb,downb,leftb,rightb:boolean;
    res:ListaSumables;
  procedure agregar(var lis: ListaSumables; x,y: RangoIndice;dir: TipoDireccion;sum :Natural;var bol :boolean);
    var
    aux : ListaSumables;
    BEGIN
      bol:=FALSE;
      new(aux);
      aux^.posicion.fila := x;
      aux^.posicion.columna := y;
      aux^.movimiento := dir;
      aux^.suma := sum;
      aux^.siguiente:= lis;
      lis:= aux;
    END;
  BEGIN
    res:=nil;
    FOR i := 1 to MAXtablero do
    BEGIN
    upb:=TRUE;
    downb:= TRUE;
    leftb:=TRUE;
    rightb:=TRUE;
    j := 1;
    while leftb AND (j <= MAXtablero) do
    BEGIN
      case tablero[i,j].color of//left
       gris:
          leftb:= FALSE;
       azul:
          IF (j < MAXtablero) AND (tablero[i,j+1].color = roja) AND leftb THEN agregar(res,i,j,left,3,leftb);
       roja:
          IF (j < MAXtablero) AND (tablero[i,j+1].color = azul) AND leftb THEN agregar(res,i,j,left,3,leftb);
       blanca:
          IF (j < MAXtablero) AND (tablero[i,j+1].color = blanca) AND (tablero[i,j+1].exponente=tablero[i,j].exponente) AND leftb THEN
            agregar(res,i,j,left,3*potencia(2,tablero[i,j].exponente+1),leftb);
      END;
      j:= j+1
    END;
    j:= 1;
    while upb AND (j <= MAXtablero) do
    BEGIN
      case tablero[j,i].color of//up
       gris:
          upb:= FALSE;
       azul:
          IF (j < MAXtablero) AND (tablero[j+1,i].color = roja) AND upb  THEN agregar(res,j,i,up,3,upb);
       roja:
          IF (j < MAXtablero) AND (tablero[j+1,i].color = azul) AND upb  THEN agregar(res,j,i,up,3,upb);
       blanca:
          IF (j < MAXtablero) AND (tablero[j+1,i].color = blanca) AND (tablero[j+1,i].exponente=tablero[j,i].exponente) AND upb THEN
            agregar(res,j,i,up,3*potencia(2,tablero[j,i].exponente+1),upb);
      END;
      j:=j+1;
    END;
    j:= 1;
    while rightb AND (j <= MAXtablero) do
    BEGIN
      case tablero[i,MAXtablero-j+1].color of//right
       gris:
          rightb:= FALSE;
       azul:
          IF (j < MAXtablero) AND (tablero[i,MAXtablero-j].color = roja) AND rightb THEN agregar(res,i,MAXtablero-j+1,right,3,rightb);
       roja:
          IF (j < MAXtablero) AND (tablero[i,MAXtablero-j].color = azul) AND rightb THEN agregar(res,i,MAXtablero-j+1,right,3,rightb);
       blanca:
          IF (j < MAXtablero) AND (tablero[i,MAXtablero-j].color = blanca) AND (tablero[i,MAXtablero-j].exponente=tablero[i,MAXtablero-j+1].exponente) AND rightb THEN
            agregar(res,i,MAXtablero-j+1,right,3*potencia(2,tablero[i,MAXtablero-j+1].exponente+1),rightb);
      END;
      j:= j+ 1
    END;
    j:= 1;
    while downb AND (j <= MAXtablero) do
    BEGIN
      case tablero[MAXtablero-j+1,i].color of//down
       gris:
          downb:= FALSE;
       azul:
          IF (j < MAXtablero) AND (tablero[MAXtablero-j,i].color = roja) AND downb  THEN agregar(res,MAXtablero-j+1,i,down,3,downb);
       roja:
          IF (j < MAXtablero) AND (tablero[MAXtablero-j,i].color = azul) AND downb  THEN agregar(res,MAXtablero-j+1,i,down,3,downb);
       blanca:
          IF (j < MAXtablero) AND (tablero[MAXtablero-j,i].color = blanca) AND (tablero[MAXtablero-j,i].exponente = tablero[MAXtablero-j+1,i].exponente) AND downb THEN
            agregar(res,MAXtablero-j+1,i,down,3*potencia(2,tablero[MAXtablero-j+1,i].exponente+1),downb);
      END;
      j:= j+1
    END;
  END;
  PosiblesSumas:=res;
  END;

function  ObtenerCeldaPosicion(k : Natural; lista :ListaSumables) :ListaSumables;
  var
    i:integer;
    res:ListaSumables;
  BEGIN
    i := 0;
    res:=nil;
    while (lista <> nil) AND (i<k)  do
    BEGIN
      i:=i+1;
      lista:= lista^.siguiente;
    END;
    IF i>=k then
      BEGIN
      res := lista;
      END;
    ObtenerCeldaPosicion:=res;
  END;
//---------------------------------------------------------------------------------------
PROCEDURE escribir(lis:ListaSumables);
  BEGIN
  writeln;
  writeln;
  writeln('  Position  |  Movment  |  Value   ');
  while lis <> nil do
  BEGIN
    if lis^.movimiento = right then
      writeln('   (',lis^.posicion.fila,', ',lis^.posicion.columna,')   |    ',lis^.movimiento,'  |    ',lis^.suma)
    else if lis^.movimiento = up then
      writeln('   (',lis^.posicion.fila,', ',lis^.posicion.columna,')   |    ',lis^.movimiento,'     |    ',lis^.suma)
    else
      writeln('   (',lis^.posicion.fila,', ',lis^.posicion.columna,')   |    ',lis^.movimiento,'   |    ',lis^.suma);
    lis:= lis^.siguiente;
  END
END;

BEGIN
ptg := 0;
hideHelp := false;
RANDOMIZE;
lowvideo;
FOR i := 1 to MAXtablero do
  FOR j := 1 to MAXtablero do
  BEGIN
    aux1:=trunc(random(10))+1;
    case aux1 of
    1,5,6,7,8,9,10:
      board[i,j].color:= gris;
    2:
      board[i,j].color:= roja;
    3:
      board[i,j].color:= azul;
    4:
     BEGIN
     board[i,j].color:= blanca;
     board[i,j].exponente:=  0;
     END;
    else
      BEGIN
      board[i,j].color:= blanca;
      board[i,j].exponente:=  1;
      END;
    END
  END;
r1:=trunc(random(9))+1;
DISPLAY;
REPEAT
      case contarcolores(board) of
      0:case r1 of
          1,2,3:
            write('RED incoming!');
          4,5,6:
            write('BLUE incoming!');
          7,8,9:
            write('WHITE incoming!');
          END;
      1:case r1 of
          1,2,3,4,5:
            write('RED incoming!');
          6:
            write('BLUE incoming!');
          7,8,9:
           write('WHITE incoming!');
          END;
      2:case r1 of
          1:
            write('RED incoming!');
          2,3,4,5,6:
            write('BLUE incoming!');
          7,8,9:
           write('WHITE incoming!');
          END;
      END;
  imp:=ReadKey;
  case imp of
    #0:
      case ReadKey of
        #72:
          BEGIN
          RotacionIzquierda(board);
          DesplazamientoIzquierda(board,bol);
          IF bol = TRUE then InsertarRandom(board);
          RotacionDerecha(board);
          IF bol = FALSE then write_until_Keypressed('Cant''t move up.')
          END;
        #75:
          BEGIN
          DesplazamientoIzquierda(board,bol);
          IF bol = TRUE then InsertarRandom(board);
          IF bol = FALSE then write_until_Keypressed('Cant''t move left.')
          END;
        #77:
          BEGIN
          SimetriaVertical(board);
          DesplazamientoIzquierda(board,bol);
          IF bol = TRUE then InsertarRandom(board);
          SimetriaVertical(board);
          IF bol = FALSE then write_until_Keypressed('Cant''t move right.')
          END;
        #80:
          BEGIN
          RotacionDerecha(board);
          DesplazamientoIzquierda(board,bol);
          IF bol = TRUE then InsertarRandom(board);
          RotacionIzquierda(board);
          IF bol = FALSE then write_until_Keypressed('Cant''t move down.')
          END;
      END;
    (*'h':
      BEGIN
        escribir(PosiblesSumas(board));
        repeat until keypressed;
      END;*)
    'h':
      BEGIN
        hideHelp := not hideHelp;
      END;
    (*'p':
      BEGIN
        write_until_Keypressed('Points: ' + inttostr(puntaje(board)));
        repeat until keypressed;
      END;*)
    'q':;
    else
      write_until_Keypressed('Invalid instruction.');
    END;
  ptg := puntaje(board);
  DISPLAY
  until (imp = 'q') OR TerminaJuego(board);
DISPLAY;
writeln;
write_until_Keypressed('Points: ' + inttostr(puntaje(board)));
writeln('Points: ' + inttostr(puntaje(board)))
END.
