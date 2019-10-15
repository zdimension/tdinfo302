with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;

procedure reversi is
    package Discrete_Random is new Ada.Numerics.Discrete_Random(Result_Subtype => Integer);
    use Discrete_Random;
    gen : Generator;
    etat : State;
    
    jeu : array (1..9) of Integer := (1, 2, 3, 4, 5, 6, 7, 8, 9);
    k, t : Integer;
    
    function est_trie return Boolean is
    begin
        for i in jeu'Range loop
            if jeu(i) /= i then
                return False;
            end if;
        end loop;
        return True;
    end est_trie;
    
    nb : Integer;
    essais : Integer;
    c : Character;
begin
    Reset(gen);
    Save(gen, etat);    
    
    loop
        Reset(gen, etat);
        
        for i in reverse jeu'Range loop
            k := (Random(gen) mod i) + 1;
            t := jeu(i);
            jeu(i) := jeu(k);
            jeu(k) := t;
        end loop;
        
        essais := 0;
        
        while not est_trie loop
            for i in jeu'Range loop
                Put(jeu(i), 2);
            end loop;
            New_Line;
            Put("> ");
            Get(nb);
        
            if nb not in jeu'Range then
                Put_Line("Le nombre doit être entre " & Integer'Image(jeu'First) & " et " & Integer'Image(jeu'Last));
            else
                for i in 1..(nb / 2) loop
                    t := jeu(i);
                    jeu(i) := jeu(nb - i + 1);
                    jeu(nb - i + 1) := t;
                end loop;
            end if;
        
            essais := essais + 1;
        end loop;
    
        Put_Line("Bravo ! Vous avez gagné en " & Integer'Image(essais) & " tours !");
        Put("Voulez-vous réessayer sur la même configuration ? [O/N] ");
        Get(c);
        exit when c /= 'o' and c /= 'O';
    end loop;
   
end reversi;
