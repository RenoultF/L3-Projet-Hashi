

require "../UI/GrilleJouableUI.rb"
require 'gtk3'


class JeuUI < Gtk::Box

  attr_reader :grilles
  attr_reader :window
  attr_reader :racine

  def initialize(racine)

    super(:vertical , 20)

    @racine = racine

  end

  def chargerGrille(grille)

    @grille = GrilleJouableUI.new(grille)

    self.add(@grille)

    show_all

  end


  def grilleChoisi(grille)

    @racine.commancerPartie(grille)

  end


end
