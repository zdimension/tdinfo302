package body annee is

    function Est_Bissextile (Annee : Integer) return Boolean is
    begin
        return (Annee Mod 4 = 0 And Annee Mod 100 /= 0) Or Annee Mod 400 = 0;
    end Est_Bissextile;

end annee;
