

##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require "../UI/ChoixGrilleUI.rb"
require 'gtk3'

##
#Cette classe permet de créer une barre de défilement pour un ChoixGrilleUI
class ChoixGrilleScrollUI < Gtk::ScrolledWindow

  attr_reader :choixGrille

  ##
  #Ce constructeur permet de créer une nouvelle barre de défilement
  #param :
  # * grille Le ChoixGrilleUI à défiler
  def initialize(grille)

    super()

    @choixGrille = grille

    self.set_policy(Gtk::PolicyType::AUTOMATIC, Gtk::PolicyType::AUTOMATIC)
    self.add_with_viewport(@choixGrille)

  end

  ##
  #Cette méthode permet d'appeler chargerGrille du ChoixGrilleUI et d'adapter la taille de la barre de défilement
  def chargerGrille(nomCompte, taille, difficulte)

    @choixGrille.chargerGrille(nomCompte, taille, difficulte)
    show_all

  end


end
