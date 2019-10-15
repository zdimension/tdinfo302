with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure parfait is
    function Est_Parfait(nb : Integer) return Boolean is
        somme : Integer := 0;
    begin
        for i in 1..(nb / 2 + 1) loop
            if nb mod i = 0 then
                somme := somme + i;
            end if;
        end loop;
        
        return somme = nb;
    end Est_Parfait;
    
    n : Integer;
begin
    while True loop
        Put(">>> ");
        Get(n);
        exit when n = -1;
        Put_Line(if Est_Parfait(n) then "parfait" else "pas parfait");
    end loop;
end parfait;
