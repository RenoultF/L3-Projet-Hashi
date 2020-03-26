
##
# Auteur Brabant Mano, Renoult Florent
# Version 2.0.1 : Date : 15/03/2020


require "../Core/Case.rb"
require "../Core/Ile.rb"
require "../Core/Pont.rb"
require "../Core/Pile.rb"
require "../Core/UndoRedo.rb"
require "../Core/Hypothese.rb"
require "../Core/Action.rb"



#Cette classe représente une grille de jeu avec les cases, la pile d'action, les hypoyhèses, etc
class Grille


    @tailleX #taille x de la grille
    @tailleY #taille y de la grille
    @mat #matrice de type Case[taillex][tailleY]
    @dernierIle #dernierIle sur laquelle on a cliqué
    @numGrille #numero de la grille
    @checkpoints #liste des différents chekcpoints
    @actions #pile des actions
    @sauvegarde #sauvegarde de la grille
    @matSolution #matrice de la grille Solution

    #@difficulte => La difficulté de la grille
    attr_reader :difficulte

    #@tailleX => Le nombre de cases en abscisse
    attr_reader :tailleX

    #@tailleY => Le nombre de cases en ordonnée
    attr_reader :tailleY

    #@actions => La pile d'action
    attr_reader :actions

    #@matSolution => La matrice solution
    attr_reader :matSolution



    private_class_method :new

    #Ce constructeur permet de créer une nouvelle grille
    #
    #@param chaine La chaine génératrice
    #
    #@param tailleX Le nombre de cases en abscisse
    #
    #@param tailleY Le nombre de cases en ordonnée
    #
    #@param difficulte La difficulté de la grille
    def Grille.creer(chaine, tailleX, tailleY, difficulte)
        new(chaine, tailleX, tailleY, difficulte)
    end

    #:nodoc:
    def initialize(chaine, tailleX, tailleY, difficulte)
        if(chaine.length != tailleX * tailleY)
          raise("La taille n'est pas la bonne")
        end
        puts "Creation !!!"
        @actions = UndoRedo.creer()
        puts actions
        @checkpoints = Pile.creer()
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
            @matSolution[i][j] = Case.creer(i, j, self)
            @mat[i][j] = Case.creer(i, j, self)
          end
        end
        @dernierIle = nil
    end
    #:doc:

    #Cette méthode permet d'afficher les case de la grille
    def afficheToi()
      if(!@dernierIle.eql?(nil))
        print "Nombre chemin disponible : ", @dernierIle.getNombreCheminDisponible(), "\n"
        print "Capacite residuelle : ", @dernierIle.getCapaciteResiduelle(), "\n"
        print "Nombre Pont : ", @dernierIle.getNombrePont().to_s(), "\n"
      end
      print "    "
      for colonne in (0..tailleX-1)
        print colonne.to_s() + " "
      end
      print "\n"
      ligne = -1
      @mat.each do |i|
        print (ligne+=1).to_s() + " : "
        i.each do |j|
          print j.to_s() + " "
        end
        print "\n"
      end
    end

    #Cette méthode permet de savoir si la grille est correcte
    #
    #@return true si la grille est fini, false sinon
    def fini?()
      for i in (0..(@tailleX-1))
        for j in (0..(@tailleY-1))
          if(@mat[i][j] != @matSolution[i][j])
            return false
          end
        end
      end
      return true
    end

    #Cette méthode permet de savoir si les coordonnées passés sont comprises dans la grille
    #
    #@return true si les coordonnées sont valide, false sinon
    def sortLimite?(posX, posY)
      if(posX < 0 || posY < 0 || posX >= @tailleX || posY >= @tailleY)
        return true
      end
      return false
    end

    #Cette méthode permet de recuperer la matrice de cases
    def getGrille()
        return @mat
    end


    #Cette méthode permet de recuperer une case de la grille
    #
    #@param i La position en abscisse
    #
    #@param j La position en ordonnée
    #
    #@return La case à la position [i][j]
    def getCase(i, j)
        return @mat[i][j]
    end

    #Cette méthode permet de recuperer une case de la grille solution
    #
    #@param i La position en abscisse
    #
    #@param j La position en ordonnée
    #
    #@return La case à la position [i][j]
    def getCaseSolution(i, j)
        return @matSolution[i][j]
    end

    ##
    #Cette méthode permet d'emmetre une nouvelle hypothèse (rangé dans la pile d'hypothèse)
    def creerHypothese()
      @checkpoints.empiler(Hypothese.creer(self))
    end

    ##
    #Cette méthode permet de valider la dernière hypothèse
    def valideHypothese()
      begin
        @checkpoints.depiler().grille
      rescue => e
        puts e.message()
      end
    end

    ##
    #Cette méthode permet de supprimer la dernière hypothèse et de revenir à l'état correspondant
    #
    #@param jeu Le jeu dont-on va modifier la grille
    def supprimeHypothese(jeu)
      begin
        jeu.grille = @checkpoints.depiler().grille
      rescue => e
        puts e.message()
      end
    end



    ##
    #Méthode à appeler quand on appuie sur une ile
    #
    #@param ile L'ile sur laquelle on a cliqué
    def clickOnIle(ile)

      if(@dernierIle.eql?(nil))
        puts "derniere ile == nil"
        setDernierIle(ile)
      elsif(!estVoisin?(@dernierIle, ile))
        puts "pas voisins"
        setDernierIle(ile)
      else
        puts "creation pont"
        createPont(ile)
      end


    end

    #Cette méthode permet d'ajouter une action à la pile d'action
    #
    #@param ile1 La premère ile
    #
    #@param ile2 La deuxième ile
    #
    #@param methode La méthode utilisé (:createPont ou :supprimePont)
    def addAction(ile1, ile2, methode)
      @actions.empiler(Action.creer(ile1, ile2, methode))
    end


    #Cette méthode permet d'annuler la dernière action
    def undo()
      if(!@actions.empty?())
        begin
          tempIle = self.getDernierIle()
          action = @actions.undo()
          self.setDernierIle(action.ile1())
          self.send(homologue(action.methode()), action.ile2(), false)
          self.setDernierIle(tempIle)
        rescue => e
          puts e.message()
        end
      end
    end

    #Cette méthode permet de refaire une action annulé
    def redo()
      if(!@actions.empty?())
        begin
          action = @actions.redo()
          self.setDernierIle(action.ile1())
          self.send(action.methode(), action.ile2(), false)
        rescue => e
          puts e.message()
        end
      end
    end

    private def homologue(methode)
      if(methode == :createPont)
        return :supprimePont
      elsif(methode == :supprimePont)
        return :createPont
      else
        raise("Je ne connais pas la methode")
      end
    end

    #Cette méthode permet de connaitre la direction du pont qui pourrait relier ses deux iles
    #
    #@param ile1 La première ile
    #
    #@param ile2 La deuxième ile
    #
    #@return La direction du pont, retourne Pont::NULLE si les iles ne sont pas voisines
    def getDirectionPont(ile1, ile2)
      if(ile1.posX() == ile2.posX()) #alors pont horizontal
        return Pont::HORIZONTAL
      elsif(ile1.posY() == ile2.posY()) #alors pont vertical
        return Pont::VERTICAL
      else
        return Pont::NULLE
      end
    end


    #Cette méthode permet de connaitre la direction et les positions des ponts qui pourrait relier ses deux iles
    #
    #@param ile1 La première ile
    #
    #@param ile2 La deuxième ile
    #
    #@return direction, petitPos, grandPos
    #
    #direction : La direction du pont, retourne Pont::NULLE si les iles ne sont pas voisines
    #
    #petitPos : La plus petit coordonnée du pont (en abscisse ou en ordonnée en fontion de la direction)
    #
    #petitPos : La plus grande coordonnée du pont (en abscisse ou en ordonnée en fontion de la direction)
    def getDifference(ile1, ile2)

      direction = getDirectionPont(ile1, ile2)

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

    #Cette méthode permet de savoir si deux iles sont voisines
    #
    #@param ile1 La première ile
    #
    #@param ile2 La deuxième ile
    #
    #@return true si les iles sont voisines, false sinon
    def estVoisin?(ile1, ile2 = @dernierIle)
      proc = Proc.new do |pont|
        if(pont.estIle?())
          return false
        end
      end
      return parcoursPont(ile1, ile2, proc)
    end

    #Cette méthode permet de créer un pont entre deux iles
    #
    #@param ile2 La deuxième ile (La première est l'ile @dernierIle)
    #
    #return true si le pont a été créer, false sinon
    def createPont(ile2, action = true)
      direction = getDirectionPont(@dernierIle, ile2)
      if(action && direction != Pont::NULLE)
        self.addAction(@dernierIle, ile2, :createPont)
        ile2.ajouteNombrePont(@dernierIle)
        @dernierIle.ajouteNombrePont(ile2)
        print "Nombre chemin disponible : ", @dernierIle.getNombreCheminDisponible(), "\n"
        print "Capacite residuelle : ", @dernierIle.getCapaciteResiduelle(), "\n"
      end
      proc = Proc.new do |pont|
        pont.augmenteValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    #Cette méthode permet de supprimer un pont entre deux iles
    #
    #@param ile2 La deuxième ile (La première est l'ile @dernierIle)
    #
    #return true si le pont a été créer, false sinon
    def supprimePont(ile2, action = true)
      direction = getDirectionPont(@dernierIle, ile2)
      if(action && direction != Pont::NULLE)
        self.addAction(@dernierIle, ile2, :supprimePont)
        ile2.retireNombrePont(@dernierIle)
        @dernierIle.retireNombrePont(ile2)
        print "Nombre chemin disponible : ", @dernierIle.getNombreCheminDisponible(), "\n"
        print "Capacite residuelle : ", @dernierIle.getCapaciteResiduelle(), "\n"
      end
      proc = Proc.new do |pont|
        pont.diminueValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    #Cette méthode permet de mettre en surbrillance un pont entre deux iles
    #
    #@param ile2 La deuxième ile (La première est l'ile @dernierIle)
    #
    #return true si le pont a été mis en surbrillance, false sinon
    def surbrillancePont(ile2)
      direction = getDirectionPont(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.metSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    #Cette méthode permet d'enlever la surbrillance d'un pont entre deux iles
    #
    #@param ile2 La deuxième ile (La première est l'ile @dernierIle)
    #
    #return true si le pont n'est plus surbrillance, false sinon
    def eteintPont(ile2)
      direction = getDirectionPont(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.supprSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    def routeDisponible?(ile1, ile2)
      puts "Debout : " + ile1.to_s + " : " + ile2.to_s()
      direction = getDirectionPont(ile1, ile2)
      proc = Proc.new do |pont|
        if(pont.direction != Pont::NULLE && pont.direction != direction)
          return false
        end
      end
      return parcoursPont(ile1, ile2, proc)
    end

    #Cette méthode permet de parcourir les ponts entre deux ile avec un bloc
    #
    #@param ile1 La première ile
    #
    #@param ile2 La deuxième ile
    #
    #@param proc Le bloc
    def parcoursPont(ile1, ile2, proc)
      direction, petitPos, grandPos = getDifference(ile1, ile2)
      if(direction == Pont::HORIZONTAL)
        return parcoursPontHorizontal(petitPos, grandPos, proc, ile1.posX())
      elsif(direction == Pont::VERTICAL)
        return parcoursPontVertical(petitPos, grandPos, proc, ile1.posY())
      else
        return false
      end
    end

    private def parcoursPontVertical(petitPos, grandPos, proc, colonne)
      for i in (petitPos..grandPos)
        proc.call(@mat[i][colonne])
      end
      return true
    end

    private def parcoursPontHorizontal(petitPos, grandPos, proc, ligne)
      for i in (petitPos..grandPos)
        proc.call(@mat[ligne][i])
      end
      return true
    end

    #Cette méthode permet de modifier la dernière ile séléctionnée
    #
    #@param ile1 La nouvelle ile
    def setDernierIle(ile1)
      if(!@dernierIle.eql?(nil))
        effacePont()
      end
      @dernierIle = ile1
      montrePont()
      afficheToi()
    end

    #Cette méthode permet de recuperer la dernière ile séléctionnée
    #
    #@return La dernière ile séléctionnée
    def getDernierIle()
      return @dernierIle
    end


    #Cette méthode permet de mettre en surbrillance les pont disponibles de @dernierIle
    def montrePont()
      puts "montrePont"
      for direction in Ile::DIRECTIONS
        puts "direction : " + direction.to_s()
        if(@dernierIle.aVoisinDisponible?(direction))
          puts "direction : " + direction.to_s()
          surbrillancePont(@dernierIle.getVoisin(direction))
        end
      end
    end

    #Cette méthode permet d'enlever la surbrillance des pont disponibles de @dernierIle
    def effacePont()
      puts "montrePont"
      for direction in Ile::DIRECTIONS
        puts "direction : " + direction.to_s()
        if(@dernierIle.aVoisinDisponible?(direction))
          puts "direction : " + direction.to_s()
          eteintPont(@dernierIle.getVoisin(direction))
        end
      end
    end

    #Cette méthode permet de retourner la valeur du pont entre deux ile
    def valeurPont(ile1, ile2)
      direction, petitPos, grandPos = getDifference(ile1, ile2)
      if(direction == Pont::HORIZONTAL)

        pont = @mat[ile1.posX()][petitPos]

      elsif(direction == Pont::VERTICAL)

        pont = @mat[petitPos][ile1.posY()]

      elsif(direction == Pont::NULLE)

        return 0

      end

      if(pont.direction == direction)
        return pont.valeur
      end

      return 0

    end

end
