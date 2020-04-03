



class DonnerTechnique < Aide

  def DonnerTechnique.creer(grille)
    new(grille)
  end

  def initialize(grille)
    super(grille)
  end


  def aider()
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
              puts "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nChemins.to_s() + " chemins disponibles"
              return true
            elsif(capa == nChemins - 1 && nDirection <= capa)
              puts "Une ile doit encore placer " + capa.to_s() + " ponts et possède " + nDirection.to_s() + " directions disponibles"
              return true
            elsif(capa == 1)
              archipelle = true
            end
          end
        end
      end
    end
    if(archipelle)
      puts "Attention à ne pas former d'archipelle"
      return true
    end
    return false
  end

end
