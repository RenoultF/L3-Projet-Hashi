require 'gtk3'

require_relative "../UI/FenetreJeuUI.rb"
require_relative "../UI/AideUI.rb"
require_relative "../UI/AstucesUI.rb"
require_relative "../UI/ReglesUI.rb"
require_relative "../UI/ChoixGrilleUI.rb"
require_relative "../UI/ChoixGrilleScrollUI.rb"
require_relative "../CSS/Style.rb"



class Menu < Gtk::Box
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
	@@taille = 7
	@@difficulte = 0

	 def initialize()
		super(:vertical, 0)
		@builder = Gtk::Builder.new
		#@racine = racine
		self.afficheDemarrage()
     end

     def afficheDemarrage()
		if(@window != nil) then
			@window.destroy()
		end
		@builder.add_from_file("lib/Hashi/glade/menu.glade")

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

			# -- LABEL
			@lbTaille = @builder.get_object("lbTaille")
			@lbTaille.style_context.add_provider(@@CSS_LABEL_MENU, Gtk::StyleProvider::PRIORITY_USER)
			@lbDiff = @builder.get_object("lbDiff")
			@lbDiff.style_context.add_provider(@@CSS_LABEL_MENU, Gtk::StyleProvider::PRIORITY_USER)
			@lbTaille = @builder.get_object("lbTaille")
			@lbTaille.style_context.add_provider(@@CSS_LABEL_MENU, Gtk::StyleProvider::PRIORITY_USER)
			@lbPseudo = @builder.get_object("lbPseudo")
			@lbPseudo.style_context.add_provider(@@CSS_LABEL_MENU, Gtk::StyleProvider::PRIORITY_USER)

			@btnQuitter.style_context.add_provider(@@CSS_BTN_BOTMENU, Gtk::StyleProvider::PRIORITY_USER)
			@btnJouer.style_context.add_provider(@@CSS_BTN_BOTMENU, Gtk::StyleProvider::PRIORITY_USER)

            @btnAide.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)
            @btnRegles.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)
            @btnAstuces.style_context.add_provider(@@CSS_BTN_TOPMENU, Gtk::StyleProvider::PRIORITY_USER)


		# --- ENTRY
			@pseudo = @builder.get_object("entryPseudo")

		# --- CSS
		@window.style_context.add_provider(@@CSS_BG_MENU, Gtk::StyleProvider::PRIORITY_USER)
		@tglMNormal.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
		@tglAventure.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        @tgl77.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        @tgl1010.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        @tgl1515.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        @tglFacile.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        @tglNormal.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
		@tglDiff.style_context.add_provider(@@CSS_BUTTON_ACTIVE, Gtk::StyleProvider::PRIORITY_USER)
        # --- SIGNAUX ---
            # --- WINDOWS ---
            @window.signal_connect('destroy') { |_widget| Gtk.main_quit }

            # --- BTN ---
            @btnQuitter.signal_connect('clicked') { |_widget| Gtk.main_quit }
            @btnJouer.signal_connect('clicked') { |_widget| valide() }
            @btnAide.signal_connect('clicked') { |_widget| AfficherAide() }
            @btnRegles.signal_connect('clicked') { |_widget| AfficherRegles()  }
		    @btnAstuces.signal_connect('clicked') { |_widget| AfficherAstuces() }

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

			if (@@taille != 7)  && (@tgl1010.active? || @tgl1515.active?)
				@tgl1010.active = false;
				@tgl1515.active = false;
				@tgl77.active = true;
				@@taille = 7;
				puts "Taille grille : 7*7 - #{@@taille}";
			else if !(@tgl77.active?) && !(@tgl1010.active?) && !(@tgl1515.active?)
					@tgl77.active = true;
					@@taille = 7;
					puts "Taille grille : 7*7 - #{@@taille}";
				end
			end
		}

		@tgl1010.signal_connect('toggled') {

			if (@@taille != 10) && (@tgl77.active? || @tgl1515.active?)
				@tgl77.active = false;
				@tgl1515.active = false;
				@tgl1010.active = true;
				@@taille = 10;
				puts "Taille grille : 10*10 - #{@@taille}";
			else if !(@tgl1010.active?) && !(@tgl77.active?) && !(@tgl1515.active?)
					@tgl1010.active = true;
					@@taille = 10;
					puts "Taille grille : 10*10 - #{@@taille}";
				end
			end
		}

		@tgl1515.signal_connect('toggled') {

			if (@@taille != 15) && (@tgl77.active? || @tgl1010.active?)
				@tgl77.active = false;
				@tgl1010.active = false;
				@tgl1515.active = true;
				@@taille = 15;
				puts "Taille grille : 15*15 - #{@@taille}";
			else if !(@tgl1515.active?) && !(@tgl77.active?) && !(@tgl1010.active?)
					@tgl1515.active = true;
					@@taille = 15;
					puts "Taille grille : 15*15 - #{@@taille}";
				end
			end
		}

		#3-Difficulté de la grille : Facile, Normal OU Difficile
		@tglFacile.signal_connect('toggled'){

			if (@@difficulte != 0) && (@tglNormal.active? || @tglDiff.active?)
				@tglNormal.active = false;
				@tglDiff.active = false;
				@tglFacile.active = true;
				@@difficulte = 0;
				puts "Difficultée : Facile - #{@@difficulte}";
			else if !(@tglFacile.active?) && !(@tglNormal.active?) && !(@tglDiff.active?)
					@tglFacile.active = true;
					@@difficulte = 0;
					puts "Difficultée : Facile - #{@@difficulte}";
				end
			end
		}

		@tglNormal.signal_connect('toggled'){
			if (@@difficulte != 1) && (@tglFacile.active? || @tglDiff.active?)
				@tglDiff.active = false;
				@tglFacile.active = false;
				@tglNormal.active = true;
				@@difficulte = 1;
				puts "Difficultée : Normale - #{@@difficulte}";
			else if !(@tglNormal.active?) && !(@tglFacile.active?) && !(@tglDiff.active?)
					@tglNormal.active = true;
					@@difficulte = 1;
					puts "Difficultée : Normale - #{@@difficulte}";
				end
			end
		}

		@tglDiff.signal_connect('toggled'){
			if (@@difficulte != 2) && (@tglFacile.active? || @tglNormal.active?)
				@tglFacile.active = false;
				@tglNormal.active = false;
				@tglDiff.active = true;
				@@difficulte = 2;
				puts "Difficultée : Difficile - #{@@difficulte}";
			else if !(@tglDiff.active?) && !(@tglFacile.active?) && !(@tglNormal.active?)
					@tglDiff.active = true;
					@@difficulte = 2;
					puts "Difficultée : Difficile - #{@@difficulte}";
				end
			end
		}
	end

	def AfficherAide()
		@aide = AideUI.new()
	end

	def AfficherRegles()
		@regles = ReglesUI.new()
	end

	def AfficherAstuces()
		@astuces = AstucesUI.new()
	end

	def removeChild(fenetre)
		fenetre.each_all do |c|
		  remove(c)
		end
	end

	def commencerPartie(grille,nomCompte)
		@fenetreScroll.hide
		@jeu = FenetreJeuUI.new(@@mode, grille,nomCompte,@window,@fenetreScroll)
	end

	def retourMenu()

		each_all do |c|
		  remove(c)
		end

		pack_start(@titre, :expand => true, :fill => true)
		pack_start(@choixNom, :expand => true, :fill => true)
		pack_start(@choixTaille, :expand => true, :fill => true)
		pack_start(@choixDifficulte, :expand => true, :fill => true)
		pack_start(@surBoxValide, :expand => true, :fill => true)

	end


	private def valide()


		puts "Paramètres menu"
		print "Nom Compte : ", @pseudo.text(), "\n"
		print "Taille grille : ", @@taille, "\n"
		print "Difficulte grille : ", @@difficulte, "\n"

		afficheLabel("Creation du compte en cours")

		@window.hide()
		@fenetreScroll = Gtk::Window.new()
		@fenetreScroll.set_title("Scroll")
		boxScroll = Gtk::Box.new(:horizontal)
		choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))
		choix.chargerGrille(@pseudo.text(),@@taille,@@difficulte)
		boxScroll.pack_start(choix, :expand => true, :fill => true)
		@fenetreScroll.add(boxScroll)
		@fenetreScroll.set_window_position(Gtk::WindowPosition::CENTER)
		@fenetreScroll.maximize
		@fenetreScroll.show_all

		#Thread.new{@racine.choisirGrille(@pseudo.text(), @@taille, @@difficulte)}

	end

	def afficheLabel(label)

		pack_start(@label = Gtk::Label.new(label), :expand => true, :fill => true)

		show_all

	end

	def afficheRegles
		@fenetreRegles.show_all
	end

end

#menu = Menu.new()
# menu.afficheDemarrage()
