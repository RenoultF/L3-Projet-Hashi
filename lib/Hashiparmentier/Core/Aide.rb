

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente les aides de notre grille
class Aide

  #@grille => La grille sur laquelle on va donner des informations
  attr_reader :grille

  ##
  #Ce constructeur permet de créer une nouvelle aide pour une grille
  #param::
  # * grille La grille sur laquelle on va donner des informations
  def initialize(grille)
    @grille = grille
  end

  ##
  #Cette méthode permet de donner de l'aide pour la résolution de la grille
  def aider()

  end

end
