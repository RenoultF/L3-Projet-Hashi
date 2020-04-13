
require '../Core/Sauvegarde.rb'
require '../Core/Compte.rb'
require '../Core/ConnectSqlite3.rb'
require 'gtk3'


##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet à l'utilisateur de choisir entre plusieurs grilles proposées
class ChoixGrilleUI < Gtk::Box

  #@racine => L'objet auquel on va envoyer la grille que l'on a choisi (il doit definir commencerPartie(grille, nomCompte))
  attr_reader :racine

  ##
  #Ce constructeur permet de créer un nouveau ChoixGrilleUI
  #param::
  # * racine Un objet qui doit définir une méthode commencerPartie(grille, nomCompte) qui sera appelée quand l'utilisateur aura choisi une grille
  def initialize(racine)

    super(:vertical , 20)
    @racine = racine

  end

  ##
  #Cette méthode permet de charger un ensemble de grille pour les montrer à l'utilisateur
  #param::
  # * nomcompte Le nom du compte dont-on va récuperer les grilles
  # * taille La taille des grilles à récuperer
  # * difficulte La difficulte des grilles à récuperer
  def chargerGrille(nomCompte, taille, difficulte)
    puts "dans charger grille choixGRilleUI"
    puts "nomCompte", nomCompte,"taille", taille,"difficulte", difficulte
    
    tailleCase = 40

    liste = Sauvegarde.liste(Compte.recuperer_ou_creer(nomCompte), taille, difficulte)
    p liste
    liste.each_with_index do |s, i|
      puts "liste.each"
      box = Gtk::Box.new(:horizontal)
      bouton = Gtk::Button.new(:label => "Réinitialiser")
      temp = GrilleUI.new(s.getGrille(), tailleCase)

      bouton.signal_connect "clicked" do |widget, event|
        temp.grille().recommencer()
        temp.grille().sauvegarder(Compte.recuperer(nomCompte))
      end

      temp.signal_connect "button-press-event" do
        grilleChoisie(temp.grille(), nomCompte)
      end
      temp.add_events([:button_press_mask])

      box.add(temp)
      box.add(bouton)

      add(box)

    end
    show_all

  end


  private def grilleChoisie(grille, nomCompte)

    @racine.commencerPartie(grille, nomCompte)

  end


end
