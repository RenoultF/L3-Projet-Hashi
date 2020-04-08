


require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/ChoixGrilleUI.rb'
require 'gtk3'



class RacineUI < Gtk::Box

  attr_reader :grilles

  def initialize()

    super(:vertical, 10)

#    liste = Sauvegarde.liste(Compte.recuperer("polo"), 7, 0)


    self.add(@menu = MenuUI.new())

    @choix = ChoixGrilleUI.new()
  #  temp = Gtk::ScrolledWindow.new()
  #  temp.set_size_request(800, 800)
  #  temp.add(@choix)
    self.add(@choix)
#    self.add(@jeu = JeuUI.new())
#    self.add(GrilleUI.new(liste[0].getGrille(), 40))
    show_all

  end



  def choisiGrille(nomCompte, taille, difficulte)

    @menu.hide
#    @jeu.hide
    @choix.chargerGrille(nomCompte, taille, difficulte)
    @choix.show_all

  end
=begin
  def commencerPartie(grille)

    @menu.hide
    @choix.hide
    @jeu.chargerGrille(grille)
    @jeu.show_all

  end
=end
end
