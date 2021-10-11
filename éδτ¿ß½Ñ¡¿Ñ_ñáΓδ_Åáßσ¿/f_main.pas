{
===============================================================================
Code Source : BEAUMONT Christophe
Version     : 1.0.0
Date        : 02 Avril 2010

Micro-projet 08 - Calcul de la date de P�ques selon l'algorithme de OUDIN, son
avantage est d'�tre parmi ceux qui demandent le moins d'op�rations. Il est pr�sent�
sous sa forme non simplifi�e donc utilisable pour toute ann�e post�rieure � 1583
(apr�s l'apparition du calendrier gr�gorien).
Retrouvez ce source et bien d'autres sur mon site : "www.delphinautes.fr"
===============================================================================
}

unit f_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Annee: TEdit;
    LabAnnee: TLabel;
    Box: TPanel;
    procedure AnneeKeyPress(Sender: TObject; var Key: Char);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function Paques(Annee: Integer): TDateTime;
var
 Y,G,C,C_4,E,H,K,P,Q,I,B,J1,J2,R,M: Integer;
begin
 // Y = l'ann�e d�finie
  Y := Annee;
 // Diviser l'ann�e par 19 et garder le reste
 // 2010/19=105 or 105*19=1995 donc l'�cart avec 2010 vaut G=15
  G := Trunc(Y mod 19);
 // C et C_4 permettent le suivi des ann�es bissextiles
  C := Trunc(Y DIV 100);
 // On divise l'ann�e par 100 puis par 4
 // C=2010/100=20 et C_4=20/4=5
  C_4 := Trunc(C DIV 4);
 // Diviser (8*C+13) par 25 , E=8*20+13=173/25=6
  E := Trunc((8 * C + 13) DIV 25);
 // H d�pend de l'�pacte, H=309/30=10 on garde l'�cart donc H=9
  H := Trunc(19 * G + C - C_4 - E + 15) mod 30;
 // K = 9/28 = -0
  K := Trunc(H DIV 28);
 // P = 29/10 = 2
  P := Trunc(29 DIV (H + 1));
 // Q = 21-15 = 6 / 11 = 0
  Q := Trunc((21 - G) DIV 11);
 // I repr�sente le nombre de jours entre la pleine lune pascale et le 21 Mars
  I := Trunc((K * P * Q - 1) * K + H);
 // B = 2010 /4 = 502 + 2010 = 2512
  B := Trunc((Y DIV 4) + Y);
 // J1 = 2508
 J1 := Trunc((B + I + 2 + C_4)- C);
 // Calcule le jour de la lune pascale
 // J2 = 2508/7 = 358 or 358*7 = 2506 donc on garde le reste J = 2
 J2 := Trunc(J1 mod 7);
 // R repr�sente la date du mois de Mars  (R = 35)
  R := Trunc(28 + I - J2);
 // s'il d�passe 31 alors
 if R > 31 then
  begin
 // On d�borde sur Avril
    M := 4;
 // Retrancher 31 pour obtenir la date d'Avril (R = 4)
    R := R - 31;
  end
 // s'il ne d�passe pas 31 alors on est en Mars
 else M := 3;
 // renvoie une valeur de type TDateTime � partir des param�tres Annee, Mois et Jour
  Result := EncodeDate(Annee, M, R);
end;

procedure TForm1.AnneeKeyPress(Sender: TObject; var Key: Char);
var
 DatePaques: TDateTime;
begin
 // Teste si on a appuy� sur la touche "Entr�e"
 if Key = #13
 then
  begin
   // On v�rifie que la date est comprise entre 1583 et 9999 sinon on affiche un message
   if (StrToInt(Annee.Text) < 1583) or (StrToInt(Annee.Text) > 9999) then ShowMessage('Entrez une date entre 1583 et 9999')
   else
   // On calcule la date de P�ques de l'ann�e sp�cifi�e dans une structure TDateTime
   DatePaques := Paques(StrToInt(Annee.Text));
   // Affiche la date de P�ques
   Box.Caption := '����� ���������: '+FormatDateTime('dddddd',DatePaques);
  end;
end;

end.
