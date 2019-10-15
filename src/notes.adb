with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure notes is
    subtype Note is Float range 0.0 .. 20.0;
    
    procedure Aff_Note(Desc : String; Val : Note) is
    begin
        Put(Desc & " : ");
        Put(Val, 2, 2, 0);
        Put_Line(" / 20");
    end Aff_Note;
    
    Max : Note := Note'First;
    Min : Note := Note'Last;
    N : Integer := 0; 
    Somme : Float := 0.0;
    Actu : Float;
begin
    while True loop
        Put("Entrer une note : ");
        Get(Actu);
        exit when Actu = -1.0;       
        
        if Actu > Max then
            Max := Actu;
        end if;
        
        if Actu < Min then
            Min := Actu;
        end if;
        
        Somme := Somme + Actu;
        N := N + 1;
    end loop;
    
    Aff_Note("Minimum", Min);
    Aff_Note("Maximum", Max);
    Aff_Note("Moyenne", Somme / Float(N));
end notes;
