object dtmPrincipal: TdtmPrincipal
  OldCreateOrder = True
  Height = 173
  Width = 242
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    Properties.Strings = (
      'RawStringEncoding=DB_CP')
    TransactIsolationLevel = tiReadCommitted
    Connected = True
    HostName = '.\SQLEXPRESS'
    Port = 1433
    Database = 'loja'
    User = ''
    Password = ''
    Protocol = 'mssql'
    LibraryLocation = 'C:\Projetos\backup_04_03\backup_04_03\ntwdblib.dll'
    Left = 109
    Top = 72
  end
end
