


##
# Auteur Brabant Mano
# Version 0.1 : Date : 19/03/2020



##
#Cette classe représente les hypothèse (une sauvegarde de la grille à un certain moment)
class Hypothese


  ##
  #Ce constructeur permet de créer une nouvelle hyoothèse
  def Hypothese.creer(grille)
    new(grille)
  end

  #:nodoc:
  def initialize(grille)

    @grille = Marshal.dump(grille) #copie profonde

  end
  #:doc:


  #Cette méthode permet d'afficher l'hypothèse
  def to_s
    @grille.to_s()
  end

  ##
  #Cette méthode permet de récuperer la grille
  def getGrille()
    return Marshal.load(@grille)
  end

end
