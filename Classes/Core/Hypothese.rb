




class Hypothese

  #@grille => La sauvegarde de la grille
  attr_reader :grille

  def Hypothese.creer(grille)
    new(grille)
  end

  def initialize(grille)

    @grille = YAML.load(YAML.dump(grille)) #copie profonde

  end


  #Cette méthode permet d'afficher l'action
  def to_s
    @grille.to_s()
  end

end
