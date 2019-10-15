with Ada.Text_IO; use Ada.Text_IO;

procedure tp1 is
    -- conversion en majuscule
    function Maju (c : Character) return Character is
    begin
        if c in 'a'..'z' then -- si minuscule
            return Character'Val(Character'Pos(c) - 32); -- on décale de 32
        else
            return c; -- on change rien
        end if;
    end Maju;
    
    -- caractère actuel
    ch : Character;
    
    -- compteurs
    nb_i, nb_le, nb_mots_4 : Integer := 0;
    
    -- drapeau / indique si le dernier caractère était un L
    dernier_est_l : Boolean := False;
    
    -- drapeau / indique si le mot actuel contient au moins un I
    mot_contient_i : Boolean := False;
    
    -- longueur du mot en cours
    longueur_act : Integer := 0;
begin
    loop
        -- lecture du caractère
        Get(ch); 
        
        ch := Maju(ch);
        
        -- fin de mot ou de phrase
        if ch = ' ' or ch = '.' then 
            -- compteur de mots de 4 lettres
            if longueur_act = 4 then 
                nb_mots_4 := nb_mots_4 + 1;
            end if;
            
            -- le mot est fini, on repasse la longueur à 0 et le drapeau à Faux
            longueur_act := 0; 
            mot_contient_i := False;
        else
            -- le mot n'est pas fini, on incrémente la longueur
            longueur_act := longueur_act + 1; 
        end if;
        
        -- on sort de la boucle si on trouve un point car la phrase est finie
        exit when ch = '.'; 
        
        -- compteur de I
        if ch = 'I' and not mot_contient_i then -- si c'est le premier I dans le mot actuel
            nb_i := nb_i + 1;
            mot_contient_i := True;
        end if;
        
        -- compteur de LE
        if dernier_est_l and ch = 'E' then 
            nb_le := nb_le + 1;
        end if;   
        
        -- on vérifie si c'est un L, pour pouvoir compter les LE
        dernier_est_l := ch = 'L'; 

        -- on affiche le caractère en majuscule
        Put(Maju(ch)); 
    end loop;
    
    -- on ajoute une ligne à la fin de la phrase affichée
    New_Line; 
    
    -- affichage des compteurs
    Put_Line("Nombre de 'le' : " & Integer'Image(nb_le));
    Put_Line("Nombre de mots contenant un i : " & Integer'Image(nb_i));
    Put_Line("Nombre de mots de 4 lettres : " & Integer'Image(nb_mots_4));
end tp1;
