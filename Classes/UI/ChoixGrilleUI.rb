
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require 'gtk3'


class ChoixGrilleUI < Gtk::Box

  attr_reader :grilles
  attr_reader :window
  attr_reader :racine

  def initialize(racine)

    super(:vertical , 20)

    @racine = racine

  end

  def chargerGrille(nomCompte, taille, difficulte)

    @grilles = Gtk::Scrollbar.new(:vertical)

    liste = Sauvegarde.liste(Compte.recuperer(nomCompte), taille, difficulte)

    liste.each_with_index do |s, i|

      puts "TEST : #{@window}"

      temp = GrilleUI.new(s.getGrille(), 40)

      temp.signal_connect "button-press-event" do |widget, event|
        self.grilleChoisi(temp.grille())
      end

      temp.add_events([:button_press_mask])

      self.add(temp)


    end

    self.add(@grilles)

    show_all

  end


  def grilleChoisi(grille)

    @racine.commencerPartie(grille)

  end


end
