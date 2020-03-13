# encoding: UTF-8

##
# Auteur JOLLIET Corentin
# Version 0.1 : Date : Wed Dec 19 15:38:33 CET 2018
#
require 'gtk3'

class Builder < Gtk::Builder
	#Variables représentant les paramètres d'une grille
	@@mode = 1
	@@taille = 1
	@@difficulte = 1

	def initialize 
	    super()
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		puts "Création des variables d'instances"
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					puts "\tCreation de la variable d'instance @#{p.builder_name}"
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}
		@window1.show_all
		@window1.signal_connect('destroy') { puts "Tchao !"; Gtk.main_quit }
		
		# On connecte les signaux aux méthodes (qui doivent exister)
		
		puts "\nConnexion des signaux"

		#Signaux de destruction du jeu - Action : Quitter le Jeu
		@quitter.signal_connect('clicked') { puts "Tchao !"; Gtk.main_quit }
		@quitGame.signal_connect('clicked') { puts "Tchao !"; Gtk.main_quit }

		#[signal_connect] des boutons d'Aide, Règles et Astuces
		@help.signal_connect('clicked') { puts "A l'aide !"; }
		@help1.signal_connect('clicked') { puts "A l'aide !"; }
		@help2.signal_connect('clicked') { puts "A l'aide !"; }
		@help3.signal_connect('clicked') { puts "A l'aide !"; }

		
		
		@rules.signal_connect('clicked'){
					@window1.hide;
					@REGLES1.show_all
					puts "Regles in action"
					@@T = 1;
					 
		}
		@rules1.signal_connect('clicked') {
					@window2.hide;
					@REGLES1.show_all
					puts "Regles in action"
					@@T = 2;
					 
		}
		@rules2.signal_connect('clicked') {
					@window3.hide;
					@REGLES1.show_all
					puts "Regles in action"
					@@T = 3;
					 
		}
		@rules3.signal_connect('clicked') {
					@window4.hide;
					@REGLES1.show_all
					puts "Regles in action"
					@@T = 4;
					 
		}

			@Terminer.signal_connect('clicked') {
			
			if (@@T= 1)  
				@REGLES1.hide
				@window1.show
				puts "Pity"
			else if (@@T= 2)  
				@REGLES1.hide
				@window2.show
				puts "Pity"
			else if (@@T= 3)  
				@REGLES1.hide
				@window3.show
				puts "Pity"
			else if (@@T= 4)  
				@REGLES1.hide
				@window4.show
				puts "Pity";
				end
			end
			end
			end
		}

		@advices.signal_connect('clicked') { puts "*Pssst* File-moi une astuce."; }
		@advices1.signal_connect('clicked') { puts "*Pssst* File-moi une astuce."; }
		@advices2.signal_connect('clicked') { puts "*Pssst* File-moi une astuce."; }
		@advices3.signal_connect('clicked') { puts "*Pssst* File-moi une astuce."; }

		#Gestion des paramètres selon [Mode], [Taille] et [Difficulté]

		#1-Mode de jeu : Normal OU Aventure
		@modeNormal.signal_connect('toggled') {
			
			if (@@mode != 1) && @modeAventure.active?
				@modeAventure.active = false;
				@modeNormal.active = true;
				@@mode = 1;
				puts "Mode : Normal - #{@@mode}";
			else if !(@modeNormal.active?) && !(@modeAventure.active?)
				@modeNormal.active = true;
				@@mode = 1;
				puts "Mode : Normal - #{@@mode}";
				end
			end
		}
		
		@modeAventure.signal_connect('toggled') {
			
			if (@@mode != 2) && @modeNormal.active?
				@modeNormal.active = false;
				@modeAventure.active = true;
				@@mode = 2;
				puts "Mode : Aventure - #{@@mode}";
			else if !(@modeAventure.active?) && !(@modeNormal.active?)
				@modeAventure.active = true;
				@@mode = 2;
				puts "Mode : Aventure - #{@@mode}";
				end
			end
		}

		#2-Taille de grille : 7*7, 10*10 OU 15*15
		@taille77.signal_connect('toggled') {
			
			if (@@taille != 1)  && (@taille1010.active? || @taille1515.active?)
				@taille1010.active = false;
				@taille1515.active = false;
				@taille77.active = true;
				@@taille = 1;
				puts "Taille grille : 7*7 - #{@@taille}";
			else if !(@taille77.active?) && !(@taille1010.active?) && !(@taille1515.active?)
					@taille77.active = true;
					@@taille = 1;
					puts "Taille grille : 7*7 - #{@@taille}";
				end
			end
		}

		@taille1010.signal_connect('toggled') {
						
			if (@@taille != 2) && (@taille77.active? || @taille1515.active?)
				@taille77.active = false;
				@taille1515.active = false;
				@taille1010.active = true;
				@@taille = 2;
				puts "Taille grille : 10*10 - #{@@taille}";
			else if !(@taille1010.active?) && !(@taille77.active?) && !(@taille1515.active?)
					@taille1010.active = true;
					@@taille = 2;
					puts "Taille grille : 10*10 - #{@@taille}";
				end
			end
		}

		@taille1515.signal_connect('toggled') {
			
			if (@@taille != 3) && (@taille77.active? || @taille1010.active?)
				@taille77.active = false;
				@taille1010.active = false;
				@taille1515.active = true;
				@@taille = 3;
				puts "Taille grille : 15*15 - #{@@taille}";
			else if !(@taille1515.active?) && !(@taille77.active?) && !(@taille1010.active?)
					@taille1515.active = true;
					@@taille = 3;
					puts "Taille grille : 15*15 - #{@@taille}";
				end
			end
		}

		#3-Difficulté de la grille : Facile, Normal OU Difficile
		@diffFacile.signal_connect('toggled'){
		
			if (@@difficulte != 1) && (@diffNormal.active? || @diffDifficile.active?)
				@diffNormal.active = false;
				@diffDifficile.active = false;
				@diffFacile.active = true;
				@@difficulte = 1;
				puts "Difficultée : Facile - #{@@difficulte}";
			else if !(@diffFacile.active?) && !(@diffNormal.active?) && !(@diffDifficile.active?)
					@diffFacile.active = true;
					@@difficulte = 1;
					puts "Difficultée : Facile - #{@@difficulte}";
				end
			end
		}

		@diffNormal.signal_connect('toggled'){
			if (@@difficulte != 2) && (@diffFacile.active? || @diffDifficile.active?)
				@diffDifficile.active = false;
				@diffFacile.active = false;
				@diffNormal.active = true;
				@@difficulte = 2;
				puts "Difficultée : Normale - #{@@difficulte}";
			else if !(@diffNormal.active?) && !(@diffFacile.active?) && !(@diffDifficile.active?)
					@diffNormal.active = true;
					@@difficulte = 2;
					puts "Difficultée : Normale - #{@@difficulte}";
				end
			end
		}

		@diffDifficile.signal_connect('toggled'){
			if (@@difficulte != 3) && (@diffFacile.active? || @diffNormal.active?)
				@diffFacile.active = false;
				@diffNormal.active = false;
				@diffDifficile.active = true;
				@@difficulte = 3;
				puts "Difficultée : Difficile - #{@@difficulte}";
			else if !(@diffDifficile.active?) && !(@diffFacile.active?) && !(@diffNormal.active?)
					@diffDifficile.active = true;
					@@difficulte = 3;
					puts "Difficultée : Difficile - #{@@difficulte}";
				end
			end
		}

		#Navigation brute entre les fenêtres
		@back.signal_connect('clicked') { puts "Retour de l'Aventure !"; @window3.hide; @window1.show_all; }
		@continue.signal_connect('clicked') { puts "Fin de la Partie !"; @window2.hide; @window4.show_all; }
		
		@backEnd.signal_connect('clicked') {
			puts "Retour Vainqueur !";
			@window4.hide;
			if @@mode == 1
				@window1.show_all;
			else if @@mode == 2
				@window3.show_all;
				end
			end
		}
		
		@play.signal_connect('clicked'){
			
			if @modeNormal.active? || @modeAventure.active?
					@window1.hide;
				if (@@mode == 1) && (@modeNormal.active?)
					puts "*~Travail en cours~* - Accueil to Partie.";
					@window2.show_all;
				else
					if (@@mode == 2) && (@modeAventure.active?)
						puts "*~Travail en cours~* - Accueil to Aventure.";
						@window3.show_all;
					end
				end
			else 
				if @modeNormal.active? && @modeAventure.active?
					puts "Erreur : Trop de modes Actifs !"
				else puts "Erreur : Aucun mode Actif !"
				end
			end
		}
		
# 		self.connect_signals { |handler| 
# 				puts "\tConnection du signal #{handler}"
# 				begin
# 					method(handler) 
# 				rescue	
# 					puts "\t\t[Attention] Vous devez definir la methode #{handler} :\n\t\t\tdef #{handler}\n\t\t\t\t....\n\t\t\tend\n"
# 					self.class.send( :define_method, handler.intern) {
# 						puts "La methode #{handler} n'est pas encore définie.. Arrêt"
# 						Gtk.main_quit
# 					}
# 					retry
# 				end
# 		}	
	end

	# A partir d'ici on écrit le code

	
	
end

# On lance l'application
builder = Builder.new()
Gtk.main
