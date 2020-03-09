


require "./Case.rb"
require "./Ile.rb"
require "./Pont.rb"




class Grille2Essai


    @tailleX #taille x de la grille
    @tailleY #taille y de la grille
    @mat #matrice de type Case[taillex][tailleY]
    @dernierIle #dernierIle sur laquelle on a cliqué
    @numGrille #numero de la grille
    @checkpoints #liste des différents chekcpoints
    @actions #pile des actions
    @sauvegarde #sauvegarde de la grille
    @matSolution #matrice de la grille Solution
    attr_reader :difficulte
    attr_reader :tailleX



    private_class_method :new

    def Grille2Essai.creer(chaine, tailleX, tailleY, difficulte)
        new(chaine, tailleX, tailleY, difficulte)
    end

    def initialize(chaine, tailleX, tailleY, difficulte)

        if(chaine.length != tailleX * tailleY)

          raise("La taille n'est pas la bonne")

        end
        @difficulte = difficulte
        i = -1
        j = tailleY
        @tailleX = tailleX
        @tailleY = tailleY
        @mat = Array.new(tailleX) { Array.new(tailleY) }
        @matSolution = Array.new(tailleX) { Array.new(tailleY) }
        chaine.each_char do |c|

          j += 1
          if(j >= tailleY)

            j = 0
            i += 1

          end


          if(c =~ /[1-8]/)

            @mat[i][j] = Ile.creer(i, j, c.ord() - '0'.ord(), self)
            @matSolution[i][j] = Ile.creer(i, j, c.ord() - '0'.ord(), self)

          elsif(c == '|')

            @matSolution[i][j] = Pont.construit(i, j, self, Pont::VERTICAL, 1)
            @mat[i][j] = Pont.creer(i, j, self)


          elsif(c == '"')

            @matSolution[i][j] = Pont.construit(i, j, self, Pont::VERTICAL, 2)
            @mat[i][j] = Pont.creer(i, j, self)

          elsif(c == '-')

            @matSolution[i][j] = Pont.construit(i, j, self, Pont::HORIZONTAL, 1)
            @mat[i][j] = Pont.creer(i, j, self)

          elsif(c == '=')

            @matSolution[i][j] = Pont.construit(i, j, self, Pont::HORIZONTAL, 2)
            @mat[i][j] = Pont.creer(i, j, self)

          elsif(c == ' ')

            @matSolution[i][j] = Case.generer(i, j, self)
            @mat[i][j] = Case.generer(i, j, self)

          end

        end

        @dernierIle = @mat[0][0]

    end

    def afficheToi()
      @matSolution.each do |i|
        i.each do |j|
          print j
        end
        print "\n"
      end
    end

    def equals()
      for i in (0..(@tailleX-1))
        for j in (0..(@tailleY-1))
          if(@mat[i][j] != @matSolution[i][i])
            return 0
          end
        end
      end
      return 1
    end

    def sortLimite(posX, posY)
      if(posX < 0 || posY < 0 || posX >= @tailleX || posY >= @tailleY)
        return true
      end
      return false
    end



    def getGrille()
        return @mat
    end

    def getDifference(ile1, ile2)
      if(ile1.posX() == ile2.posX()) #alors pont horizontal
        direction = Pont::VERTICAL
        petitPos = [ile2.posY(), ile1.posY()].min() + 1
        grandPos = [ile2.posY(), ile1.posY()].max() - 1
      elsif(ile1.posY() == ile2.posY()) #alors pont vertical
        direction = Pont::HORIZONTAL
        petitPos = [ile2.posX(), ile1.posX()].min() + 1
        grandPos = [ile2.posX(), ile1.posX()].max() - 1
      else
        direction = Pont::NULLE
        petitPos = 0
        grandPos = 0
      end
      return direction, petitPos, grandPos
    end

    def annuleCreatePont(petitPos, grandPos, direction)
      for i in (petitPos..grandPos)
        if(direction == Pont::HORIZONTAL)
          @mat[@dernierIle.posX()][i].diminueValeur(Pont::HORIZONTAL)
        elsif(direction == Pont::VERTICAL)
          @mat[i][@dernierIle.posY()].diminueValeur(Pont::VERTICAL)
        end
      end
    end

    def createPont(ile2)
      direction, petitPos, grandPos = getDifference(@dernierIle, ile2)
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[@dernierIle.posX()][i].augmenteValeur(Pont::HORIZONTAL) == false)
            annuleCreatePont(petitPos, i, Pont::HORIZONTAL)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[i][@dernierIle.posY()].augmenteValeur(Pont::VERTICAL) == false)
            annuleCreatePont(petitPos, i, Pont::VERTICAL)
            return false
          end
        end
      elsif(direction == Pont::NULLE)
        return false
      end
      return true
    end

    def estVoisin?(ile1, ile2)

      direction, petitPos, grandPos = getDiff(ile1, ile2)
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[ile1.posX()][i].instance_of? Ile)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[i][ile2.posY()].instance_of? Ile)
            return false
          end
        end
      elsif(direction == Pont::NULLE)
        return false
      end
      return true
    end


    def annuleSurbrillancePont(petitPos, grandPos, direction)
      for i in (petitPos..grandPos)
        if(direction == Pont::HORIZONTAL)
          @mat[@dernierIle.posX()][i].supprSurbrillance(Pont::HORIZONTAL)
        elsif(direction == Pont::VERTICAL)
          @mat[i][@dernierIle.posY()].supprSurbrillance(Pont::VERTICAL)
        end
      end
    end

    def surbrillancePont(ile2)
      direction, petitPos, grandPos = getDifference(@dernierIle, ile2)
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          print @mat[@dernierIle.posX()][i], "\n"
          if(@mat[@dernierIle.posX()][i].metSurbrillance(Pont::HORIZONTAL) == false)
            annuleSurbrillancePont(petitPos, i, Pont::HORIZONTAL)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          print @mat[i][@dernierIle.posY()], "\n"
          if(@mat[i][@dernierIle.posY()].metSurbrillance(Pont::VERTICAL) == false)
            annuleSurbrillancePont(petitPos, i, Pont::VERTICAL)
            return false
          end
        end
      elsif(direction == Pont::NULLE)
        return false
      end
      return true
    end




    def montrePont()

      if(@dernierIle.aVoisin(Ile::HAUT))
        surbrillancePont(@dernierIle.getVoisin(Ile::HAUT))
      end

      if(@dernierIle.aVoisin(Ile::BAS))
        surbrillancePont(@dernierIle.getVoisin(Ile::BAS))
      end

      if(@dernierIle.aVoisin(Ile::GAUCHE))
        surbrillancePont(@dernierIle.getVoisin(Ile::GAUCHE))
      end

      if(@dernierIle.aVoisin(Ile::DROITE))
        surbrillancePont(@dernierIle.getVoisin(Ile::DROITE))
      end

    end

    def valeurPont(ile1,ile2)
        if(ile1.posX == ile2.posX)#horizontal
            if(ile1.posY > ile2.posY)
                if(@mat[ile2.posX][ile2.posY+1].direction == VERTICALE)
                    return 0
                else
                    return @mat[ile2.posX][ile2.posY+1].valeur
                end
            else
                if(@mat[ile1.posX][ile1.posY+1].direction == VERTICALE)
                    return 0
                else
                    return @mat[ile1.posX][ile1.posY+1].valeur
                end
            end
        else
            if(ile1.posX > ile2.posX)#vertical
                if(@mat[ile2.posX+1][ile2.posY].direction == HORIZONTALE)
                    return 0
                else
                    return @mat[ile2.posX][ile2.posY+1].valeur
                end
            else
                if(@mat[ile1.posX+1][ile1.posY].direction == HORIZONTALE)
                    return 0
                else
                    return @mat[ile1.posX+1][ile1.posY].valeur
                end
            end
        end
    end

    def removeAction()
        tab_action = Array.new()
        if(!@actions.empty?)
            tab_action = @actions.last().GetCoord()
            x= tab_action[1]
            y = tab_action[2]
            direc = tab_action[3]
            #si on veut enlever un pont
            if(tab_action[0]== 0)
                @mat[x][y].diminueValeur(direc)
            else
                @mat[x][y].augmenteValeur(direc)
            end
            @actions.pop
        end
    end

end
