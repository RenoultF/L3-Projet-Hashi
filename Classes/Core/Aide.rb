

##
#Cette classe represente les aides de notre grille
class Aide

  #@grille => La grille sur laquelle on va donner des informations
  attr_reader :grille

  ##
  #Ce constructeur permet de créer une nouvelle aide pour une grille
  #param :
  # * grille La grille sur laquelle on va donner des informations
  def initialize(grille)
    @grille = grille
  end

end
