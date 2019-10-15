-- NIGET Tom PEIP2-B2

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure tp2_tri_base is
    -- nombre d'éléments à lire et à trier
    N : constant Integer := 20;
    
    -- type nombre
    subtype T_Nombre is Natural;  
    -- type indices
    subtype T_Id is Natural range 1..N;
    -- type chiffre de nombre
    subtype T_Chiffre is Integer range 0..9;
    -- type de tableau principal
    type T_Tab is array(T_Id'Range) of T_Nombre;
    
    T : T_Tab;
    
    -- calcul du maximum du tableau
    function Max_T(T : in T_Tab) return T_Nombre is
        Max : T_Nombre := 0;
    begin
        for i in T'Range loop
            if T(i) > Max then
                Max := T(i);
            end if;
        end loop;
        return Max;
    end Max_T;
    
    procedure Trier(T : in out T_Tab) is
        tas : array(0..9) of T_Tab; -- tas (un pour chaque chiffre possible, soit 0..9)
        indices : array(0..9) of T_Id := (others => 1); -- indices courants des tas
        c : T_Chiffre; -- chiffre en train d'être traité
        n_i : Natural range 1..N+1; -- +1 pour pouvoir gérer les dernières itérations
        k : Natural := 1; -- rang actuel (en 10^n)
        max : T_Nombre := Max_T(T);
    begin
        -- on itère pour chaque rang possible
        while k < max loop
            -- on itère dans le tableau
            for i in T'Range loop
                -- on récupère le chiffre K de l'élément I
                c := T(i) / k mod 10;
                -- on le stocke dans le tas C
                tas(c)(indices(c)) := T(i);
                -- on incrémente l'indice courant pour le tas C
                indices(c) := indices(c) + 1;
            end loop;
            
            n_i := T_Tab'First;
            for i in 0..9 loop
                for j in 1..indices(i)-1 loop
                    T(n_i) := tas(i)(j);
                    n_i := n_i + 1;
                end loop;
            end loop;
            
            -- réinitialisation des indices
            indices := (others => 1);
            
            -- passage au rang suivant
            k := k * 10;
        end loop;
    end Trier;
    
    -- affichage du tableau dans la sortie standard
    -- nombres en largeur fixe séparés par des virgules
    procedure Afficher(T : in T_Tab) is
    begin
        for i in T'Range loop
            -- affichage des nombres de manière présentable
            Put(T(i), 0);
            Put(", ");
        end loop;
    
        New_Line;
    end Afficher;
    
    -- lecture du tableau depuis l'entrée standard, un nombre par ligne
    procedure Lire_Tab(T : out T_Tab) is
    begin
        for i in T'Range loop
            Get(T(i));
        end loop;
    end Lire_Tab;
begin
    Put_Line("Entrez vos nombres ligne par ligne.");
    if False then -- lecture depuis l'entrée standard
        Lire_Tab(T);
    else -- données d'exemple/test
        T := (2329, 5217, 2301, 808, 3025, 4028, 6836, 2284, 722, 8702, 5981, 1677, 84, 5528, 6326, 6627, 9016, 5, 4827, 2674);
    end if;
    
    Put("Avant tri : "); Afficher(T);
    
    Trier(T);
    
    Put("Après tri : "); Afficher(T);
end tp2_tri_base;
