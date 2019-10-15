with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
    function Est_Bissextile (Annee : Integer) return Boolean is
    begin
        return (Annee Mod 4 = 0 And Annee Mod 100 /= 0) Or Annee Mod 400 = 0;
    end Est_Bissextile;

    Annee : Integer;
begin
    Get(Annee);

    if Est_Bissextile(Annee) then
        Put_Line("Bissextile");
    else
        Put_Line("Non Bissextile");
    end if;
end Main;
