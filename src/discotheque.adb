with Ada.Text_IO; use Ada.Text_IO;

procedure discotheque is
    MAX_CHANSONS : constant Natural := 30;
    MAX_ALBUMS : constant Natural := 200;
    
    type T_Chanson is
        record
            titre : String (1..40);
            duree : Natural;
        end record;
    
    type T_Coll_Chansons is array (1..MAX_CHANSONS) of T_Chanson;
    
    type T_Album is
        record
            contenu : T_Coll_Chansons;
            nb_chanson : Natural;
            annee : Natural;
            titre, artiste : String (1..40);
        end record;
    
    type T_Genre is (G_Classique, G_Variete, G_Rap, G_Disco, G_Rock);
    
    type T_Tab_Albums is array (1..MAX_ALBUMS) of T_Album;
    
    type T_Coll_Albums is
        record
            les_albums : T_Tab_Albums;
            nb_album : Natural range 0..MAX_ALBUMS;
        end record;
    
    type T_Disco is array(T_Genre) of T_Coll_Albums;
    
    function duree_totale(a : in T_Album) return Natural is
        res : Natural := 0;
    begin
        for i in 1..a.nb_chanson loop
            res := res + a.contenu(i).duree;
        end loop;
        return res;
    end duree_totale;
    
    procedure afficher_album(a : in T_Album) is
    begin
        Put_Line("Titre : " & a.titre);
        for i in 1..a.nb_chanson loop
            Put_Line(" * " & a.contenu(i).titre);
        end loop;
        New_Line;
    end afficher_album;
    
    procedure ajouter_album(a : in T_Album; g : in T_Genre; d : in out T_Disco) is
    begin
        d(g).nb_album := d(g).nb_album + 1;
        d(g).les_albums(d(g).nb_album) := a;
    end ajouter_album;
        
    disco : T_Disco;
    
begin
    
    Put_Line("bijour");
    
    for g in T_Genre loop
        Put_Line(1);
        end loop;
   
end discotheque;
