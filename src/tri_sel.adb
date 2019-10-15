with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure tri_sel is
    N : constant Integer := 8;
    tab : array (1..N) of Integer := (7, 8, 6, 5, 4, 3, 2, 1);
    tmp, minI : Integer;
begin
    for i in 1..N-1 loop
        for k in 1..N loop
            Put(tab(k));
        end loop;
        New_Line;
        minI := i;
        for j in i+1..N loop
            if tab(j) < tab(minI) then
                minI := j;
            end if;
        end loop;
        tmp := tab(i);
        tab(i) := tab(minI);
        tab(minI) := tmp;
    end loop;
    
    for i in 1..N loop
        Put(tab(i));
    end loop;
    
end tri_sel;
