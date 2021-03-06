require_relative "../Core/Case.rb"
require_relative "../Core/Ile.rb"
require_relative "../Core/Pont.rb"
require_relative "../Core/Pile.rb"
require_relative "../Core/UndoRedo.rb"
require_relative "../Core/Hypothese.rb"
require_relative "../Core/Action.rb"


##
# Auteur:: Brabant Mano, Renoult Florent
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe représente une grille de jeu avec les cases, la pile d'action, les hypoyhèses, etc
class Grille



    #@dernierIle => La dernière ile séléctionnée par l'utilisateur

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

    #@mat => La matrice de jeu
    attr_reader :mat

    #@score => Le score de la grille
    attr_accessor :score

    #@couleurs => Les couleurs que prennent les ponts en fonction du niveau d'hypothèse
    attr_reader :couleurs


    include Comparable

    ##
    #Cette méthode permet de retourner toutes les grilles d'un dossier
    #param::
    # * dossier Le dossier où on va chercher les grilles
    def Grille.chargerGrilles(dossier)

      ret = Array.new()
      Dir.each_child(dossier) do |fichier|
        text = File.open(dossier + "/" + fichier).read
        text.gsub!(/\r\n/, "\n");
        ret.push(Grille.creer(text))
      end
      return ret

    end


    private_class_method :new

    ##
    #Ce constructeur permet de créer une nouvelle grille
    #param::
    # * chaine La chaine génératrice
    #Le format de la chaine est::
    # * "#T tailleGrilleX tailleGrilleY"
    # * "#D difficulteGrille"
    # * Ensemble de caractères séparés par des espaces pour coder la grille complète
    #Les caractères spéciaux sont::
    # * \[1-8\] Correspont à une ile avec le même nombre de liens à faire
    # * N Correspont à une case vide
    # * \- Correspont à un pont horizontal simple
    # * \= Correspont à un pont horizontal double
    # * | Correspont à un pont vertical simple
    # * H Correspont à un pont vertical double
    def Grille.creer(chaine)
        new(chaine)
    end


    #:nodoc:
    def initialize(chaine)
      #puts "chaine", chaine

        i = -1
        j = -1

        chaine.each_line do |l|
          if(l.start_with?("#T"))
            t = l.split(' ')
            @tailleX = t[1].to_i()
            @tailleY = t[2].to_i()
            @mat = Array.new(@tailleX) { Array.new(@tailleY) }
            @matSolution = Array.new(@tailleX) { Array.new(@tailleY) }
          elsif(l.start_with?("#D"))
            d = l.split(' ')
            @difficulte = d[1].to_i()
          else
            i += 1
            j = -1
            l.split(' ') do |c|
              #print c
              j += 1
              if(c =~ /[1-8]/)
                @mat[i][j] = Ile.creer(i, j, c.ord() - '0'.ord(), self)
                @matSolution[i][j] = Ile.creer(i, j, c.ord() - '0'.ord(), self)
              elsif(c == '|')
                @matSolution[i][j] = Pont.construit(i, j, self, Pont::VERTICAL, 1)
                @mat[i][j] = Pont.creer(i, j, self)
              elsif(c == 'H')
                @matSolution[i][j] = Pont.construit(i, j, self, Pont::VERTICAL, 2)
                @mat[i][j] = Pont.creer(i, j, self)
              elsif(c == '-')
                @matSolution[i][j] = Pont.construit(i, j, self, Pont::HORIZONTAL, 1)
                @mat[i][j] = Pont.creer(i, j, self)
              elsif(c == '=')
                @matSolution[i][j] = Pont.construit(i, j, self, Pont::HORIZONTAL, 2)
                @mat[i][j] = Pont.creer(i, j, self)
              elsif(c == 'N')
                @matSolution[i][j] = Pont.creer(i, j, self)
                @mat[i][j] = Pont.creer(i, j, self)
              end
            end
          end
        end
        recommencer()
    end
    #:doc:

    ##
    #Cette méthode permet d'afficher les cases de la grille
    def afficheToi()
      print "\t"
      for colonne in (0..tailleX-1)
        print colonne.to_s() + " "
      end
      print "\n"
      ligne = -1
      @mat.each do |i|
        print (ligne+=1).to_s() + " :\t"
        i.each do |j|
          print j.to_s() + " "
        end
        print "\n"
      end
    end

    ##
    #Cette méthode permet d'afficher les cases de la grille solution
    def afficheSolution()
      print "\t"
      for colonne in (0..tailleX-1)
        print colonne.to_s() + " "
      end
      print "\n"
      ligne = -1
      @matSolution.each do |i|
        print (ligne+=1).to_s() + " :\t"
        i.each do |j|
          print j.to_s() + " "
        end
        print "\n"
      end
    end

    ##
    #Cette méthode permet de savoir si la grille est finie (si tous les ponts ont été placé comme dans la solution)
    #return::
    # * true Si la grille est finie
    # * false Sinon
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

    ##
    #Cette méthode permet de savoir si les coordonnées passées sont comprises dans la grille
    #param::
    # * posX La position en abscisse
    # * posY La position en ordonnée
    #return::
    # * true Si les coordonnées sont valides
    # * false Sinon
    def sortLimite?(posX, posY)
      if(posX < 0 || posY < 0 || posX >= @tailleX || posY >= @tailleY)
        return true
      end
      return false
    end

    ##
    #Cette méthode permet de recuperer la matrice de cases
    def getGrille()
        return @mat
    end

    ##
    #Cette méthode permet de savoir si la grille a une solution identique à une autre grille
    #param::
    # * grille L'autre grille
    #return::
    # * true Si les grilles ont la même solution
    # * false Sinon
    def memeSolution(grille)

      return false if(@tailleX != grille.tailleX || @tailleY != grille.tailleY)
      for i in (0..(@tailleX-1))
        for j in (0..(@tailleY-1))
          if(self.getCaseSolution(i, j) != grille.getCaseSolution(i, j))
            return false
          end
        end
      end
      return true

    end

    ##
    #Cette méthode permet de recuperer une case de la grille
    #param::
    # * i La position en abscisse
    # * j La position en ordonnée
    #return::
    # * La case à la position [i][j]
    def getCase(i, j)
        return @mat[i][j]
    end

    ##
    #Met à jour le temps que l'utilisateur a mis à finir la map
    #param::
    # * minutes Le nombre de minutes
    # * secondes Le nombre seconde
    def setTempsFin(minutes,secondes)
      @minutesFin = minutes
      @secondesFin =secondes
    end

    ##
    #Cette méthode permet de recupérer une case de la grille solution
    #param::
    # * i La position en abscisse
    # * j La position en ordonnée
    #return::
    # * La case à la position (i, j)
    def getCaseSolution(i, j)
        return @matSolution[i][j]
    end

    ##
    #Cette méthode permet d'émetre une nouvelle hypothèse (changer la couleur des ponts que l'on va modifier)
    def creerHypothese()
      begin
        undoCouleurPont(@couleurs.undo())
      rescue => e
        puts e
      end
    end

    ##
    #Cette méthode permet de valider la dernière hypothèse (prendre tous les ponts de la dernière couleur et les changer à l'avant dernière)
    def valideHypothese()
      begin
        @couleurs.redo()
        @couleurs.redo()
        redoCouleurPont(@couleurs.undo())
      rescue => e
        puts e.message()
      end
    end

    ##
    #Cette méthode permet de supprimer la dernière hypothèse (supprime tous les ponts de la dernière couleur)
    def supprimeHypothese()
      begin
        @couleurs.redo()
        @couleurs.redo()
        redoSupprCouleurPont(@couleurs.undo())
        setDernierIle(@dernierIle)
      rescue => e
        puts e.message()
      end
    end



    ##
    #Méthode à appeler quand on appuie sur une ile
    #param::
    # * ile L'ile sur laquelle on a cliqué
    def clickOnIle(ile)
      setDernierIle(ile)
    end


    ##
    #Méthode à appeler quand on appuie sur un pont
    #param::
    # * pont Le pont sur lequel on a cliqué
    def clickOnPont(pont)

      if(!@dernierIle.eql?(nil))
        if(pont.surbrillance())
          self.chercherVoisins(pont, pont.directionSurbrillance)
          @score -= 20
        else
          self.setDernierIle(nil)
        end
      end

    end

    ##
    #Cette méthode permet de remmetre à zéro la grille
    def recommencer()

      @actions = UndoRedo.creer()

      setDernierIle(nil)
      @score = 500 * @tailleX


      @couleurs = UndoRedo.creer()

      @couleurs.empiler(Couleur::JAUNE)
      @couleurs.empiler(Couleur::CYAN)
      @couleurs.empiler(Couleur::MAGENTA)
      @couleurs.empiler(Couleur::VERT)
      @couleurs.empiler(Couleur::BLEU)
      @couleurs.empiler(Couleur::NOIR)


      undoCouleurPont(@couleurs.undo())

      @mat.each do |ligne|
        ligne.each do |c|
          c.raz()
        end
      end

    end


    ##
    #Cette méthode permet de créer un pont entre la dernière ile et une autre ile qui passe par un pont donné
    #param::
    # * pont La case pont par laquelle doit passer le pont entre les deux iles
    # * direction La direction dans laquelle est dirigé le pont
    def chercherVoisins(pont, direction)

      if(direction == Pont::HORIZONTAL)

        i = pont.posX
        j = pont.posY
        while(!sortLimite?(i, j) && !(ileDroite = getCase(i, j)).estIle?())
          j += 1
        end
        j = pont.posY
        while(!sortLimite?(i, j) && !(ileGauche = getCase(i, j)).estIle?())
          j -= 1
        end

        temp = @dernierIle
        if(ileGauche == @dernierIle)
          ile2 = ileDroite
        elsif(ileDroite == @dernierIle)
          ile2 = ileGauche
        else
          ile2 = ileDroite
          setDernierIle(ileGauche)
        end
        createPont(ile2)
        setDernierIle(temp)

      elsif(direction == Pont::VERTICAL)

        i = pont.posX
        j = pont.posY
        while(!sortLimite?(i, j) && !(ileBas = getCase(i, j)).estIle?())
          i += 1
        end
        i = pont.posX
        while(!sortLimite?(i, j) && !(ileHaut = getCase(i, j)).estIle?())
          i -= 1
        end

        temp = @dernierIle
        if(ileBas == @dernierIle)
          ile2 = ileHaut
        elsif(ileHaut == @dernierIle)
          ile2 = ileBas
        else
          ile2 = ileHaut
          setDernierIle(ileBas)
        end
        createPont(ile2)
        setDernierIle(temp)
      end

    end

    ##
    #Cette méthode permet d'appeler la méthode Case#redoCouleurPont de chaque case de la grille
    #param::
    # * couleur La couleur à passer à la méthode Case#redoCouleurPont
    def redoCouleurPont(couleur)

      @mat.each do |ligne|
        ligne.each do |c|
          if(c.estPont?())
            c.redoCouleurPont(couleur)
          end
        end
      end

    end

    ##
    #Cette méthode permet d'appeler la méthode Case#redoCouleurPont de chaque cases de la grille et de supprimer les ponts de la dernière hypothèse
    #param::
    # * couleur La couleur à passer à la méthode Case#redoCouleurPont
    def redoSupprCouleurPont(couleur)

      @mat.each do |ligne|
        ligne.each do |c|
          if(c.estPont?())
            if(c.couleurPont == c.couleurPontCourante)
              while(c.valeur != 0)
                #print "Valeur", c.valeur, c.direction, "\n"
                chercherVoisins(c, c.direction)
              end
            end
            c.redoCouleurPont(couleur)
          end
        end
      end

    end


    ##
    #Cette méthode permet d'appeler la méthode Case#undoCouleurPont de chaque cases de la grille
    #param::
    # * couleur La couleur à passer à la méthode Case#undoCouleurPont
    def undoCouleurPont(couleur)

      @mat.each do |ligne|
        ligne.each do |c|
          if(c.estPont?())
            c.undoCouleurPont(couleur)
          end
        end
      end

    end


    ##
    #Cette méthode permet d'ajouter une action à la pile d'action
    #param::
    # * ile1 La premère ile
    # * ile2 La deuxième ile
    # * methode La méthode utilisée (:createPont ou :supprimePont)
    def addAction(ile1, ile2, methode)
      @actions.empiler(Action.creer(ile1, ile2, methode))
    end

    ##
    #Cette méthode permet d'annuler la dernière action éffectuée par l'utilisateur
    def undo()
      if(!@actions.empty?())
        begin
          tempIle = self.getDernierIle()
          action = @actions.undo()
          self.setDernierIle(action.ile1())
          #Invoque l'inverse de la méthode utilisée sans l'ajouter à la undoRedo d'action
          self.send(homologue(action.methode()), action.ile2(), false)
          self.setDernierIle(tempIle)
        rescue => e
          puts e.message()
        end
      end
    end

    ##
    #Cette méthode permet de refaire la dernière action annulée par le undo
    def redo()
      if(!@actions.empty?())
        begin
          action = @actions.redo()
          self.setDernierIle(action.ile1())
          #Invoque la méthode utilisée sans l'ajouter à la undoRedo d'action
          self.send(action.methode(), action.ile2(), false)
        rescue => e
          puts e.message()
        end
      end
    end

    ##
    #Donne la méthode inverse de celle passée en paramètre
    #param::
    # * methode La méthode dont-il faut retourner l'inverse
    #return::
    # * Une méthode qui permet en l'appelant avec les mêmes paramètres de revenir à l'état précédent
    private def homologue(methode)
      if(methode == :createPont)
        return :supprimePont
      elsif(methode == :supprimePont)
        return :createPont
      else
        raise("Je ne connais pas la methode")
      end
    end

    ##
    #Cette méthode permet de connaitre la direction du pont qui pourrait relier deux iles
    #param::
    # * ile1 La première ile
    # * ile2 La deuxième ile
    #return::
    # *  La direction du pont Si les deux iles sont voisines
    # *  Pont::NULLE Sinon
    def getDirectionPont(ile1, ile2)
      if(ile1.posX() == ile2.posX()) #alors pont horizontal
        return Pont::HORIZONTAL
      elsif(ile1.posY() == ile2.posY()) #alors pont vertical
        return Pont::VERTICAL
      else
        return Pont::NULLE
      end
    end

    ##
    #Cette méthode permet de connaitre la direction et les positions des ponts qui pourrait relier deux iles
    #param::
    # * ile1 La première ile
    # * ile2 La deuxième ile
    #return::
    # * direction : La direction du pont, retourne Pont::NULLE si les iles ne sont pas voisines
    # * petitPos : La plus petite coordonnée du pont (en abscisse ou en ordonnée en fontion de la direction)
    # * grandPos : La plus grande coordonnée du pont (en abscisse ou en ordonnée en fontion de la direction)
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

    ##
    #Cette méthode permet de savoir si deux iles sont voisines
    #param::
    # * ile1 La première ile
    # * ile2 La deuxième ile
    #return::
    # * true Si les iles sont voisines
    # * false Sinon
    def estVoisin?(ile1, ile2 = @dernierIle)
      proc = Proc.new do |pont|
        if(pont.estIle?())
          return false
        end
      end
      return parcoursPont(ile1, ile2, proc)
    end

    ##
    #Cette méthode permet de créer un pont entre deux iles
    #param::
    # * ile2 La deuxième ile (La première est l'ile @dernierIle)
    # * action Boolean, si true on ajoute l'action à la pile d'action, si false on ne l'ajoute pas
    #return::
    # * true Si le pont a été créé
    # * false Sinon
    def createPont(ile2, action = true)
      direction = getDirectionPont(@dernierIle, ile2)
      if(direction != Pont::NULLE)
        if(action)
          self.addAction(@dernierIle, ile2, :createPont)
        end
        ile2.ajouteNombrePont(@dernierIle)
        @dernierIle.ajouteNombrePont(ile2)
      end
      proc = Proc.new do |pont|
        pont.augmenteValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    ##
    #Cette méthode permet de supprimer un pont entre deux iles
    #param::
    # * ile2 La deuxième ile (La première est l'ile @dernierIle)
    # * action Boolean, si true on ajoute l'action à la pile d'action, si false on ne l'ajoute pas
    #return::
    # * true Si le pont a été supprimer
    # * false Sinon
    def supprimePont(ile2, action = true)
      direction = getDirectionPont(@dernierIle, ile2)
      if(direction != Pont::NULLE)
        if(action)
          self.addAction(@dernierIle, ile2, :supprimePont)
        end
        ile2.retireNombrePont(@dernierIle)
        @dernierIle.retireNombrePont(ile2)
      end
      proc = Proc.new do |pont|
        pont.diminueValeur(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end


    ##
    #Cette méthode permet de mettre en surbrillance un pont entre deux iles
    #param::
    # * ile2 La deuxième ile (La première est l'ile @dernierIle)
    #return::
    # * true Si le pont a été mis en surbrillance
    # * false Sinon
    def surbrillancePont(ile2)
      direction = getDirectionPont(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.metSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    ##
    #Cette méthode permet de retirer la surbrillance d'un pont entre deux iles
    #param::
    # * ile2 La deuxième ile (La première est l'ile @dernierIle)
    #return::
    # * true Si le pont n'est plus en surbrillance
    # * false Sinon
    def eteintPont(ile2)
      direction = getDirectionPont(@dernierIle, ile2)
      proc = Proc.new do |pont|
        pont.supprSurbrillance(direction)
      end
      return parcoursPont(@dernierIle, ile2, proc)
    end

    ##
    #Cette méthode permet de savoir si la route entre deux pont est disponible (iles voisines et pas séparées par un pont)
    #param::
    # * ile1 La première ile
    # * ile2 La deuxième ile
    def routeDisponible?(ile1, ile2)
      direction = getDirectionPont(ile1, ile2)
      proc = Proc.new do |pont|
        if(pont.direction != Pont::NULLE && pont.direction != direction)
          return false
        end
      end
      return parcoursPont(ile1, ile2, proc)
    end

    ##
    #Cette méthode permet de parcourir les ponts entre deux iles avec un bloc
    #param::
    # * ile1 La première ile
    # * ile2 La deuxième ile
    # * proc Le bloc
    #return::
    # * false Si les deux iles ne sont pas voisines
    # * La valeur de retour du bloc sinon
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

    ##
    #Cette méthode permet de faire un parcours vertical
    #param::
    # * petitPos La plus petite position du pont
    # * grandPos La plus grande position du pont
    # * proc Le bloc à effectuer sur chaque pont
    # * colonne La colonne à parcourir
    private def parcoursPontVertical(petitPos, grandPos, proc, colonne)
      for i in (petitPos..grandPos)
        proc.call(@mat[i][colonne])
      end
      return true
    end

    ##
    #Cette méthode permet de faire un parcours horizontal
    #param::
    # * petitPos La plus petite position du pont
    # * grandPos La plus grande position du pont
    # * proc Le bloc à effectuer sur chaque pont
    # * ligne La ligne à parcourir
    private def parcoursPontHorizontal(petitPos, grandPos, proc, ligne)
      for i in (petitPos..grandPos)
        proc.call(@mat[ligne][i])
      end
      return true
    end

    ##
    #Cette méthode permet de modifier la dernière ile séléctionnée
    #param::
    # * ile1 La nouvelle ile
    def setDernierIle(ile1)
      if(!@dernierIle.eql?(nil))
        effacePont()
        @dernierIle.dernier = false
      end
      @dernierIle = ile1
      if(!@dernierIle.eql?(nil))
        montrePont()
        #afficheToi()
        @dernierIle.dernier = true
      end
    end

    ##
    #Cette méthode permet de recupérer la dernière ile séléctionnée
    #return::
    # * La dernière ile séléctionnée
    def getDernierIle()
      return @dernierIle
    end

    ##
    #Cette méthode permet de mettre en surbrillance les ponts disponibles de @dernierIle
    def montrePont()
      for direction in Ile::DIRECTIONS
        if(@dernierIle.aVoisinDisponible?(direction))
          surbrillancePont(@dernierIle.getVoisin(direction))
        end
      end
    end

    ##
    #Cette méthode permet d'enlever la surbrillance des ponts disponibles de @dernierIle
    def effacePont()
      for direction in Ile::DIRECTIONS
        if(@dernierIle.aVoisinDisponible?(direction))
          eteintPont(@dernierIle.getVoisin(direction))
        end
      end
    end

    ##
    #Cette méthode permet de retourner la valeur du pont entre deux iles
    #return::
    # * La valeur du pont entre deux iles Si elles sont réliées
    # * 0 Sinon
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

    ##
    #Cette méthode permet de sauvegarder la grille dans la base de données
    #param::
    # * compte Le compte pour lequel on va sauvegarder la grille
    def sauvegarder(compte)

      save = Sauvegarde.recuperer(compte, self)
      save.setGrille(self)
      if(fini?())
        save.setScore([save.getScore(), @score].max) if self.fini?()
      end
      save.sauvegarder()

    end

    ##
    #Cette méthode permet de récupérer le meilleur score du joueur sur la grille
    #param::
    # * compte Le compte dont-on va récupérer le meilleur score
    #return::
    # * Le meilleur score
    def getMeilleurScore(compte)
      Sauvegarde.recuperer(compte, self).getScore()
    end

end
