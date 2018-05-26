unit Pangea.MemoryGuard;

interface

uses
  Pangea.ScopeAction;

function GuardMemoryOnExit(var AObject): IScopeAction; overload;
function GuardMemoryOnExit(var AObject1, AObject2): IScopeAction; overload;
function GuardMemoryOnExit(var AObject1, AObject2, AObject3): IScopeAction; overload;
function GuardMemoryOnExit
  (var AObject1, AObject2, AObject3, AObject4): IScopeAction; overload;
function GuardMemoryOnExit
  (var AObject1, AObject2, AObject3, AObject4, AObject5): IScopeAction; overload;
function GuardMemoryOnExit
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6): IScopeAction; overload;
function GuardMemoryOnExit
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6, AObject7): IScopeAction; overload;
function GuardMemoryOnExit
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6, AObject7, AObject8): IScopeAction; overload;

function GuardMemoryOnFailure(var AObject): IScopeAction; overload;
function GuardMemoryOnFailure(var AObject1, AObject2): IScopeAction; overload;
function GuardMemoryOnFailure(var AObject1, AObject2, AObject3): IScopeAction; overload;
function GuardMemoryOnFailure
  (var AObject1, AObject2, AObject3, AObject4): IScopeAction; overload;
function GuardMemoryOnFailure
  (var AObject1, AObject2, AObject3, AObject4, AObject5): IScopeAction; overload;
function GuardMemoryOnFailure
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6): IScopeAction; overload;
function GuardMemoryOnFailure
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6, 
  AObject7): IScopeAction; overload;
function GuardMemoryOnFailure
  (var AObject1, AObject2, AObject3, AObject4, AObject5, AObject6, 
  AObject7, AObject8): IScopeAction; overload;

implementation

uses
  System.SysUtils;

type
  TMemoryGuardOnExit = class(TInterfacedObject, IScopeAction)
  strict private
    FPointers: TArray<PPointer>;
  public
    constructor Create(const AObjectPtrs: TArray<PPointer>);
    destructor Destroy(); override;

    procedure Cancel();
  end;

type 
  TMemoryGuardOnFailure = class(TMemoryGuardOnExit)
  public
    destructor Destroy(); override;
  end;

constructor TMemoryGuardOnExit.Create(const AObjectPtrs: TArray<PPointer>);
begin
  inherited Create();
  FPointers := AObjectPtrs;
end;

destructor TMemoryGuardOnExit.Destroy();
var 
  LIndex: Integer;
begin
  for LIndex := High(FPointers) downto Low(FPointers) do
  begin
    FreeAndNil(FPointers[LIndex]^);
  end;

  inherited Destroy();
end;

procedure TMemoryGuardOnExit.Cancel();
begin
  SetLength(FPointers, 0);
end;

destructor TMemoryGuardOnFailure.Destroy();
begin
  if ExceptObject = nil then
  begin
    Cancel();
  end;

  inherited Destroy();
end;

function GuardMemoryOnExit(var AObject): IScopeAction;
begin
  TObject(AObject) := nil;
  Result := TMemoryGuardOnExit.Create([@AObject]);
end;

function GuardMemoryOnExit(var AObject1; var AObject2): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  Result := TMemoryGuardOnExit.Create([@AObject1, @AObject2]);
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  Result := TMemoryGuardOnExit.Create([@AObject1, @AObject2, @AObject3]);
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3; var AObject4): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  Result := TMemoryGuardOnExit.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4]);  
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  Result := TMemoryGuardOnExit.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5]);    
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  Result := TMemoryGuardOnExit.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6]);   
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6; var AObject7): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  TObject(AObject7) := nil;
  Result := TMemoryGuardOnExit.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6, @AObject7]);    
end;

function GuardMemoryOnExit(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6; var AObject7; var AObject8): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  TObject(AObject7) := nil;
  TObject(AObject8) := nil;
  Result := TMemoryGuardOnExit.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6, @AObject7, @AObject8]);
end;

function GuardMemoryOnFailure(var AObject): IScopeAction;
begin
  TObject(AObject) := nil;
  Result := TMemoryGuardOnFailure.Create([@AObject]);
end;

function GuardMemoryOnFailure(var AObject1; var AObject2): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  Result := TMemoryGuardOnFailure.Create([@AObject1, @AObject2]);
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  Result := TMemoryGuardOnFailure.Create([@AObject1, @AObject2, @AObject3]);
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3; var AObject4): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  Result := TMemoryGuardOnFailure.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4]);  
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  Result := TMemoryGuardOnFailure.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5]);    
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  Result := TMemoryGuardOnFailure.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6]);   
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6; var AObject7): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  TObject(AObject7) := nil;
  Result := TMemoryGuardOnFailure.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6, @AObject7]);    
end;

function GuardMemoryOnFailure(var AObject1; var AObject2; var AObject3; var AObject4; 
  var AObject5; var AObject6; var AObject7; var AObject8): IScopeAction;
begin
  TObject(AObject1) := nil;
  TObject(AObject2) := nil;
  TObject(AObject3) := nil;
  TObject(AObject4) := nil;
  TObject(AObject5) := nil;
  TObject(AObject6) := nil;
  TObject(AObject7) := nil;
  TObject(AObject8) := nil;
  Result := TMemoryGuardOnFailure.Create(
    [@AObject1, @AObject2, @AObject3, @AObject4, @AObject5,
    @AObject6, @AObject7, @AObject8]);
end;

end.
