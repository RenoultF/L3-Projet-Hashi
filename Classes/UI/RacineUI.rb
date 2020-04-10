
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020



require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/ChoixGrilleUI.rb'
require '../UI/ChoixGrilleScrollUI.rb'
require '../UI/JeuUI.rb'
require '../UI/FinUI.rb'
require 'gtk3'



class RacineUI < Gtk::Box

  attr_reader :grilles

  def initialize()

    super(:vertical, 10)

    @menu = MenuUI.new(self)
    @choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))
    @jeu = JeuUI.new(self)
    @fin = FinUI.new(self)


    @retourMenu = Gtk::Button.new(:label => "Retour menu")
    @retourMenu.signal_connect "clicked" do
      retourMenu()
    end

    @quitter = Gtk::Button.new(:label => "Quitter")
    @quitter.signal_connect "clicked" do
      Gtk.main_quit
    end

    @boutons = Gtk::Box.new(:horizontal)
    @boutons.pack_start(@quitter)
    @boutons.pack_start(@retourMenu)

    @menu.retourMenu()
    pack_start(@menu, :expand => true, :fill => true)

    show_all

  end


  def choisirGrille(nomCompte, taille, difficulte)



    @choix.chargerGrille(nomCompte, taille, difficulte)

    each_all do |c|
      remove(c)
    end

    pack_start(@choix, :expand => true, :fill => true)
    pack_start(@boutons)
    show_all

  end

  def commencerPartie(grille, nomCompte)

    @jeu.chargerGrille(grille, nomCompte)

    each_all do |c|
      remove(c)
    end

    pack_start(@jeu, :expand => true, :fill => true)
    pack_start(@boutons)

    show_all

  end

  def finirPartie(taille, difficulte)

    @fin.reussi(taille, difficulte)
    each_all do |c|
      remove(c)
    end
    pack_start(@fin, :expand => true, :fill => true)
    pack_start(@boutons)
    show_all

  end

  def retourMenu()

    @menu.retourMenu()
    each_all do |c|
      remove(c)
    end
    pack_start(@menu, :expand => true, :fill => true)
    show_all

  end

end
