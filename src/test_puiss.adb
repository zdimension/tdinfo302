with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with Ada.Calendar.Formatting; use Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones; use Ada.Calendar.Time_Zones;


procedure test_puiss is
    procedure System_Time is
   Now : Time := Clock;
begin
   Put_line(Image(Date => Now, Time_Zone => 2*60));
end System_Time;
    
    function somme_fact (n : Integer; x : Integer) return Float is
        res : Float := 0.0;
        fact : Integer := 1;
    begin
        for i in 1..n loop
            fact := fact * i;
            res := res + Float(Float(x) ** i) / Float(fact);
        end loop;
        return res;
    end somme_fact;
    
    function somme_fact_2 (n : Integer; x : Integer) return Float is
        res : Float := 0.0;
        puiss : Integer := 1;
        fact : Integer := 1;
    begin
        for i in 1..n loop
            fact := fact * i;
            puiss := puiss * x;
            res := res + Float(puiss) / Float(fact);
        end loop;
        return res;
    end somme_fact_2;
    test : Float := 0.0;
    n : Integer := 1000000000;
begin
    System_Time;
    for i in 1..n loop
        test := somme_fact(5, 3);
        end loop;
    System_Time;
    for i in 1..n loop
        test := somme_fact_2(5, 3);
    end loop;
    System_Time;
end test_puiss;
