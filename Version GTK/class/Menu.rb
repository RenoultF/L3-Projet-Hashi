require 'gtk3'
load 'JeuUI.rb'

class Menu
    # --- BUILDERS ---
        # @builder
        # @builderJeu
        
    # --- WINDOWS ---
        # @window

    # --- BTN ---
    # @btnJouer
    # @btnQuitter
    # @btnAide
    # @btnRegles
    # @btnAstuces

    @@mode = 1
	@@taille = 1
	@@difficulte = 1

     def initialize()
        @builder = Gtk::Builder.new
     end

     def afficheDemarrage()
		if(@window != nil) then
			@window.destroy()
		end
        @builder.add_from_file("../glade/menu.glade")
        
        # --- GET_OBJECT
            # --- WINDOWS ---
            @window = @builder.get_object("windowMenu")

            # --- BTN ---
            @btnQuitter = @builder.get_object("btnQuitter")
            @btnJouer = @builder.get_object("btnJouer")
            @btnAide = @builder.get_object("btnAide")
            @btnRegles = @builder.get_object("btnRegles")
            @btnAstuces = @builder.get_object("btnAstuces")

            # --- TGL ---
            @tglMNormal = @builder.get_object("tglNormal")
            @tglAventure = @builder.get_object("tglAventure")
            @tgl77 = @builder.get_object("tgl77")
            @tgl1010 = @builder.get_object("tgl1010")
            @tgl1515 = @builder.get_object("tgl1515")
            @tglFacile = @builder.get_object("tglFacile")
            @tglNormal = @builder.get_object("tglNorma")
			@tglDiff = @builder.get_object("tglDifficile")
			
		# --- ENTRY
			@pseudo = @builder.get_object("entryPseudo")
		

        # --- SIGNAUX ---
            # --- WINDOWS ---
            @window.signal_connect('destroy') { |_widget| Gtk.main_quit }
            
            # --- BTN ---
            @btnQuitter.signal_connect('clicked') { puts "Tchao !"; Gtk.main_quit }
            @btnJouer.signal_connect('clicked') { |_widget| changerFenetre() }
            @btnAide.signal_connect('clicked') { puts "--- Affichage des aides";  }
            @btnRegles.signal_connect('clicked') { puts "--- Affichage des règles";  }
            @btnAstuces.signal_connect('clicked') { puts "--- Affichage des astuces"; }
        @window.show()
        # Appel de la gestion des signaux
        self.gestionTgl()
		Gtk.main()
    end

    def gestionTgl()
        #Gestion des paramètres selon [Mode], [Taille] et [Difficulté]
		
		#1-Mode de jeu : Normal OU Aventure
		@tglMNormal.signal_connect('toggled') {
			
			if (@@mode != 1) && @tglAventure.active?
				@tglAventure.active = false;
				@tglMNormal.active = true;
				@@mode = 1;
				puts "Mode : Normal - #{@@mode}";
			else if !(@tglMNormal.active?) && !(@tglAventure.active?)
				@tglMNormal.active = true;
				@@mode = 1;
				puts "Mode : Normal - #{@@mode}";
				end
			end
		}
		
		@tglAventure.signal_connect('toggled') {
			
			if (@@mode != 2) && @tglMNormal.active?
				@tglMNormal.active = false;
				@tglAventure.active = true;
				@@mode = 2;
				puts "Mode : Aventure - #{@@mode}";
			else if !(@tglAventure.active?) && !(@tglMNormal.active?)
				@tglAventure.active = true;
				@@mode = 2;
				puts "Mode : Aventure - #{@@mode}";
				end
			end
        }
        
        #2-Taille de grille : 7*7, 10*10 OU 15*15
		@tgl77.signal_connect('toggled') {
			
			if (@@taille != 1)  && (@tgl1010.active? || @tgl1515.active?)
				@tgl1010.active = false;
				@tgl1515.active = false;
				@tgl77.active = true;
				@@taille = 1;
				puts "Taille grille : 7*7 - #{@@taille}";
			else if !(@tgl77.active?) && !(@tgl1010.active?) && !(@tgl1515.active?)
					@tgl77.active = true;
					@@taille = 1;
					puts "Taille grille : 7*7 - #{@@taille}";
				end
			end
		}

		@tgl1010.signal_connect('toggled') {
						
			if (@@taille != 2) && (@tgl77.active? || @tgl1515.active?)
				@tgl77.active = false;
				@tgl1515.active = false;
				@tgl1010.active = true;
				@@taille = 2;
				puts "Taille grille : 10*10 - #{@@taille}";
			else if !(@tgl1010.active?) && !(@tgl77.active?) && !(@tgl1515.active?)
					@tgl1010.active = true;
					@@taille = 2;
					puts "Taille grille : 10*10 - #{@@taille}";
				end
			end
		}

		@tgl1515.signal_connect('toggled') {
			
			if (@@taille != 3) && (@tgl77.active? || @tgl1010.active?)
				@tgl77.active = false;
				@tgl1010.active = false;
				@tgl1515.active = true;
				@@taille = 3;
				puts "Taille grille : 15*15 - #{@@taille}";
			else if !(@tgl1515.active?) && !(@tgl77.active?) && !(@tgl1010.active?)
					@tgl1515.active = true;
					@@taille = 3;
					puts "Taille grille : 15*15 - #{@@taille}";
				end
			end
		}

		#3-Difficulté de la grille : Facile, Normal OU Difficile
		@tglFacile.signal_connect('toggled'){
		
			if (@@difficulte != 1) && (@tglNormal.active? || @tglDiff.active?)
				@tglNormal.active = false;
				@tglDiff.active = false;
				@tglFacile.active = true;
				@@difficulte = 1;
				puts "Difficultée : Facile - #{@@difficulte}";
			else if !(@tglFacile.active?) && !(@tglNormal.active?) && !(@tglDiff.active?)
					@tglFacile.active = true;
					@@difficulte = 1;
					puts "Difficultée : Facile - #{@@difficulte}";
				end
			end
		}

		@tglNormal.signal_connect('toggled'){
			if (@@difficulte != 2) && (@tglFacile.active? || @tglDiff.active?)
				@tglDiff.active = false;
				@tglFacile.active = false;
				@tglNormal.active = true;
				@@difficulte = 2;
				puts "Difficultée : Normale - #{@@difficulte}";
			else if !(@tglNormal.active?) && !(@tglFacile.active?) && !(@tglDiff.active?)
					@tglNormal.active = true;
					@@difficulte = 2;
					puts "Difficultée : Normale - #{@@difficulte}";
				end
			end
		}

		@tglDiff.signal_connect('toggled'){
			if (@@difficulte != 3) && (@tglFacile.active? || @tglNormal.active?)
				@tglFacile.active = false;
				@tglNormal.active = false;
				@tglDiff.active = true;
				@@difficulte = 3;
				puts "Difficultée : Difficile - #{@@difficulte}";
			else if !(@tglDiff.active?) && !(@tglFacile.active?) && !(@tglNormal.active?)
					@tglDiff.active = true;
					@@difficulte = 3;
					puts "Difficultée : Difficile - #{@@difficulte}";
				end
			end
		}
    end
    
	def changerFenetre()
		@jeu = JeuUI.new(@@mode, @@taille, @@difficulte,@pseudo,@window)       
    end
end

menu = Menu.new()
menu.afficheDemarrage()
