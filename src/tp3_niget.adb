with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps.Constants;

-- NIGET TOM PEIP2-B2


-- IMPORTANT !
-- Si vous utilisez GNAT ou une vieille version d'Ada pas aux normes,
-- décommentez la ligne ci-dessous et commentez celle juste après
--with Ada.Strings.Unbounded_Text_IO; use Ada.Strings.Unbounded_Text_IO;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;


procedure tp3_niget is
    type T_Couleur_Vin is (Rouge, Blanc, Rose);
    
    -- pour l'affichage
    Couleur_Vin_Aff : array (T_Couleur_Vin) of Unbounded_String :=
      (
       To_Unbounded_String("rouge"), 
       To_Unbounded_String("blanc"), 
       To_Unbounded_String("rosé")
      );   
    
    type T_Région is 
      (
       Alsace, Beaujolais, Bordeaux, Bourgogne, Chablis, Champagne,
       Corse, Jura, Languedoc_Roussillon, Loire, Provence, Rhone,
       Savoie, Sud_Ouest
      );
    
    -- pour l'affichage
    Région_Aff : array (T_Région) of Unbounded_String :=
      (
       To_Unbounded_String("Alsace"), To_Unbounded_String("Beaujolais"),
       To_Unbounded_String("Bordeaux"), To_Unbounded_String("Bourgogne"),
       To_Unbounded_String("Chablis"), To_Unbounded_String("Champagne"),
       To_Unbounded_String("Corse"), To_Unbounded_String("Jura"),
       To_Unbounded_String("Languedoc-Roussillon"), To_Unbounded_String("Loire"),
       To_Unbounded_String("Provence"), To_Unbounded_String("Rhône"),
       To_Unbounded_String("Savoie"), To_Unbounded_String("Sud-Ouest")
      ); 
    
    type T_Vin is 
        record
            Nom : Unbounded_String;
            Région : T_Région;
            Couleur : T_Couleur_Vin;
            Millésime : Integer;
            Quantité : Natural;
        end record;
    
    TAILLE_CAVE : constant Positive := 40;
    
    Cave : array (1..TAILLE_CAVE) of T_Vin;
    
    subtype Pos_Vin is Integer range Cave'Range;
    
    -- nombre de cases occupées de Cave
    Cave_NB : Natural range 0..TAILLE_CAVE := 0;
    
    -- pose une question fermée
    function Choix(Msg : Unbounded_String) return Boolean is
        Rep : Character;
    begin
        Put(Msg & " [O/N] ");
        Get(Rep);
        return Rep = 'O' or Rep = 'o';
    end Choix;
    
    -- a < b : -1
    -- a = b :  0
    -- a > b :  1
    subtype Comparaison is Integer range -1..1;
    
    -- compare deux chaînes sans se préoccuper de la casse
    function Compare_Chaines(A, B : Unbounded_String) return Comparaison is
        X : Unbounded_String := A;
        Y : Unbounded_String := B;
    begin
        -- passage en minuscule pour mettre X et Y sur un pied d'égalité
        -- pour éviter les 'z' > 'A' et autres loufoqueries des comparateurs d'Ada
        Ada.Strings.Unbounded.Translate(X, Ada.Strings.Maps.Constants.Lower_Case_Map);
        Ada.Strings.Unbounded.Translate(Y, Ada.Strings.Maps.Constants.Lower_Case_Map);
        
        if X > Y then
            return 1;
        elsif X < Y then
            return -1;
        else
            return 0;
        end if;
    end Compare_Chaines;
    
    -- détermine l'emplacement où insérer un nouveau vin
    -- par recherche dichotomique
    function Indice_Correct(Q : Unbounded_String) return Pos_Vin is
        -- bornes
        A : Pos_Vin := 1;
        B : Pos_Vin;
        
        -- milieu de l'intervalle
        Mid : Pos_Vin;
        
        -- valeur à comparer
        Val : Unbounded_String;
        
        -- résultat de comparaison
        Comp : Comparaison;
    begin
        -- si la cave est vide, on insère au début
        if Cave_NB = 0 then
            return 1;
        else
            B := Cave_NB;
        end if;
        
        while A < B loop
            Mid := (A + B) / 2;
            Val := Cave(Mid).Nom;
            Comp := Compare_Chaines(Q, Val);
            
            if Comp = 0 then
                return Mid + 1; -- +1 pour ajouter à la fin d'une suite d'éléments équivalents et non au début
            elsif Comp = -1 then
                B := Mid;
            elsif Comp = 1 then
                if A = Mid then
                    return B + 1;
                end if;
                A := Mid;
            end if;
        end loop;
        return B;
    end Indice_Correct;
    
    -- vérifie si la cave est vide, affiche une erreur le cas échéant
    function Verif_Vide return Boolean is
    begin
        if Cave_NB = 0 then
            Put_Line("*** La cave est vide ! ***");
            return True;
        end if;
        return False;
    end Verif_Vide;
    
    -- affiche les caractéristiques d'un vin
    procedure Aff_Vin(Vin : T_Vin) is
    begin
        Put_Line(Vin.Nom 
                 & " - vin " & Couleur_Vin_Aff(Vin.Couleur) 
                 & " d'origine " & Région_Aff(Vin.Région)
                 & ", millésime" & Integer'Image(Vin.Millésime)
                 & ", stock :" & Integer'Image(Vin.Quantité));
    end Aff_Vin;
    
    -- liste les vins
    procedure A_Liste_Vins is
    begin
        if Verif_Vide then return; end if;
            
        Put_Line("Il y a" & Integer'Image(Cave_NB) & " vins :");
        for i in 1..Cave_NB loop
            Put(Integer'Image(i) & "- ");
            Aff_Vin(Cave(i));
        end loop;
    end A_Liste_Vins;
    
    -- demande à l'utilisateur de choisir un vin
    function Choisir_Vin return Pos_Vin is
        N_Vin : Integer;
    begin
        A_Liste_Vins;
            
        loop
            Put_Line("Veuillez saisir le numéro du vin.");
            Put("> ");
            Get(N_Vin);
            exit when N_Vin in 1..Cave_NB;
            Put_Line("*** Numéro de vin incorrect ! ***");
        end loop;
        
        return N_Vin;
    end Choisir_Vin;
    
    -- insère un vin à la position spécifiée
    -- pour cela, décale vers la droite celles qui sont dans le chemin
    procedure Insérer_Vin(Vin : T_Vin; Pos : Pos_Vin) is
    begin
        for i in reverse Pos..Cave_NB loop
            Cave(i + 1) := Cave(i);
        end loop;
        Cave(Pos) := Vin;
        Cave_NB := Cave_NB + 1;
    end Insérer_Vin;
    
    -- supprime le vin à la position spécifiée
    procedure A_Suppr_Vin(N : Integer := -1) is
        N_Vin : Pos_Vin;
    begin
        if N not in Pos_Vin'Range then
            
            N_Vin := Choisir_Vin;
        else
            N_Vin := N;
        end if;
        
        if not Choix(To_Unbounded_String("*** Cette action est irréversible ! Êtes-vous sûr(e) ? ***")) then
            return;
        end if;
        
        Put_Line("*** Suppression de " & Cave(N_Vin).Nom & " ***");
        
        for i in N_Vin..Cave_NB loop
            Cave(i) := Cave(i + 1);
        end loop;
        Cave_NB := Cave_NB - 1;
    end A_Suppr_Vin;
    
    procedure A_Ajout_Bouteille(N : Integer := -1) is
        N_Vin : Pos_Vin;
        Quant : Positive;
    begin
        if Verif_Vide then return; end if;
        
        if N not in Pos_Vin'Range then
            N_Vin := Choisir_Vin;
        else
            N_Vin := N;
        end if;
        
        Put("Nombre de bouteilles à ajouter au stock : ");
        Get(Quant);
        
        Cave(N_Vin).Quantité := Cave(N_Vin).Quantité + Quant;
    end A_Ajout_Bouteille;
    
    -- lit et ajoute un ou plusieurs vins
    procedure A_Ajout_Vin is
        Vin : T_Vin;
        Ent : Integer;
        Existe : Boolean := False;
    begin
        loop
            if Cave_NB = TAILLE_CAVE then
                Put_Line("*** La cave est pleine ! ***");
                exit;
            end if;
            
            -- efface le buffer d'entrée pour éviter de
            -- relire le retour chariot précédemment entré
            -- lors du choix de l'opération
            Skip_Line;
            
            Put_Line("Veuillez saisir les informations du vin.");
            Put("Nom : ");
            Vin.Nom := Get_Line;
            
            Existe := False;
            for i in Cave'Range loop
                if Compare_Chaines(Cave(i).Nom, Vin.Nom) = 0 then
                    Put_Line("*** Le vin est déjà présent dans la base, entrée en mode ajout de bouteille ***");
                    A_Ajout_Bouteille(i);
                    Existe := True;
                end if;
            end loop;
            
            if not Existe then         
                for r in T_Région'Range loop
                    Put_Line(Integer'Image(T_Région'Pos(r) + 1) & "- " & Région_Aff(r));
                end loop;

                loop
                    Put("Région : ");
                    Get(Ent);
                    exit when Ent in 1..(T_Région'Pos(T_Région'Last) + 1);
                    Put_Line("*** Numéro de région incorrect ! ***");
                end loop;
                Vin.Région := T_Région'Val(Ent - 1);
                
                for r in T_Couleur_Vin'Range loop
                    Put_Line(Integer'Image(T_Couleur_Vin'Pos(r) + 1) & "- " & Couleur_Vin_Aff(r));
                end loop;

                loop
                    Put("Couleur : ");
                    Get(Ent);
                    exit when Ent in 1..(T_Couleur_Vin'Pos(T_Couleur_Vin'Last) + 1);
                    Put_Line("*** Numéro de couleur incorrect ! ***");
                end loop;
                Vin.Couleur := T_Couleur_Vin'Val(Ent - 1);
            
                Put("Millésime : ");
                Get(Vin.Millésime);
                Put("Quantité : ");
                Get(Vin.Quantité);
            
                Insérer_Vin(Vin, Indice_Correct(Vin.Nom));
            end if;
            
            exit when not Choix(To_Unbounded_String("Voulez-vous ajouter un autre vin ?"));
        end loop;
    end A_Ajout_Vin;
    
    -- lit et sort une ou plusieures bouteilles
    procedure A_Sortir_Bouteille is
        N_Vin : Integer;
        N_Quant : Integer;
    begin
        loop
            if Verif_Vide then return; end if;
            
            N_Vin := Choisir_Vin;
            
            loop
                Put_Line("Combien de bouteilles voulez-vous sortir ?");
                Put("> ");
                Get(N_Quant);
                exit when N_Quant in 1..Cave(N_Vin).Quantité;
                Put_Line("*** La quantité doit être entre 1 et " & Integer'Image(Cave(N_Vin).Quantité) & " ! ***");
            end loop;
            
            Cave(N_Vin).Quantité := Cave(N_Vin).Quantité - N_Quant;
            
            if Cave(N_Vin).Quantité = 0 then
                Put_Line("*** Le vin est en rupture de stock ***");
                if Choix(To_Unbounded_String("*** Voulez-vous le supprimer de la base ? ***")) then
                    A_Suppr_Vin(N_Vin);
                end if;
            end if;
            
            A_Liste_Vins;
           
            exit when not Choix(To_Unbounded_String("Voulez-vous sortir une autre bouteille ?"));
        end loop;
    end A_Sortir_Bouteille;
    
    Action : Character;
begin
    -- mettre à True pour charger des données d'exemple
    -- pour ne pas avoir à tout saisir à la main
    if True then
        Cave 
          := ( 
               (To_Unbounded_String("Beaujolais AOC"),Beaujolais,Rouge,2000,7),  
               (To_Unbounded_String("Chablis AOC"),Bourgogne,Blanc,2017,11), 
               (To_Unbounded_String("Côtes de Provence"),Provence,Rose,1999,11), 
               (To_Unbounded_String("Saint-Emilion"),Bordeaux,Rouge,2003,3),
               others => <>
              );
        Cave_NB := 4;
    end if;
    
    loop
        -- affichage du menu
        Put_Line("Choisissez une opération à effectuer :");
        Put_Line(" 1- Ajouter un vin");
        Put_Line(" 2- Supprimer un vin");
        Put_Line(" 3- Ajouter une bouteille");
        Put_Line(" 4- Sortir une bouteille");     
        Put_Line(" 5- Afficher la liste des vins");
        Put_Line(" 6- Quitter");
        
        Put("> ");    
        Get(Action);
        
        New_Line;
        
        case Action is
            when '1' => A_Ajout_Vin;        
            when '2' => A_Suppr_Vin; 
            when '3' => A_Ajout_Bouteille;
            when '4' => A_Sortir_Bouteille;
            when '5' => A_Liste_Vins;
            when '6' => exit;
                when others => Put_Line("*** Numéro d'opération incorrect ! ***");
        end case;
        
        New_Line;
    end loop;
end tp3_niget;
