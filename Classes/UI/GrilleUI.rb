
require "../Core/Grille.rb"

require "../UI/CaseUI.rb"
require "../UI/IleUI.rb"
require "../UI/PontUI.rb"
require "gtk3"


##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet d'afficher une grille de hashi
class GrilleUI < Gtk::DrawingArea

  attr_accessor :grille

  ##
  #Ce constructeur permet de créer un nouveau afficheur de grille
  #param::
  # * grille La grille que l'on veut afficher
  # * taille La taille des cases de la grille (40 par default)
  def initialize(grille, taille = 40)

    super()

    @grille = grille
    @mat = Array.new(@grille.tailleX()) { Array.new(@grille.tailleY()) }
    @taille = taille

    init()

    signal_connect "draw" do
      on_draw()
    end

  end

  private def init()

    self.set_size_request(@grille.tailleY() * @taille, @grille.tailleX() * @taille)

    for i in 0..(@grille.tailleX()-1)
      for j in 0..(@grille.tailleY()-1)
        c = @grille.getCase(i, j)
        if(c.estIle?())
          @mat[i][j] = IleUI.creer(c, @taille)
        elsif(c.estPont?())
          @mat[i][j] = PontUI.creer(c, @taille)
        else
          @mat[i][j] = CaseUI.creer(c, @taille)
        end

      end
    end

  end

  ##
  #Cette méthode permet de modifier la grille que l'on affiche
  #Méthode utilisé par la suppression d'hypothèses
  #param::
  # * grille La nouvelle grille à afficher
  def grille=(grille)

    @grille = grille

    init()

  end

  ##
  #Cette méthode permet de retourner une case à une position donnée
  #param::
  # * i La position en abscisse
  # * j La position en ordonnée
  #return::
  # * La case à la position [i][j]
  def getCase(i, j)

    return @mat[i][j]

  end

  ##
  #Cette méthode permet de savoir si une position donnée est dans les limites de la grille
  #param::
  # * i La position en abscisse
  # * j La position en ordonnée
  #return::
  # * true si les coordonnées sont en dehors de la grille, false sinon
  def sortLimite?(i, j)

    return @grille.sortLimite?(i, j)

  end


  ##
  #Cette méthode permet de dessiner la grille
  #Appelé automatique en la connectant au signal "draw"
  def on_draw()

    draw(self.window)

    @mat.each do |l|
      l.each do |c|
        c.draw(self.window)
      end
    end

    self.queue_draw()

  end


  private def draw(window)

    cr = window.create_cairo_context

    cr.set_source_rgb(255, 255, 255)
    cr.rectangle(0, 0, @taille * @grille.tailleY(), @taille * @grille.tailleX())
    cr.fill()

  end

  ##
  #Cette méthode permet de sauvegarder la grille que l'on est en train d'afficher
  #param::
  # * compte Le compte auquel associer la sauvegarde
  def sauvegarder(compte)

    @grille.sauvegarder(compte)

  end

  ##
  #Cette méthode permet de réinitialiser le grille que l'on affiche
  def recommencer()

    @grille.recommencer()

  end

end
