with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure somme_series is
    function somme_entiers (n : Integer; impair : Boolean := False) return Integer is
        res : Integer := 0;
    begin
        for i in 1..n loop
            res := res + 2 * i - Boolean'Pos(impair);
        end loop;
        return res;
    end somme_entiers;
    
    function somme_entiers_2 (n : Integer; impair : Boolean := False) return Integer is
        res : Integer := n * n;
    begin
        if not impair then res := res + n; end if;
        return res;
    end somme_entiers_2;
    
    
    function somme_fact (n : Integer; x : Integer) return Float is
        res : Float := 0.0;
        fact : Integer := 1;
        puiss : Integer := 1;
    begin
        for i in 1..n loop
            fact := fact * i;
            puiss := puiss * x;
            res := res + Float(puiss) / Float(fact);
        end loop;
        return res;
    end somme_fact;
    
    N, X : Integer;
begin
    Put("Entrez N : "); Get(N);
    Put("Pairs : "); Put(somme_entiers(N)); New_Line;
    Put("Pairs (2) : "); Put(somme_entiers_2(N)); New_Line;
    Put("Impairs : "); Put(somme_entiers(N, True)); New_Line;
    Put("Impairs (2) : "); Put(somme_entiers_2(N, True)); New_Line;
    Put("Entrez X : "); Get(X);
    Put("Résultat : "); Put(somme_fact(N, X), 2, 2, 0);
end somme_series;
