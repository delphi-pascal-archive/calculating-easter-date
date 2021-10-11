{
===============================================================================
Code Source : BEAUMONT Christophe
Version     : 1.0.0
Date        : 02 Avril 2010

Micro-projet 08 - Calcul de la date de Pâques selon l'algorithme de OUDIN, son
avantage est d'être parmi ceux qui demandent le moins d'opérations. Il est présenté
sous sa forme non simplifiée donc utilisable pour toute année postérieure à 1583
(après l'apparition du calendrier grégorien).
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
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function Paques(Annee: Integer): TDateTime;
var
 Y,G,C,C_4,E,H,K,P,Q,I,B,J1,J2,R,M: Integer;
begin
 // Y = l'année définie
  Y := Annee;
 // Diviser l'année par 19 et garder le reste
 // 2010/19=105 or 105*19=1995 donc l'écart avec 2010 vaut G=15
  G := Trunc(Y mod 19);
 // C et C_4 permettent le suivi des années bissextiles
  C := Trunc(Y DIV 100);
 // On divise l'année par 100 puis par 4
 // C=2010/100=20 et C_4=20/4=5
  C_4 := Trunc(C DIV 4);
 // Diviser (8*C+13) par 25 , E=8*20+13=173/25=6
  E := Trunc((8 * C + 13) DIV 25);
 // H dépend de l'épacte, H=309/30=10 on garde l'écart donc H=9
  H := Trunc(19 * G + C - C_4 - E + 15) mod 30;
 // K = 9/28 = -0
  K := Trunc(H DIV 28);
 // P = 29/10 = 2
  P := Trunc(29 DIV (H + 1));
 // Q = 21-15 = 6 / 11 = 0
  Q := Trunc((21 - G) DIV 11);
 // I représente le nombre de jours entre la pleine lune pascale et le 21 Mars
  I := Trunc((K * P * Q - 1) * K + H);
 // B = 2010 /4 = 502 + 2010 = 2512
  B := Trunc((Y DIV 4) + Y);
 // J1 = 2508
 J1 := Trunc((B + I + 2 + C_4)- C);
 // Calcule le jour de la lune pascale
 // J2 = 2508/7 = 358 or 358*7 = 2506 donc on garde le reste J = 2
 J2 := Trunc(J1 mod 7);
 // R représente la date du mois de Mars  (R = 35)
  R := Trunc(28 + I - J2);
 // s'il dépasse 31 alors
 if R > 31 then
  begin
 // On déborde sur Avril
    M := 4;
 // Retrancher 31 pour obtenir la date d'Avril (R = 4)
    R := R - 31;
  end
 // s'il ne dépasse pas 31 alors on est en Mars
 else M := 3;
 // renvoie une valeur de type TDateTime à partir des paramètres Annee, Mois et Jour
  Result := EncodeDate(Annee, M, R);
end;

procedure TForm1.AnneeKeyPress(Sender: TObject; var Key: Char);
var
 DatePaques: TDateTime;
begin
 // Teste si on a appuyé sur la touche "Entrée"
 if Key = #13
 then
  begin
   // On vérifie que la date est comprise entre 1583 et 9999 sinon on affiche un message
   if (StrToInt(Annee.Text) < 1583) or (StrToInt(Annee.Text) > 9999) then ShowMessage('Entrez une date entre 1583 et 9999')
   else
   // On calcule la date de Pâques de l'année spécifiée dans une structure TDateTime
   DatePaques := Paques(StrToInt(Annee.Text));
   // Affiche la date de Pâques
   Box.Caption := 'Ïàñõà ñîñòîèòñÿ: '+FormatDateTime('dddddd',DatePaques);
  end;
end;

end.
