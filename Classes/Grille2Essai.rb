


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

    def fini?()
      for i in (0..(@tailleX-1))
        for j in (0..(@tailleY-1))
          if(@mat[i][j] != @matSolution[i][j])
            return 0
          end
        end
      end
      return 1
    end

    def sortLimite?(posX, posY)
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
        direction = Pont::HORIZONTAL
        petitPos = [ile2.posY(), ile1.posY()].min() + 1
        grandPos = [ile2.posY(), ile1.posY()].max() - 1
      elsif(ile1.posY() == ile2.posY()) #alors pont vertical
        direction = Pont::VERTICAL
        petitPos = [ile2.posX(), ile1.posX()].min() + 1
        grandPos = [ile2.posX(), ile1.posX()].max() - 1
      else
        direction = Pont::NULLE
        petitPos = 0
        grandPos = 0
      end
      return direction, petitPos, grandPos
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

    def createPont(ile2)
      parcours(@dernierIle, ile2, :augmenteValeur)
    end

    def supprimePont(ile2)
      parcours(@dernierIle, ile2, :diminueValeur)
    end

    def surbrillancePont(ile2)
      parcours(@dernierIle, ile2, :metSurbrillance)
    end

    def eteintPont(ile2)
      parcours(@dernierIle, ile2, :supprSurbrillance)
    end

    def parcours(ile1, ile2, methode)
      direction, petitPos, grandPos = getDifference(ile1, ile2)
      if(direction == Pont::HORIZONTAL)
        return parcoursHorizontal(petitPos, grandPos, methode, direction)
      elsif(direction == Pont::VERTICAL)
        return parcoursVertical(petitPos, grandPos, methode, direction)
      end
    end

    def parcoursVertical(petitPos, grandPos, methode, direction)
      for i in (petitPos..grandPos)
        @mat[i][@dernierIle.posY()].send(methode, direction)
      end
    end

    def parcoursHorizontal(petitPos, grandPos, methode, direction)
      for i in (petitPos..grandPos)
        @mat[@dernierIle.posX()][i].send(methode, direction)
      end
    end



    def setDernierIle(ile1)
      effacePont()
      @dernierIle = ile1
      montrePont()
      afficheToi()
    end



    def montrePont()
      for direction in Ile::DIRECTIONS
        if(@dernierIle.aVoisinDisponible?(direction))
          surbrillancePont(@dernierIle.getVoisin(direction))
        end
      end
    end

    def effacePont()
      for direction in Ile::DIRECTIONS
        if(@dernierIle.aVoisinDisponible?(direction))
          eteintPont(@dernierIle.getVoisin(direction))
        end
      end
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
