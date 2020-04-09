
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020


require 'gtk3'

##
#Cette classe permet à l'utilisateur de choisir entre plusieurs grilles proposées
class ChoixGrilleUI < Gtk::Box

  attr_reader :grilles
  attr_reader :window
  attr_reader :racine
  attr_reader :tailleTotal

  ##
  #Ce constructeur permet de créer un nouveau ChoixGrilleUI
  #param :
  # * racine L'objet auquel on envera les parametres choisi à l'aide de la méthode grilleChoisie
  def initialize(racine)

    super(:vertical , 20)

    @racine = racine

  end

  ##
  #Cette méthode permet de charger un ensemble de grille pour les montrer à l'utilisateur
  #param :
  # * nomcompte Le nom du compte dont-on va récuperer les grilles
  # * taille La taille des grilles à récuperer
  # * difficulte La difficulte des grilles à récuperer
  def chargerGrille(nomCompte, taille, difficulte)

    tailleCase = 40
    @tailleTotal = 0

    liste = Sauvegarde.liste(Compte.recuperer_ou_creer(nomCompte), taille, difficulte)

    liste.each_with_index do |s, i|

      puts "TEST : #{@window}"

      temp = GrilleUI.new(s.getGrille(), tailleCase)

      temp.signal_connect "button-press-event" do |widget, event|
        grilleChoisie(temp.grille(), nomCompte)
      end

      temp.add_events([:button_press_mask])

      self.add(temp)
      @tailleTotal += tailleCase * taille + 10

    end

    show_all

  end


  private def grilleChoisie(grille, nomCompte)

    @racine.commencerPartie(grille, nomCompte)

  end


end
