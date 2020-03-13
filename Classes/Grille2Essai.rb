


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
    attr_reader :actions
    attr_reader :matSolution



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
      @mat.each do |i|
        i.each do |j|
          print j
        end
        print "\n"
      end
    end

    def equals()
      for i in (0..(@tailleX-1))
        for j in (0..(@tailleY-1))
          if(@mat[i][j] != @matSolution[i][j])
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



    def getCase(i, j)
        return @mat[i][j]
    end


    def getDifference(ile1, ile2)

      print ile1.afficheInfo(), "\n"
      print ile2.afficheInfo(), "\n"

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
          @mat[i][@dernierIle.posY()].diminueValeur(Pont::HORIZONTAL)
        elsif(direction == Pont::VERTICAL)
          @mat[@dernierIle.posX()][i].diminueValeur(Pont::VERTICAL)
        end
      end
    end


=begin
    def createPont(ile2)
      direction, petitPos, grandPos = getDifference(@dernierIle, ile2)
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[i][@dernierIle.posY()].augmenteValeur(Pont::HORIZONTAL) == false)
            annuleCreatePont(petitPos, i, Pont::HORIZONTAL)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[@dernierIle.posX()][i].augmenteValeur(Pont::VERTICAL) == false)
            annuleCreatePont(petitPos, i, Pont::VERTICAL)
            return false
          end
        end
      elsif(direction == Pont::NULLE)
        return false
      end
      return true
    end

=end
    def createPont(ile2)
        #savoir si c'est Pont::HORIZONTAl ou Pont::VERTICAL :
        if(@dernierIle.posX == ile2.posX) #alors pont Pont::HORIZONTAL
            if ile2.posY < @dernierIle.posY
                yPetit = ile2.posY
                yGrand = @dernierIle.posY
            else
                yPetit = @dernierIle.posY
                yGrand = ile2.posY
            end
            yPetit+=1 #pour se placer sur le premier pont
            yGrand-=1 #pour se placer sur le dernier pont
            for i in (yPetit..yGrand)
                if(@mat[@dernierIle.posX][i].augmenteValeur(Pont::HORIZONTAL) == false)
                    return false
                end
            end
        else #alors Pont::VERTICAL
            if ile2.posX < @dernierIle.posX
                xPetit = ile2.posX
                xGrand = @dernierIle.posX
            else
                xPetit = @dernierIle.posX
                xGrand = ile2.posX
            end
            xPetit+=1 #pour se placer sur le premier pont
            xGrand-=1 #pour se placer sur le dernier pont
            for i in (xPetit..xGrand)
                if(@mat[i][@dernierIle.posY].augmenteValeur(Pont::VERTICAL) == false)
                    return false
                end
            end
        end
        @dernierIle = nil
        return true
    end

    def estVoisin?(ile1, ile2)
      direction, petitPos, grandPos = getDifference(ile1, ile2)
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[i][ile1.posY()].estIle?())
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[ile1.posX()][i].estIle?())
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
          @mat[i][@dernierIle.posY()].supprSurbrillance(Pont::HORIZONTAL)
        elsif(direction == Pont::VERTICAL)
          @mat[@dernierIle.posX()][i].supprSurbrillance(Pont::VERTICAL)
        end
      end
    end

    def surbrillancePont(ile2)
      direction, petitPos, grandPos = getDifference(@dernierIle, ile2)
      puts direction, petitPos, grandPos
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[i][@dernierIle.posY()].metSurbrillance(Pont::HORIZONTAL) == false)
            puts i
            annuleSurbrillancePont(petitPos, i, Pont::HORIZONTAL)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[@dernierIle.posX()][i].metSurbrillance(Pont::VERTICAL) == false)
            puts i
            annuleSurbrillancePont(petitPos, i, Pont::VERTICAL)
            return false
          end
        end
      elsif(direction == Pont::NULLE)
        return false
      end
      return true
    end


    def setDernierIle(ile1)
        @dernierIle = ile1
    end



    def montrePont()

      if(@dernierIle.aVoisin?(Ile::HAUT))
        surbrillancePont(@dernierIle.getVoisin(Ile::HAUT))
      end

    #  if(@dernierIle.aVoisin?(Ile::BAS))
    #    surbrillancePont(@dernierIle.getVoisin(Ile::BAS))
    #  end

      if(@dernierIle.aVoisin?(Ile::GAUCHE))
        surbrillancePont(@dernierIle.getVoisin(Ile::GAUCHE))
      end

    #  if(@dernierIle.aVoisin?(Ile::DROITE))
    #     surbrillancePont(@dernierIle.getVoisin(Ile::DROITE))
    #  end

    end

    def valeurPont(ile1,ile2)
        if(ile1.posX == ile2.posX)#horizontal
            if(ile1.posY > ile2.posY)
                if(@mat[ile2.posX][ile2.posY+1].direction == Pont::VERTICAL)
                    return 0
                else
                    return @mat[ile2.posX][ile2.posY+1].valeur
                end
            else
                if(@mat[ile1.posX][ile1.posY+1].direction == Pont::VERTICAL)
                    return 0
                else
                    return @mat[ile1.posX][ile1.posY+1].valeur
                end
            end
        else
            if(ile1.posX > ile2.posX)#vertical
                if(@mat[ile2.posX+1][ile2.posY].direction == Pont::HORIZONTAL)
                    return 0
                else
                    return @mat[ile2.posX][ile2.posY+1].valeur
                end
            else
                if(@mat[ile1.posX+1][ile1.posY].direction == Pont::HORIZONTAL)
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
