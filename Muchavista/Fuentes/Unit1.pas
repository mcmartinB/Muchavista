unit Unit1;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls;

type
  TQuickReport1 = class(TQuickRep)
    c: TQRBand;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRMemo1: TQRMemo;
    QRMemo3: TQRMemo;
    QRMemo4: TQRMemo;
    QRMemo5: TQRMemo;
    TotalImporte: TQRLabel;
    QRLabel2: TQRLabel;
  private

  public

  end;

var
  QuickReport1: TQuickReport1;

implementation

{$R *.DFM}

end.
