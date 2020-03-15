
##
# Auteur Brabant Mano
# Version 2.0.1 : Date : 15/03/2020


require "./Case.rb"
require "./Ile.rb"
require "./Pont.rb"
require "./Pile.rb"




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
        puts "Creation !!!"
        @actions = Pile.creer()
        puts actions
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



    def addAction(ile1, ile2, methode)
      @actions.empiler(Action2.creer(ile1, ile2, methode))
    end

    def undo()
      if(!@actions.empty?())
        action = @actions.depiler()
        self.setDernierIle(action.ile1())
        self.send(homologue(action.methode()), action.ile2())
        action = @actions.depiler()
      end
    end

    def homologue(methode)
      if(methode == :createPont)
        return :supprimePont
      elsif(methode == :supprimePont)
        return :createPont
      else
        raise("Je ne connais pas la methode")
      end
    end


    def getDirection(ile1, ile2)
      if(ile1.posX() == ile2.posX()) #alors pont horizontal
        return Pont::HORIZONTAL
      elsif(ile1.posY() == ile2.posY()) #alors pont vertical
        return Pont::VERTICAL
      else
        return Pont::NULLE
      end
    end


    def getDifference(ile1, ile2)

      direction = getDirection(ile1, ile2)

      if(direction == Pont::HORIZONTAL)
        petitPos = [ile2.posY(), ile1.posY()].min() + 1
        grandPos = [ile2.posY(), ile1.posY()].max() - 1
      elsif(direction == Pont::VERTICAL) #alors pont vertical
        petitPos = [ile2.posX(), ile1.posX()].min() + 1
        grandPos = [ile2.posX(), ile1.posX()].max() - 1
      else
        petitPos = 0
        grandPos = 0
      end
      return direction, petitPos, grandPos
    end


    def estVoisin?(ile1, ile2)
      proc = Proc.new do |pont|
        if(pont.estIle?())
          return false
        end
      end
      return parcoursPont(ile1, ile2, proc)
    end

    def createPont(ile2)
      direction = getDirection(@dernierIle, ile2)
      if(direction != Pont::NULLE)
        self.addAction(@dernierIle, ile2, :createPont)
      end
      proc = Proc.new do |pont|
        pont.augmenteValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    def supprimePont(ile2)
      direction = getDirection(@dernierIle, ile2)
      if(direction != Pont::NULLE)
        self.addAction(@dernierIle, ile2, :supprimePont)
      end
      proc = Proc.new do |pont|
        pont.diminueValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    def surbrillancePont(ile2)
      direction = getDirection(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.metSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    def eteintPont(ile2)
      direction = getDirection(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.supprSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    def parcoursPont(ile1, ile2, proc)
      direction, petitPos, grandPos = getDifference(ile1, ile2)
      if(direction == Pont::HORIZONTAL)
        return parcoursPontHorizontal(petitPos, grandPos, proc)
      elsif(direction == Pont::VERTICAL)
        return parcoursPontVertical(petitPos, grandPos, proc)
      end
    end

    private def parcoursPontVertical(petitPos, grandPos, proc)
      for i in (petitPos..grandPos)
        proc.call(@mat[i][@dernierIle.posY()])
      end
      return true
    end

    private def parcoursPontHorizontal(petitPos, grandPos, proc)
      for i in (petitPos..grandPos)
        proc.call(@mat[@dernierIle.posX()][i])
      end
      return true
    end




    def setDernierIle(ile1)
      puts "marque 1"
      if(!@dernierIle.eql?(nil))
        puts "marque 2"
        effacePont()
      end
      puts "marque 3"
      @dernierIle = ile1
      puts "marque 4"
      montrePont()
      puts "marque 5"
      afficheToi()
      puts "marque 6"
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
      direction = getDirection(@dernierIle, ile2)
      proc = Proc.new do |pont|
        if(pont.direction() == direction)
          return pont.valeur()
        else
          return 0
        end
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

end
