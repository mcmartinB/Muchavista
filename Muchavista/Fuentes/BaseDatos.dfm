object MBaseDatos: TMBaseDatos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 471
  Width = 648
  object BaseDatos: TDatabase
    DriverName = 'INFORMIX'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 72
    Top = 123
  end
end
