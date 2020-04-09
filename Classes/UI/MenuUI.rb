
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020



require "../UI/ChoixNomUI.rb"
require "../UI/ChoixTailleUI.rb"
require "../UI/ChoixDifficulteUI.rb"
require 'gtk3'


class MenuUI < Gtk::Box

  attr_reader :choixNom

  attr_reader :choixTaille
  attr_accessor :taille

  attr_reader :choixDifficulte
  attr_accessor :difficulte

  attr_reader :racine

  def initialize(racine)

    super(:vertical, 10)

    @racine = racine

    @choixNom = ChoixNomUI.new(self)

    @choixTaille = ChoixTailleUI.new(self)
    @taille = 7

    @choixDifficulte = ChoixDifficulteUI.new(self)
    @difficulte = 0

    @valide = Gtk::Button.new(:label => "Valider")
    @valide.signal_connect "clicked" do
      self.valide(@choixNom.text(), @taille, @difficulte)
    end

    self.add(@choixNom)
    self.add(@choixTaille)
    self.add(@choixDifficulte)
    self.add(@valide)

  end


  def valide(nomCompte, taille, difficulte)

    self.ajouteLabel("Creation du compte")

    Thread.new{@racine.choisirGrille(nomCompte, taille, difficulte)}

  end

  def ajouteLabel(label)

    self.add(Gtk::Label.new(label))

    self.show_all

  end


  def creationRecuperationCompte(nomCompte)

    begin

      Compte.recuperer(nomCompte)

    rescue => e

      puts e

      self.add(Gtk::Label.new("Creation du compte"))

      self.show_all

    end

  end

end
