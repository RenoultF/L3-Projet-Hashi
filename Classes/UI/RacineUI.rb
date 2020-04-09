


require '../UI/GrilleUI.rb'
require '../UI/MenuUI.rb'
require '../UI/ChoixGrilleUI.rb'
require '../UI/JeuUI.rb'
require 'gtk3'



class RacineUI < Gtk::Box

  attr_reader :grilles

  def initialize()

    super(:vertical, 10)

    liste = Sauvegarde.liste(Compte.recuperer("polo"), 15, 2)


    self.add(@menu = MenuUI.new(self))

    @choix = ChoixGrilleUI.new(self)
    @scrollChoix = Gtk::ScrolledWindow.new()
    @scrollChoix.set_size_request(600, 600)
    @scrollChoix.set_policy(Gtk::PolicyType::AUTOMATIC, Gtk::PolicyType::AUTOMATIC)
    @scrollChoix.add_with_viewport(@choix)

    self.add(@scrollChoix)
    self.add(@jeu = JeuUI.new(self))
#    self.add(GrilleUI.new(liste[0].getGrille(), 40))
    @menu.show_all

  end



  def choisirGrille(nomCompte, taille, difficulte)

    @menu.hide
    @jeu.hide
    @choix.chargerGrille(nomCompte, taille, difficulte)
    @scrollChoix.show_all

  end

  def commencerPartie(grille)

    @menu.hide
    @scrollChoix.hide
    @jeu.chargerGrille(grille)
    @jeu.show_all

  end

end
