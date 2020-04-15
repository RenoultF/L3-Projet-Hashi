require "./Pont.rb"
require "./Ile.rb"

# DEPRECATED
class Grille

    @tailleX #taille x de la grille
    @tailleY #taille y de la grille
    @mat #matrice de type Case[taillex][tailleY]
    @dernierIle #dernierIle sur laquelle on a cliqué
    @numGrille #numero de la grille
    @checkpoints #liste des différents chekcpoints
    @actions #pile des actions
    @Sauvegarde #sauvegarde de la grille
    @matSolution #matrice de la grille Solution
    attr_reader :difficulte
    attr_reader :tailleX
    attr_reader :actions
    attr_reader :matSolution


    private_class_method :new

    def Grille.charger(laSauvegarde, laTailleX, laTailleY, laDifficulte, numGrilleTemp)
        new(laSauvegarde, laTailleX, laTailleY, laDifficulte, numGrilleTemp)
    end

    def initialize(laSauvegarde, laTailleX, laTailleY, laDifficulte, numGrilleTemp)
        @tailleX = laTailleX
        @tailleY = laTailleY
        @numGrille = numGrilleTemp
        if(laSauvegarde != nil)
            @mat = laSauvegarde.getGrille()
            @checkpoints = laSauvegarde.getCheckPoint()
            @actions = laSauvegarde.getActions()
        else
            self.chargerMap(laDifficulte,@tailleX,numGrilleTemp)
            @checkpoints = nil
            @actions = nil;
        end
        @dernierIle = nil
    end

    #Cette méthode permet d'afficher la grille
    def afficheToi()
      @mat.each do |i|
        i.each do |j|
          print j
        end
        print "\n"
      end
    end


    #Cette méthode permet de savoir si la grille est fini
    #
    #@return true si la grille est fini, false sinon
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

    #Cette méthode permet de savoir si les coordonnees passés en parametre sont compris dans la grille
    #
    #@param posX La position sur l'axe des abscisse
    #
    #@param posY La position sur l'axe des ordonnées
    def sortLimite?(posX, posY)
      if(posX < 0 || posY < 0 || posX >= @tailleX || posY >= @tailleY)
        return true
      end
      return false
    end

    #Cette méthode permet de recuperer la matrice de cases
    #
    #@return La matrice de cases
    def getGrille()
        return @mat
    end

    #Cette méthode permet de recuperer une case de la grille
    def getCase(i, j)
        return @mat[i][j]
    end

    #Cette méthode permet de modifier la derniere ile que l'on a touché
    def setDernierIle(ile1)
        @dernierIle = ile1
    end

    #Cette méthode permet de retourner la diffrence de position de deux iles
    #
    #@param ile1 La premiere ile (raise si ce n'est pas une ile)
    #
    #@param ile2 La deuxieme ile (raise si ce n'est pas une ile)
    #
    #@return direction, petitPos, grandPos
    #
    #direction : La direction des ponts qui pourrait relier les deux iles (Pont::NULLE si les iles ne sont pas voisines)
    #
    #petitPos La coordonnée du premier pont entre les deux iles
    #
    #grandPos La coordonnée du premier pont entre les deux iles
    #
    #petitPos et grandPos représentent une coordonnée en abscisse si le direction est horizontal, en ordonnées sinon
    def getDifference(ile1, ile2)

      if(!(ile1.estIle()))
        raise("La case au coordonnée [" + ile1.posX() + ";" + ile1.posX() + "] n'est pas une ile")
      end

      if(!(ile2.estIle()))
        raise("La case au coordonnée [" + ile2.posX() + ";" + ile2.posX() + "] n'est pas une ile")
      end

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
          print @mat[@dernierIle.posX()][i]
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
          @mat[@dernierIle.posX()][i].supprSurbrillance(Pont::HORIZONTAL)
        elsif(direction == Pont::VERTICAL)
          @mat[i][@dernierIle.posY()].supprSurbrillance(Pont::VERTICAL)
        end
      end
    end

    def surbrillancePont(ile2)
      direction, petitPos, grandPos = getDifference(@dernierIle, ile2)
      puts direction, petitPos, grandPos
      if(direction == Pont::HORIZONTAL)
        for i in (petitPos..grandPos)
          if(@mat[@dernierIle.posX()][i].metSurbrillance(Pont::HORIZONTAL) == false)
            puts i
            annuleSurbrillancePont(petitPos, i, Pont::HORIZONTAL)
            return false
          end
        end
      elsif(direction == Pont::VERTICAL)
        for i in (petitPos..grandPos)
          if(@mat[i][@dernierIle.posY()].metSurbrillance(Pont::VERTICAL) == false)
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
        if(ile1.posX == ile2.posX)#Pont::HORIZONTAl
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
            if(ile1.posX > ile2.posX)#Pont::VERTICAL
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

    def chargerMap(difficulte,taille,randMap)
        #Ouverture dufichier
        @matSolution = []
        @mat = []
        text = File.open("map.txt").read
        #on verifie qu'il n'est pas vide
        if(text == nil)
            puts "Attention le fichier d'ouverture est vide"
            return nil;
        end
        text.gsub!(/\r\n/, "\n");
        depart = 0
        #endroit ou on va commencer à lire
        case taille
        when 7
            depart = 1
        when 10
            depart = 73
        when 15
            depart = 172
        else
            puts "erreur dans la taille donnee"
        end

        case difficulte
        when 1
            depart += 0
        when 2
            depart += ((taille+1) * 3)
        when 3
            depart += (2*((taille+1) * 3))
        else
            puts "erreur dans la taille donnee"
        end

        commencementRead = depart + ((taille+1) * (randMap-1))

        print("commencement : #{commencementRead} \n")
        tailleFinal = taille
        i = 0
        j = -1
        #parcours du text par ligne
        text.each_line do |ligne|
            if(commencementRead>0)
                commencementRead-=1
                next
            end
            #on regarde bien si une ligne corresponde a la taille demandé
            ligneTemp = ligne.split(' ')
            if(ligneTemp.length == taille)
                @matSolution.push(ligneTemp.map do |elem|
                    j+=1
                    case elem
                    when '|'
                        Pont.construit(i,j,self,Pont::VERTICAL,1)
                    when 'H'
                        Pont.construit(i,j,self,Pont::VERTICAL,2)
                    when '-'
                        Pont.construit(i,j,self,Pont::HORIZONTAL,1)
                    when '='
                        Pont.construit(i,j,self,Pont::HORIZONTAL,2)
                    when 'N'
                        Case.generer(i,j,self)
                    else
                        Ile.creer(i, j, elem.to_i, self)
                    end
                end)
                j=-1
                @mat.push(ligneTemp.map do |elem|
                    j+=1
                    case elem
                    when '|'
                        Pont.creer(i, j, self)
                    when 'H'
                        Pont.creer(i, j, self)
                    when '-'
                        Pont.creer(i, j, self)
                    when '='
                        Pont.creer(i, j, self)
                    when 'N'
                        Case.generer(i,j,self)
                    else
                        Ile.creer(i, j, elem.to_i, self)
                    end

                end)
                i+=1
                j=0

            end
            tailleFinal-=1
            break if tailleFinal<=0
        end
    end
end
