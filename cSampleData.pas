unit cSampleData;

interface

uses Generics.Collections, xn.grid.link;

type
  TSampleData = class
  private
    const
    TABLE_20: array [0 .. 19, 0 .. 5] of string = (
      ('0', 'Aqua', 'MD', '2,01', '71', 'T'),
      ('2', 'Yellow', 'LA', '3,76', '29', 'T'),
      ('4', 'DkGray', 'VT', '4,74', '47', 'T'),
      ('6', 'Teal', 'NE', '2,06', '6', 'F'),
      ('8', 'Red', 'LA', '2,82', '80', 'F'),
      ('10', 'Black', 'OH', '2,06', '6', 'T'),
      ('12', 'Lime', 'HI', '2,82', '32', 'F'),
      ('14', 'White', 'UT', '2,9', '75', 'T'),
      ('16', 'Lime', 'VT', '3,17', '75', 'F'),
      ('18', 'Olive', 'VA', '3,17', '88', 'F'),
      ('20', 'Gray', 'PA', '1,53', '25', 'F'),
      ('22', 'Red', 'WA', '2,82', '34', 'F'),
      ('24', 'White', 'RI', '4,04', '29', 'T'),
      ('26', 'Purple', 'MS', '3,17', '70', 'T'),
      ('28', 'Fuchsia', 'ND', '3,6', '77', 'F'),
      ('30', 'Silver', 'AR', '3,76', '25', 'F'),
      ('32', 'Maroon', 'MT', '3,94', '88', 'T'),
      ('34', 'LtGray', 'AZ', '3,94', '10', 'F'),
      ('36', 'Silver', 'NY', '3,76', '8', 'F'),
      ('38', 'Purple', 'HI', '2,56', '68', 'F'));

  public
    class function RowCount: LongInt;
    class function Value(aCol, aRow: integer): string;
  end;

  TSampleGridData = class(TInterfacedObject, IxnGridData)
  public
    procedure Clear;
    procedure Fill;
    function RowCount: LongInt;
    function AsDebug: string;
    function ValueString(aCol, aRow: LongInt): String;
    function ValueFloat(aCol, aRow: LongInt): Double;
  end;

  TSampleGridData2By2 = class(TInterfacedObject, IxnGridData)
  private
    fItems: TList<integer>;
    procedure InnerFill(aCount: integer); virtual;
    procedure Rand; virtual;
  public
    constructor Create(aCount: integer); virtual;
    destructor Destroy; override;
    procedure Clear;
    procedure Fill;
    function RowCount: LongInt; virtual;
    function AsDebug: string; virtual;
    function ValueString(aCol, aRow: LongInt): String; virtual;
    function ValueFloat(aCol, aRow: LongInt): Double; virtual;
  end;

  TSampleGridDataRandom = class(TSampleGridData2By2)
  private
    procedure InnerFill(aCount: integer); override;
  end;

implementation

uses System.Math, System.SysUtils;

{ TABLE_20
  0;Aqua;MD;2,01;71;T
  2;Yellow;LA;3,76;29;T
  4;DkGray;VT;4,74;47;T
  6;Teal;NE;2,06;6;F
  8;Red;LA;2,82;80;F
  10;Black;OH;2,06;6;T
  12;Lime;HI;2,82;32;F
  14;White;UT;2,9;75;T
  16;Lime;VT;3,17;75;F
  18;Olive;VA;3,17;88;F
  20;Gray;PA;1,53;25;F
  22;Red;WA;2,82;34;F
  24;White;RI;4,04;29;T
  26;Purple;MS;3,17;70;T
  28;Fuchsia;ND;3,6;77;F
  30;Silver;AR;3,76;25;F
  32;Maroon;MT;3,94;88;T
  34;LtGray;AZ;3,94;10;F
  36;Silver;NY;3,76;8;F
  38;Purple;HI;2,56;68;F
}

class function TSampleData.RowCount: LongInt;
begin
  Result := Length(TABLE_20);
end;

class function TSampleData.Value(aCol, aRow: integer): string;
begin
  Result := TABLE_20[aRow, aCol];
end;

{ TSampleGridData }

function TSampleGridData.AsDebug: string;
var
  r: integer;
begin
  Result := '';
  for r := 0 to RowCount - 1 do
    Result := Result + ValueString(0, r) + ','
end;

procedure TSampleGridData.Clear;
begin
end;

procedure TSampleGridData.Fill;
begin
end;

function TSampleGridData.RowCount: LongInt;
begin
  Result := TSampleData.RowCount
end;

function TSampleGridData.ValueFloat(aCol, aRow: integer): Double;
begin
  Result := StrToFloat(ValueString(aCol, aRow));
end;

function TSampleGridData.ValueString(aCol, aRow: integer): String;
begin
  Result := TSampleData.Value(aCol, aRow);
end;

{ TSampleGridData10000 }

function TSampleGridData2By2.AsDebug: string;
var
  r: integer;
begin
  Result := '';
  for r := 0 to RowCount - 1 do
    Result := Result + ValueString(0, r) + ','
end;

procedure TSampleGridData2By2.Clear;
begin
end;

constructor TSampleGridData2By2.Create(aCount: integer);
begin
  inherited Create;
  fItems := TList<integer>.Create;
  InnerFill(aCount);
  Rand;
end;

destructor TSampleGridData2By2.Destroy;
begin
  fItems.Free;
end;

procedure TSampleGridData2By2.Fill;
begin
end;

procedure TSampleGridData2By2.InnerFill(aCount: integer);
var
  i: integer;
begin
  for i := 0 to aCount - 1 do
    fItems.Add(2 * i);
end;

procedure TSampleGridData2By2.Rand;
var
  i: integer;
  a: integer;
  b: integer;
begin
  for i := 0 to RowCount - 1 do
  begin
    a := RandomRange(0, RowCount);
    b := RandomRange(0, RowCount);
    fItems.Exchange(a, b);
  end;
end;

function TSampleGridData2By2.RowCount: LongInt;
begin
  Result := fItems.Count;
end;

function TSampleGridData2By2.ValueFloat(aCol, aRow: integer): Double;
begin
  Result := fItems[aRow];
end;

function TSampleGridData2By2.ValueString(aCol, aRow: integer): String;
begin
  Result := IntToStr(fItems[aRow]);
end;

{ TSampleGridDataRandom }

procedure TSampleGridDataRandom.InnerFill(aCount: integer);
var
  i: integer;
begin
  for i := 0 to aCount - 1 do
    fItems.Add(RandomRange(0, 100));
end;

end.