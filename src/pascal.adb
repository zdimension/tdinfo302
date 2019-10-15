with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure pascal is
    ordre : Integer;
begin
    --Put_Line(for all I in 1..10 => I > 0);
    Get(ordre);
    
    declare
        tab : array(0..ordre) of Integer := (1, others => 0);
    begin
        for i in 0..(ordre) loop
            Put("ordre"&integer'image(i)&" : ");
            
            for j in reverse 1..i loop
                tab(j ) := tab(j) + tab(j-1);
            end loop;  
            
            for j in 0..i loop
                Put(tab(j));
            end loop;
            
            New_Line;
        end loop;     
    end;
    
end pascal;
