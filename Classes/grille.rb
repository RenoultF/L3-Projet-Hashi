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

    def Grille.charger(laSauvegarde, laTailleX, laTailleY, laDifficulte)
        new(laSauvegarde, laTailleX, laTailleY, laDifficulte)
    end

    def initialize(laSauvegarde, laTailleX, laTailleY, laDifficulte)
        @tailleX = laTailleX
        @tailleY = laTailleY
        if(laSauvegarde != nil){
            @mat = laSauvegarde.getGrille()
            @numGrille = laSauvegarde.getNumGrille()
            @checkpoints = laSauvegarde.getCheckPoint();
            @actions = laSauvegarde.getActions();
        }
        else{

        }
        @dernierIle = nil
    end

    def AfficheToi()
        inc = 0
        for i in (0..(@tailleX-1))
            for j in (0..(@tailleY-1))
                @mat[i][j].afficheToi()
                inc += 1
                if(inc % @tailleX == 0)
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
                    if(!((@mat[i][j].direction == @matSolution[i][j].direction) && (@mat[i][j].direction == @matSolution[i][j].direction))){
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
                if(@mat[@dernierIle.posX][i].instance_of Ile)
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
                if(@mat[i][ile2.posY].instance_of Ile)
                    return false
                end
            end
            return true
        end
    end

    def montrePont()
        # faire
    end
end
