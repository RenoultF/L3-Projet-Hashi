
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020



require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/ChoixGrilleUI.rb'
require '../UI/ChoixGrilleScrollUI.rb'
require '../UI/JeuUI.rb'
require 'gtk3'



class RacineUI < Gtk::Box

  attr_reader :grilles

  def initialize()

    super(:vertical, 10)

    @menu = MenuUI.new(self)
    @choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))
    @jeu = JeuUI.new(self)

    pack_start(@menu, :expand => true, :fill => true)

    show_all

  end


  def choisirGrille(nomCompte, taille, difficulte)

    @choix.chargerGrille(nomCompte, taille, difficulte)
    pack_start(@choix, :expand => true, :fill => true)
    remove(@menu)
    remove(@jeu)
    show_all

  end

  def commencerPartie(grille, nomCompte)

    @jeu.chargerGrille(grille, nomCompte)
    pack_start(@jeu, :expand => true, :fill => true)
    remove(@menu)
    remove(@choix)
    show_all

  end

end
