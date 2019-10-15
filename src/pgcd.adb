with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure pgcd is
    function PGCD_Euclide (a : Integer; b : Integer) return Integer is
        p : Integer := a;
        q : Integer := b;
        r : Integer;
    begin
        while q /= 0 loop
            r := p;
            p := q;
            q := r mod p;
        end loop;
        return p;
    end PGCD_Euclide;
    
    function PGCD_Diff (a : Integer; b : Integer) return Integer is
        p : Integer := a;
        q : Integer := b;
    begin
        while p /= q loop
            if p > q then
                p := p - q;
            else
                q := q - p;
            end if;
        end loop;
        return p;
    end PGCD_Diff;
    
    a, b : Integer;
begin
    loop
        Put(">>> a = ");
        Get(a);
        exit when a = -1;
        Put(">>> b = ");
        Get(b);
        
        Put_Line("Euclide     : " & Integer'Image(PGCD_Euclide(a, b)));
        Put_Line("Différences : " & Integer'Image(PGCD_Diff(a, b)));
    end loop;
end pgcd;
