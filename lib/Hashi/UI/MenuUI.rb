


require_relative "../UI/ChoixNomUI.rb"
require_relative "../UI/ChoixTailleUI.rb"
require_relative "../UI/ChoixDifficulteUI.rb"
require_relative "../UI/FenetreReglesUI.rb"
require 'gtk3'

##
# PAS UTILISE DANS LE VERSION FINALE
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
class MenuUI < Gtk::Box

  attr_reader :choixNom

  attr_reader :choixTaille
  attr_accessor :taille

  attr_reader :choixDifficulte
  attr_accessor :difficulte

  attr_reader :racine

  def initialize(racine)

    super(:vertical, 0)

    @racine = racine

    @titre = Gtk::Label.new("Bienvenue dans le Hashiparmentier")

    @choixNom = ChoixNomUI.new(self)

    @choixTaille = ChoixTailleUI.new(self)
    @taille = 7

    @choixDifficulte = ChoixDifficulteUI.new(self)
    @difficulte = 0

    @regles = Gtk::Button.new(:label => "Règles")
    @regles.signal_connect "clicked" do
      afficheRegles()
    end

    @valide = Gtk::Button.new(:label => "Valider")
    @valide.signal_connect "clicked" do
      valide(@choixNom.entry.text(), @taille, @difficulte)
    end
    @fenetreRegles = FenetreReglesUI.new()
    @boxValide = Gtk::Box.new(:horizontal)
    @surBoxValide = Gtk::Box.new(:vertical)

    @boxValide.pack_start(@regles, :expand => true, :fill => true)
    @boxValide.pack_start(@valide)
    @boxValide.pack_start(Gtk::Alignment.new(0,0,0,0), :expand => true, :fill => true)
    @surBoxValide.pack_start(@boxValide, :expand => true)

  end

  def retourMenu()

    each_all do |c|
      remove(c)
    end

    pack_start(@titre, :expand => true, :fill => true)
    pack_start(@choixNom, :expand => true, :fill => true)
    pack_start(@choixTaille, :expand => true, :fill => true)
    pack_start(@choixDifficulte, :expand => true, :fill => true)
    pack_start(@surBoxValide, :expand => true, :fill => true)

  end


  private def valide(nomCompte, taille, difficulte)


    puts "Paramètres menu"
    print "Nom Compte : ", nomCompte, "\n"
    print "Taille grille : ", taille, "\n"
    print "Difficulte grille : ", difficulte, "\n"

    afficheLabel("Creation du compte en cours")


    Thread.new{@racine.choisirGrille(nomCompte, taille, difficulte)}

  end

  def afficheLabel(label)

    pack_start(@label = Gtk::Label.new(label), :expand => true, :fill => true)

    show_all

  end

  def afficheRegles

    @fenetreRegles.show_all

  end

end
