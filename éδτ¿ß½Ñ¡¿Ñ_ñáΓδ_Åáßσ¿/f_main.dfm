object Form1: TForm1
  Left = 302
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077' '#1076#1072#1090#1099' '#1055#1072#1089#1093#1080
  ClientHeight = 105
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 120
  TextHeight = 17
  object LabAnnee: TLabel
    Left = 8
    Top = 16
    Width = 69
    Height = 17
    Caption = 'Enter Year:'
  end
  object Annee: TEdit
    Left = 88
    Top = 8
    Width = 113
    Height = 25
    TabOrder = 0
    Text = '2010'
    OnKeyPress = AnneeKeyPress
  end
  object Box: TPanel
    Left = 8
    Top = 40
    Width = 265
    Height = 57
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
  end
end
