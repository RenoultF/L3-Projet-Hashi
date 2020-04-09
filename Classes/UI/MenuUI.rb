


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

    @racine.choisirGrille(nomCompte, taille, difficulte)

  end

end
