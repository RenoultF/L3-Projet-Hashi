

require_relative "../Core/Aide.rb"

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet de donner de l'aide pour résoudre une grille
#
#Hérite de Aide
class DonnerTechnique < Aide

  ##
  #Ce constructeur permet de créer une nouvelle aide
  #param::
  # * grille La grille sur laquelle on va donner des aides
  def DonnerTechnique.creer(grille)
    new(grille)
  end

  #:nodoc:
  def initialize(grille)
    super(grille)
  end
  #:doc:

  ##
  #L'aide apporté ici est une phrase qui indique des informations sur une ile qui peut poser de façon évidente des ponts
  #
  #Par exemple une ile qui ne possède qu'un seul voisin
  def aider()
    archipelle = false
    cheminComplet = false
    cheminIncomplet = false
    for i in (0..@grille.tailleX - 1)
      for j in (0..@grille.tailleY - 1)
        cGrille = @grille.getCase(i, j)
        if(cGrille.estIle?())
          capa = cGrille.getCapaciteResiduelle()
          nChemins = cGrille.getNombreCheminDisponible()
          nDirection = cGrille.getNombreDirectionConstructible()
          if(capa > 0)
            if(capa == nChemins)  #Alors le placement est évident
              cheminComplet = true
              messageComplet = "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nChemins.to_s() + " ponts disponibles"
            elsif(capa == nChemins - 1 && nDirection <= capa) #On peut placer un pont simple dans (capa - nDirection + 1) directions
              cheminIncomplet = true
              messageIncomplet = "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nChemins.to_s() + " ponts disponibles dans " + nDirection.to_s() + " directions possible"
            elsif(capa == 1)
              archipelle = true
            end
          end
        end
      end
    end
    if(cheminComplet)
      message = messageComplet
    elsif(cheminIncomplet)
      message = messageIncomplet
    elsif(archipelle)
      message = "Attention à ne pas former d'archipelle"
    else
      message ="Pas d'aide disponible"
    end
    return message + "\nAttention s'il y a une erreur dans la grille la technique peut-être erronée"
  end

end
