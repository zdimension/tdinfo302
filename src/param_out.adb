with Ada.Text_IO; use Ada.Text_IO;

procedure param_out is
    procedure test_2 (nb : in out Integer) is
    begin
        nb := 789;
    end test_2;
    
    ma_var : Integer := 123;
begin
    Put_Line("avant : " & Integer'Image(ma_var));
    test_2(ma_var);
    Put_Line("après : " & Integer'Image(ma_var));
end param_out;
