


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
    @Sauvegarde #sauvegarde de la grille
    @matSolution #matrice de la grille Solution

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
        @dernierIle = nil
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



    def getGrille()
        return @mat
    end

    def annuleCreatePont(petitPos, grandPos, direction)

      for i in (petitPos..grandPos)

        if(direction == Pont.HORIZONTAL)

          @mat[@dernierIle.posX()][i].diminueValeur(Pont.HORIZONTAL)

        elsif(direction == Pont.VERTICAL)

          @mat[i][@dernierIle.posY()].diminueValeur(Pont.VERTICAL)

        end


      end

    end

    def createPont(ile2)
        #savoir si c'est horizontal ou vertical :
        if(@dernierIle.posX() == ile2.posX()) #alors pont horizontal

          direction = Pont.HORIZONTAL
          petitPos = min(ile2.posY(), @dernierIle.posY()) + 1
          grandPos = max(ile2.posY(), @dernierIle.posY()) - 1

        elsif(@dernierIle.posY() == ile2.posY()) #alors pont vertical

          direction = Pont.VERTICAL
          petitPos = min(ile2.posX(), @dernierIle.posX()) + 1
          grandPos = max(ile2.posX(), @dernierIle.posX()) - 1

        else

          return false

        end

        for i in (petitPos..grandPos)

          if(direction == Pont.HORIZONTAL)

            if(@mat[@dernierIle.posX()][i].augmenteValeur(Pont.HORIZONTAL) == false)
                annuleCreatePont(petitPos, i, Pont.HORIZONTAL)
                return false
            end

          elsif(direction == Pont.VERTICAL)

            if(@mat[i][@dernierIle.posY()].augmenteValeur(Pont.VERTICAL) == false)
                annuleCreatePont(petitPos, i, Pont.VERTICAL)
                return false
            end

          end

        end
        return true
    end

    def estVoisin?(ile1, ile2)
        if(ile1.posX == ile2.posX) #savoir s'il sont alignés horizontalement
            if ile2.posY < ile1.posY
                yPetit = ile2.posY
                yGrand = ile1.posY
            else
                yPetit = ile1.posY
                yGrand = ile2.posY
            end
            yPetit+=1 #pour se placer sur le premier pont
            yGrand-=1 #pour se placer sur le dernier pont
            for i in (yPetit..yGrand)
                if(@mat[@dernierIle.posX][i].instance_of? Ile)
                    return false
                end
            end
            return true
        else
            if ile2.posx < ile1.posx
                xPetit = ile2.posx
                xGrand = ile1.posx
            else
                xPetit = ile1.posx
                xGrand = ile2.posx
            end
            xPetit+=1 #pour se placer sur le premier pont
            xGrand-=1 #pour se placer sur le dernier pont
            for i in (xPetit..xGrand)
                if(@mat[i][ile2.posY].instance_of? Ile)
                    return false
                end
            end
            return true
        end
    end

    def montrePont()
        #met en surbrillance les ponts qui sont relié
        droite = false
        gauche = false
        haut = false
        bas = false
        directionEnCours = nil

        #en bas
        if(@mat[@dernierIle.posX+1][@dernierIle.posY].instance_of? Pont)
            directionEnCours = @mat[@dernierIle.posX+1][@dernierIle.posY].direction
            for i in range (@dernierIle.posX .. tailleX)
                if(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Ile)
                    bas = true
                    break
                elsif(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Pont)
                    if(directionEnCours != @mat[@dernierIle.posX+i][@dernierIle.posY].direction)
                        bas = false
                        break
                    end
                    #sinon est on est sur un bon pont
                else
                    #on est sur une case
                    bas = false
                    break
                end
            end
        end

        #en haut
        if(@mat[@dernierIle.posX-1][@dernierIle.posY].instance_of? Pont)
            directionEnCours = @mat[@dernierIle.posX-1][@dernierIle.posY].direction
            for i in range (@dernierIle.posX .. 0)
                if(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Ile)
                    haut = true
                    break
                elsif(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Pont)
                    if(directionEnCours != direction)
                        haut = false
                        break
                    end
                    #sinon est on est sur un bon pont
                else
                    #on est sur une case
                    haut = false
                    break
                end
            end
        end

        #a gauche
        if(@mat[@dernierIle.posX][@dernierIle.posY-1].instance_of? Pont)
            directionEnCours = @mat[@dernierIle.posX][@dernierIle.posY-1].direction
            for i in range (@dernierIle.posY .. 0)
                if(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Ile)
                    gauche = true
                    break
                elsif(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Pont)
                    if(directionEnCours != direction)
                        gauche = false
                        break
                    end
                    #sinon est on est sur un bon pont
                else
                    #on est sur une case
                    gauche = false
                    break
                end
            end
        end

        #a droite
        if(@mat[@dernierIle.posX][@dernierIle.posY+1].instance_of? Pont)
            directionEnCours = @mat[@dernierIle.posX][@dernierIle.posY+1].direction
            for i in range (@dernierIle.posY .. tailleY)
                if(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Ile)
                    droite = true
                    break
                elsif(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Pont)
                    if(directionEnCours != direction)
                        droite = false
                        break
                    end
                    #sinon est on est sur un bon pont
                else
                    #on est sur une case
                    droite = false
                    break
                end
            end
        end

        if(bas)
            i=1
            until(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Ile)
                @mat[@dernierIle.posX+i][@dernierIle.posY].surbrillance = true
                i+=1
            end
        end
        if(haut)
            i=-1
            until(@mat[@dernierIle.posX+i][@dernierIle.posY].instance_of? Ile)
                @mat[@dernierIle.posX+i][@dernierIle.posY].surbrillance = true
                i-=1
            end
        end
        if(gauche)
            i=-1
            until(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Ile)
                @mat[@dernierIle.posX][@dernierIle.posY+i].surbrillance = true
                i-=1
            end
        end
        if(droite)
            i=1
            until(@mat[@dernierIle.posX][@dernierIle.posY+i].instance_of? Ile)
                @mat[@dernierIle.posX][@dernierIle.posY+i].surbrillance = true
                i+=1
            end
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
