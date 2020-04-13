


require "../UI/ChoixGrilleUI.rb"
require 'gtk3'

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet de créer une barre de défilement pour un ChoixGrilleUI
class ChoixGrilleScrollUI < Gtk::ScrolledWindow

  #@choixGrille => Le ChoixGrilleUI à faire défiler
  attr_reader :choixGrille

  ##
  #Ce constructeur permet de créer une nouvelle barre de défilement
  #param::
  # * grille Le ChoixGrilleUI à défiler
  def initialize(grille)

    super()
    @choixGrille = grille
    self.set_policy(Gtk::PolicyType::AUTOMATIC, Gtk::PolicyType::AUTOMATIC)
    self.add_with_viewport(@choixGrille)

  end

  ##
  #Cette méthode permet d'appeler chargerGrille du ChoixGrilleUI
  def chargerGrille(nomCompte, taille, difficulte)
    @choixGrille.chargerGrille(nomCompte, taille, difficulte)
  end

end
