with Ada.Text_IO; use Ada.Text_IO;

procedure phrases is
    function Maju (c : Character) return Character is
    begin
        if c in 'a'..'z' then
            return Character'Val(Character'Pos(c) - 32);
        else
            return c;
        end if;
    end Maju;
    
    ch : Character;
    
    nb_a, nb_ne : Integer := 0;
    
    n : Boolean := False;
begin
    loop
        Get(ch);
        exit when ch = '.';
        
        if ch = 'a' then
            nb_a := nb_a + 1;
        end if;
        
        if n and ch = 'e' then
            nb_ne := nb_ne + 1;
        end if;       
        
        n := ch = 'n';
        
        Put(Maju(ch));
    end loop;
    
    Put_Line("Nombre 'a'  : " & Integer'Image(nb_a));
    Put_Line("Nombre 'ne' : " & Integer'Image(nb_ne));
end phrases;
