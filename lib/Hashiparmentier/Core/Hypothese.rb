


##
#PAS UTILISE DANS LA VERSION FINALE
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente une hypothèse (une sauvegarde de la grille à un certain moment)
class Hypothese

  #@grille => La grille supposée()


  ##
  #Ce constructeur permet de créer une nouvelle hypothèse
  #param::
  # * grille La grille que l'on suppose
  def Hypothese.creer(grille)
    new(grille)
  end

  #:nodoc:
  def initialize(grille)
    @grille = Marshal.dump(grille) #copie profonde
  end
  #:doc:

  ##
  #Cette méthode permet d'afficher l'hypothèse
  def to_s
    @grille.to_s()
  end

  ##
  #Cette méthode permet de récuperer la grille
  #return::
  # * La grille que l'on a supposé
  def getGrille()
    return Marshal.load(@grille)
  end

end
