unit cArquivoIni;

interface

uses System.Classes,
     Vcl.Controls,
     Vcl.ExtCtrls,
     Vcl.Dialogs,
     System.SysUtils,
     System.IniFiles,
     Vcl.Forms;

type
  TArquivoIni = class
  private

  public
    class function ArquivoIni:String; static;
    class function LerIni(aSecao:String; aEntrada:String):String; static;
    class procedure AtualizarIni(aSecao, aEntrada, aValor: string); static;
  end;

implementation

{ TArquivoIni }

class function TArquivoIni.ArquivoIni: String;
begin
  result := ChangeFileExt( Application.ExeName, ' .INI' );
end;

class procedure TArquivoIni.AtualizarIni(aSecao, aEntrada, aValor: string);
var Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ArquivoIni);
    Ini.WriteString(aSecao, aEntrada, aValor);
  finally
    Ini.Free;
  end;


end;

class function TArquivoIni.LerIni(aSecao, aEntrada: String): String;
var Ini: TIniFile;
begin
  try
    Ini := TIniFile.Create(ArquivoIni);
    result := Ini.ReadString(aSecao, aEntrada, 'NAO ENCONTRADO');
  finally
  Ini.Free;

  end;

end;

end.
