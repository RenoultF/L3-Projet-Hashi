
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

    super(:vertical, 0)

    @racine = racine

    @titre = Gtk::Label.new("Bienvenue dans le Hashiparmenier")

    @choixNom = ChoixNomUI.new(self)

    @choixTaille = ChoixTailleUI.new(self)
    @taille = 7

    @choixDifficulte = ChoixDifficulteUI.new(self)
    @difficulte = 0

    @valide = Gtk::Button.new(:label => "Valider")
    @valide.signal_connect "clicked" do
      self.valide(@choixNom.entry.text(), @taille, @difficulte)
    end

    pack_start(@titre, :expand => true, :fill => true)
    pack_start(@choixNom, :expand => true, :fill => true)
    pack_start(@choixTaille, :expand => true, :fill => true)
    pack_start(@choixDifficulte, :expand => true, :fill => true)
    pack_start(@valide, :expand => true, :fill => true)

  end


  def valide(nomCompte, taille, difficulte)

    puts "Paramètres menu"
    print "Nom Compte : ", nomCompte, "\n"
    print "Taille grille : ", taille, "\n"
    print "Difficulte grille : ", difficulte, "\n"

    afficheLabel("Creation du compte")

    Thread.new{@racine.choisirGrille(nomCompte, taille, difficulte)}

  end

  def afficheLabel(label)

    if(!@label.eql?(nil))
      remove(@label)
    end

    pack_start(@label = Gtk::Label.new(label), :expand => true, :fill => true)

    show_all

  end


  def creationRecuperationCompte(nomCompte)

    begin

      Compte.recuperer(nomCompte)

    rescue => e

      puts e

      pack_start(Gtk::Label.new("Creation du compte"), :expand => true, :fill => true)

      self.show_all

    end

  end

end
