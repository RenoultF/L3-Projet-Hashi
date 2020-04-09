
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

    self.add(@menu = MenuUI.new(self))

    @choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))

    self.add(@choix)
    self.add(@jeu = JeuUI.new(self))
    @menu.show_all

  end



  def choisirGrille(nomCompte, taille, difficulte)


    @choix.chargerGrille(nomCompte, taille, difficulte)
    @menu.hide
    @jeu.hide
    @choix.show_all

  end

  def commencerPartie(grille, nomCompte)


    @jeu.chargerGrille(grille, nomCompte)
    @menu.hide
    @choix.hide
    @jeu.show_all

  end

end
