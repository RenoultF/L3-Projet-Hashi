require 'gtk3'


class RubyApp < Gtk::Window

    def initialize
        super
        
        init_ui
    end
    
    def init_ui
    

        title = Gtk::Label.new "Windows"
        grid = Gtk::Grid.new 

    
        (0..7).each do |i|
          (0..7).each do |j|
                # puts "taille X #{@grille.tailleX}"
                # puts "taille Y #{@grille.tailleY}"
                # temp = @grille.getCase(i,j)
                boutton = Gtk::Button.new(:label => "COUCOU", :use_underline => nil, :stock_id => nil)
                # if(temp.instance_of? Pont)
                #     puts "C EST UN PONT"
                #     creation du bouton pont
                # elsif(temp.instance_of? Ile)
                #     puts "C EST UNE ILE"
                # elsif(temp.instance_of? Case)
                #     puts "C EST UNE CASE"
                # else
                #     puts "PROBLEME INSTANCE"
                # end

                grid.attach boutton, i, j, 1, 1
           end
        end
        
        add grid
        
    
        set_title "Windows"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        set_default_size 350, 300
        set_window_position :center
        
        show_all        
    end
end


window = RubyApp.new
Gtk.main