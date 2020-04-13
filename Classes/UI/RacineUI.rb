

require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/Menu.rb'
require '../UI/ChoixGrilleUI.rb'
require '../UI/ChoixGrilleScrollUI.rb'
require '../UI/JeuUI.rb'
require '../UI/FinUI.rb'
require 'gtk3'


##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet de gérer le déroulement (et l'affichage) du jeu
#C'est le widget à ajjouter à la fenetre principale
#Elle possède une ensemble de méthode qui permette de passer d'une page à une autre
class RacineUI < Gtk::Box

  attr_reader :grilles

  #:nodoc:
  def initialize()

    super(:vertical, 10)

    @retourMenu = Gtk::Button.new(:label => "Retour menu") #Bouton temporaire de test
    @retourMenu.signal_connect "clicked" do
      retourMenu()
    end

    @quitter = Gtk::Button.new(:label => "Quitter") #Bouton temporaire de test
    @quitter.signal_connect "clicked" do
      if(!@jeu.eql?(nil))
        @jeu.sauvegardeGrille() #On sauvegarde la grille si on était en pleine partie
      end
      Gtk.main_quit
    end

    @boutons = Gtk::Box.new(:horizontal)
    @boutons.pack_start(@quitter)
    @boutons.pack_start(@retourMenu)

    retourMenu()

    show_all

  end
  #:doc:

  ##
  #Cette méthode permet d'afficher un ChoixGrilleScrollUI
  #Elle supprime tous les child de la RacineUI et ajoute le ChoixGrilleScrollUI
  #param::
  # * nomCompte Le nom du compte pour lequel on va chercher les grilles
  # * taille La taille des grilles à aller chercher
  # * difficulte La difficulté des grilles à aller chercher
  def choisirGrille(nomCompte, taille, difficulte)
    puts "dans choisirGrille"
    @choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))
    @choix.chargerGrille(nomCompte, taille, difficulte)

    removeChild()

    pack_start(@choix, :expand => true, :fill => true)
    pack_start(@boutons)
    show_all

  end


  ##
  #Cette méthode permet d'afficher un JeuUI
  #Elle supprime tous les child de la RacineUI et ajoute le JeuUI
  #param::
  # * grille La grille avec laquelle on va jouer
  # * nomCompte Le nom du compte qui va jouer
  def commencerPartie(grille, nomCompte)

    @jeu = JeuUI.new(self)
    @jeu.chargerGrille(grille, nomCompte)

    removeChild()

    pack_start(@jeu, :expand => true, :fill => true)
    pack_start(@boutons)
    show_all

  end

  ##
  #Cette méthode permet d'afficher un FinUI
  #Elle supprime tous les child de la RacineUI et ajoute la FinUI
  #param::
  # * taille La taille de la grille que l'on vient de finir
  # * difficulte La difficulte de la grille que l'on vient de finir
  # Les paramètres taille et difficulte ne sont pas obligatoires
  def finirPartie(taille = 7, difficulte = 0)

    @fin = FinUI.new(self)
    @fin.reussi(taille, difficulte)

    removeChild()

    pack_start(@fin, :expand => true, :fill => true)
    pack_start(@boutons)
    show_all

  end

  ##
  #Cette méthode permet d'afficher un MenuUI
  #Elle supprime tous les child de la RacineUI et ajoute la MenuUI
  def retourMenu()

    @menu = Menu.new(self)

    if(!@jeu.eql?(nil))
      @jeu.sauvegardeGrille() #On sauvegarde la grille si on était en pleine partie
    end
    @menu.retourMenu()

    removeChild()

    pack_start(@menu, :expand => true, :fill => true)
    show_all

  end

  ##
  #Cette méthode permet de supprimer tous les child de la RacineUI
  def removeChild
    each_all do |c|
      remove(c)
    end
  end

end
