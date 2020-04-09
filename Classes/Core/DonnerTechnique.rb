

require "../Core/Aide.rb"

class DonnerTechnique < Aide

  def DonnerTechnique.creer(grille)
    new(grille)
  end

  def initialize(grille)
    super(grille)
  end


  def aider()#Verifier si la grille est correcte
    archipelle = false
    for i in (0..@grille.tailleX - 1)
      for j in (0..@grille.tailleY - 1)
        cGrille = @grille.getCase(i, j)
        if(cGrille.estIle?())
          capa = cGrille.getCapaciteResiduelle()
          nChemins = cGrille.getNombreCheminDisponible()
          nDirection = cGrille.getNombreDirectionConstructible()
          puts capa, nChemins
          if(capa > 0)
            if(capa == nChemins)
              return "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nChemins.to_s() + " chemins disponibles"
            elsif(capa == nChemins - 1 && nDirection <= capa)
              return "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nDirection.to_s() + " directions disponibles"
            elsif(capa == 1)
              archipelle = true
            end
          end
        end
      end
    end
    if(archipelle)
      return "Attention à ne pas former d'archipelle"
    end
    return "Pas d'aide disponible"
  end

end
