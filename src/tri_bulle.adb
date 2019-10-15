with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
 
procedure tri_bulle is
    N : constant Integer := 8;
    tab : array (1..N) of Integer := (7, 8, 6, 4, 5, 3, 2, 1);
    tmp : Integer;
begin
    for j in 1..N loop
        for i in 1..N-j loop
            for k in 1..N loop
                Put(tab(k));
            end loop;
            New_Line;
        
            if tab(i) > tab(i + 1) then
                tmp := tab(i);
                tab(i) := tab(i + 1);
                tab(i + 1) := tmp;
            end if;
        
        end loop;
    end loop;
    
    for i in 1..N loop
        Put(tab(i));
    end loop;
    
end tri_bulle;
