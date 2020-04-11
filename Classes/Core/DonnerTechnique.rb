

require "../Core/Aide.rb"

class DonnerTechnique < Aide

  def DonnerTechnique.creer(grille)
    new(grille)
  end

  def initialize(grille)
    super(grille)
  end


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
          if(!@grille.getDernierIle.eql?(nil))
            puts "Capacite, Chemins, Direction : ", @grille.getDernierIle.getCapaciteResiduelle, @grille.getDernierIle.getNombreCheminDisponible, @grille.getDernierIle.getNombreDirectionConstructible
          end
          if(capa > 0)
            if(capa == nChemins)
              cheminComplet = true
              messageComplet = "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nChemins.to_s() + " ponts disponibles"
            elsif(capa == nChemins - 1 && nDirection <= capa)
              cheminIncomplet = true
              messageIncomplet = "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nDirection.to_s() + " directions disponibles"
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
    return message + "\nAttention s'il y a une erreur dans la grille la technique peut-être érronée"
  end

end
