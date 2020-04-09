
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

    liste = Sauvegarde.liste(Compte.recuperer("polo"), 15, 2)


    self.add(@menu = MenuUI.new(self))

    @choix = ChoixGrilleScrollUI.new(ChoixGrilleUI.new(self))

    self.add(@choix)
    self.add(@jeu = JeuUI.new(self))
#    self.add(GrilleUI.new(liste[0].getGrille(), 40))
    @menu.show_all

  end



  def choisirGrille(nomCompte, taille, difficulte)

    @menu.hide
    @jeu.hide
    @choix.chargerGrille(nomCompte, taille, difficulte)
    @choix.show_all

  end

  def commencerPartie(grille)

    @menu.hide
    @choix.hide
    @jeu.chargerGrille(grille)
    @jeu.show_all

  end

end
