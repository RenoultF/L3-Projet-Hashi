

##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require "../UI/ChoixGrilleUI.rb"
require 'gtk3'


class ChoixGrilleScrollUI < Gtk::ScrolledWindow

  attr_reader :choixGrille


  def initialize(grille)

    super()

    @choixGrille = grille

    self.set_size_request(300, 300)
    self.set_policy(Gtk::PolicyType::AUTOMATIC, Gtk::PolicyType::AUTOMATIC)
    self.add_with_viewport(@choixGrille)

  end

  def chargerGrille(nomCompte, taille, difficulte)

    @choixGrille.chargerGrille(nomCompte, taille, difficulte)

  end


end
