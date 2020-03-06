class Grille

    #has_and_belongs_to_many :cases


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
            
        end
        @dernierIle = nil
    end

    def AfficheToi()
        inc = 0
        for i in (0..(@tailleX-1))
            for j in (0..(@tailleY-1))
                @mat[i][j].afficheToi()
                inc += 1
                if(inc % (@tailleX -1) == 0)
                    print("\n")
                    inc = 0
                end
            end
        end
    end

    def equals()
        for i in (0..(@tailleX-1))
            for j in (0..(@tailleY-1))
                if (@mat[i][j].instance_of? Pont)
                    if(!((@mat[i][j].direction == @matSolution[i][j].direction) && (@mat[i][j].direction == @matSolution[i][j].direction)))
                        return 0
                    end
                end
            end
        end
        return 1
    end



    def getGrille()
        return @mat
    end

    def setDernierIle(ile1)
        @dernierIle = ile1
    end

    def createPont(ile2)
        #savoir si c'est horizontal ou verticale :
        if(@dernierIle.posX == ile2.posX) #alors pont horizontale
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
                if(@mat[@dernierIle.posX][i].augmenteValeur(HORIZONTALE) == false)
                    return false
                end
            end
        else #alors verticale
            if ile2.posX < @dernierIle.posX
                xPetit = ile2.posx
                xGrand = @dernierIle.posx
            else
                xPetit = @dernierIle.posx
                xGrand = ile2.posx
            end
            xPetit+=1 #pour se placer sur le premier pont
            xGrand-=1 #pour se placer sur le dernier pont
            for i in (xPetit..xGrand)
                if(@mat[i][@dernierIle.posY].augmenteValeur(VERTICALE) == false)
                    return false
                end
            end
        end
        @dernierIle = nil
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

    def ChargerMap(difficulte,taille,randMap)
        #Ouverture dufichier
        @matSolution = []
        @matJeu = []
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
            depart = 0
        when 10
            depart = 72
        when 15
            depart = 171
        else
            puts "erreur dasn la taille donnee"
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
        
        tailleFinal = taille
        i = 0
        j = 0
        #parcours du text par ligne
        text.each_line do |ligne|
            if(commencementRead<=0)
                commencementRead-=1
                next
            end
            #on regarde bien si une ligne corresponde a la taille demandé
            if(ligneTemp = ligne.split(' ').length == taille)
                @matSolution.push(ligneTemp.map do |elem|
                    case elem
                    when '|'
                        Pont.construit(i,j,self,VERTICALE,1)
                        j+=1
                    when 'H'
                        Pont.construit(i,j,self,VERTICALE,2)
                        j+=1
                    when '-'
                        Pont.construit(i,j,self,HORIZONTALE,1)
                        j+=1
                    when '='
                        Pont.construit(i,j,self,HORIZONTALE,2)
                        j+=1
                    when 'N'
                        Case.generer(i,j,self)
                        j+=1
                    else
                        Ile.creer(i, j, elem.to_i, self)
                        j+=1
                    end
                    i+=1
                    j=0
                end)

                i=0
                @matJeu.push(ligneTemp.map do |elem|
                    case elem
                    when '|'
                        Pont.creer(i, j, self)
                        j+=1
                    when 'H'
                        Pont.creer(i, j, self)
                        j+=1
                    when '-'
                        Pont.creer(i, j, self)
                        j+=1
                    when '='
                        Pont.creer(i, j, self)
                        j+=1
                    when 'N'
                        Case.generer(i,j,self)
                        j+=1
                    else
                        Ile.creer(i, j, elem.to_i, self)
                        j+=1
                    end
                    i+=1
                    j=0
                end)
                tailleFinal-=1
                break if tailleFinal<=0
            end
        end
    end
end
