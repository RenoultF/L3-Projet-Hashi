def initialize(chaine, tailleX, tailleY, difficulte)

    if(chaine.length != tailleX * tailleY)

      raise("La taille n'est pas la bonne")

    end
    @difficulte = difficulte
    i = 0
    j = 0
    @tailleX = tailleX
    @tailleY = tailleY
    @mat = new Case[tailleX][tailleY]
    @matSolution = new Case[tailleX][tailleY]
    chaine.each do |c|

      if(c =~ /[1-8]/)

        @mat[i][j] = Ile.creer(i, j, c.ord(), self)
        @matSolution[i][j] = Ile.creer(i, j, c.ord(), self)

      elsif(c = '|')

        @matSolution[i][j] = Pont.construit(i, j, self, Pont.VERTICAL, 1)
        @mat[i][j] = Pont.creer(i, j, self)


      elsif(c = '"')

        @matSolution[i][j] = Pont.construit(i, j, self, Pont.VERTICAL, 2)
        @mat[i][j] = Pont.creer(i, j, self)

      elsif(c = '-')

        @matSolution[i][j] = Pont.construit(i, j, self, Pont.HORIZONTAL, 1)
        @mat[i][j] = Pont.creer(i, j, self)

      elsif(c = '=')

        @matSolution[i][j] = Pont.construit(i, j, self, Pont.HORIZONTAL, 2)
        @mat[i][j] = Pont.creer(i, j, self)

      elsif(c = ' ')

        @matSolution[i][j] = Case.generer(i, j, self)
        @mat[i][j] = Case.generer(i, j, self)

      end

      j += 1
      if(j >= tailleY)

        j = 0
        i += 1

      end

    end
    @dernierIle = nil
end
