with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure carremagique is
    TAILLE : constant Integer := 5;
    type Tcarre is array(1..TAILLE, 1..TAILLE) of Integer;
    
    function Est_Magique(carre : in Tcarre) return Boolean is
        somme : Integer;
        ref : Integer := -1;
        trace, antitrace : Integer := 0;
    begin
        for i in 1..TAILLE loop
            somme := 0;
            for j in 1..TAILLE loop
                somme := somme + carre(i, j);
            end loop;
            if ref /= -1 and ref /= somme then
                return False;
            else
                ref := somme;
            end if;
        end loop;
        
        ref := -1;
        
        for i in 1..TAILLE loop
            somme := 0;
            for j in 1..TAILLE loop
                somme := somme + carre(j, i);
            end loop;
            if ref /= -1 and ref /= somme then
                return False;
            else
                ref := somme;
            end if;
        end loop;
        
        for i in 1..TAILLE loop
            trace := trace + carre(i, i);
            antitrace := antitrace + carre(i, TAILLE - i + 1);
        end loop;
        
        
        return trace = antitrace;
    end Est_Magique;
    
    function Ajout_Mod(n : Integer; ajout : Integer) return Integer is
        res : Integer := n + ajout;
    begin
        if res = 0 then
            return TAILLE;
        elsif res = TAILLE + 1 then
            return 1;
        else
            return res;
        end if;
    end Ajout_Mod;
    
    procedure Gen_Impair(carre : in out Tcarre) is
        x : Integer := Integer(TAILLE / 2) + 1;
        y : Integer := x + 1;
        actu : Integer := 1;
        dx : Integer := 1;
    begin
        while actu <= TAILLE * TAILLE loop
            if carre(x, y) = 0 then
                carre(x, y) := actu;
                actu := actu + 1;
                dx := 1;
            else
                dx := -1;
            end if;
            x := Ajout_Mod(x, dx);
            y := Ajout_Mod(y, 1);
        end loop;
    end Gen_Impair;
    
    procedure Affiche(carre : in Tcarre) is 
    begin
        for i in 1..TAILLE loop
            for j in 1..TAILLE loop
                Put(carre(j, i));
            end loop;
            New_Line;
        end loop;
    end Affiche;
    
    test : Tcarre := (others => (others => 0));
begin
    Gen_Impair(test);
    Affiche(test);
    Put_Line(if Est_Magique(test) then "Magique" else "Pas Magique");
end carremagique;
