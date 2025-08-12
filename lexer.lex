/*

    Laboratorio No. 3 - Recursive Descent Parsing
    CC4 - Compiladores

    Lexer para la gramática de la calculadora
*/

import java.io.StringReader;
import java.io.IOException;

%%

%{
    public static void main(String[] args) throws IOException {
        String input = "";
        for (int i = 0; i < args.length; i++) {
            input += args[i];
        }
        Lexer lexer = new Lexer(new StringReader(input));
        Token token;
        while ((token = lexer.nextToken()) != null) {
            System.out.println(token);
        }
    }
%}

%public
%class Lexer
%function nextToken
%type Token

// ===== Definiciones de patrones =====
SEMI   = ";"
PLUS   = "\\+"
MINUS  = "-"
TIMES  = "\\*"
DIV    = "/"
MOD    = "%"
POW    = "\\^"
LPAREN = "\\("
RPAREN = "\\)"
WHITE  = [ \t\r\n]+

// Definición de número (double con opcional signo, decimal y exponente)
DIGIT     = [0-9]
SIGN      = [+-]
NUMBER    = {SIGN}?{DIGIT}+(\.{DIGIT}+)?([eE]{SIGN}?{DIGIT}+)?

%%

// ===== Reglas de tokens =====
<YYINITIAL>{SEMI}   { return new Token(Token.SEMI); }
<YYINITIAL>{PLUS}   { return new Token(Token.PLUS); }
<YYINITIAL>{MINUS}  { return new Token(Token.MINUS); }
<YYINITIAL>{TIMES}  { return new Token(Token.TIMES); }
<YYINITIAL>{DIV}    { return new Token(Token.DIV); }
<YYINITIAL>{MOD}    { return new Token(Token.MOD); }
<YYINITIAL>{POW}    { return new Token(Token.POW); }
<YYINITIAL>{LPAREN} { return new Token(Token.LPAREN); }
<YYINITIAL>{RPAREN} { return new Token(Token.RPAREN); }

<YYINITIAL>{NUMBER} { return new Token(Token.NUMBER, yytext()); }

<YYINITIAL>{WHITE}  { /* Ignorar espacios en blanco */ }

<YYINITIAL>.        { return new Token(Token.ERROR); }

