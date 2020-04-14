load("Aide.rb")
# DEPRECATED
class DonnerTechnique < Aide
    ##
    #donne une technique de resolution à l'utilisateur en fonction de l'état de la grille
    #@param [grille] la grille de jeu actuel
    #@return [String] une chaine de caractère décrivant une technique à utiliser
    def demandeAide(grille, solution)
        #pont : valeur, direction
        #aide -> entier

        aide = decideTech(grille, solution)

        case aide
        when 1
            "Si il y a un \"4\" dans un coin, ses deux ponts adjacents sont des doubles ponts !"
        when 2
            "Si il y a un \"6\" au bord de la grille, ses trois ponts adjacents sont des doubles ponts !"
        when 3
            "Un \"8\" est relié par des doubles ponts de tous les cotés"
        when 4
            "Certaines îles n'ont qu'un seul voisin. Si cette îles contient un 1, elle y sera reliée par un pont simple. Si elle contient un 2, elle y sera reliée par un double."
        when 5
            "Repères les \"3\" dans les coins, ou possédant 2 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons pas forcément si il s'agit de ponts simples ou doubles."
        when 6
            "Repères les \"5\" au bord de la grille, ou possédant 3 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons pas forcément si il s'agit de ponts simples ou doubles."
        when 7
            "Repères les \"7\" possédant 4 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons forcément pas si il s'agit de ponts simples ou doubles."
        when 8
            "Quand un \"6\" et un \"1\" sont voisins, le \"6\" est relié par au moins 1 pont à ses trois autres voisins."
        when 9
            "Deux \"1\" adjacents ne peuvent pas être relié. Un \"1\" ayant deux voisins dont un autre \"1\" est donc relié à son autre voisin."
        when 10
            "Deux \"2\" adjacents ne peuvent pas être relié par un double pont. Un \"2\" ayant deux voisins dont un autre \"2\" est lié à son autre voisin."
        when 11
            "Un \"2\" possédant 3 voisins dont deux \"1\" est lié au 3eme voisin."
        when 12
            "Un \"3\" possédant 3 voisins dont un \"1\" et un \"2\" est lié au 3eme voisin."
        when 177013
            "C'est l'histoire d'un têtard il croyait qu'il était tôt mais en fait il était tard."#wala c pa oam c manal
        end
    end

    ##
    #donne l'entier correspondant à une technique à donner en fonction de la grille
    #@param [grille] la grille de jeu
    #@return [int] numero d'aide
    def decideAide(grille, solution)
        grille.mat.each do |c|
          if(c.instance_of? Ile)
            if(c.valeur == 4 && (c.posX == 0 || c.posX == grille.tailleX) && (c.posY == 0 || c.posY == grille.tailleY) && !VerifierGrille.verifierIle(c, solution))
              res = 1
            elsif(c.valeur == 6 && (c.posX == 0 || c.posX == grille.tailleX) || (c.posY == 0 || c.posY == grille.tailleY) && !VerifierGrille.verifierIle(c, solution))
              res = 2
            elsif(c.valeur == 8 && !VerifierGrille.verifierIle(c, solution))
              res = 3
            elsif(c.lstVoisins.length == 1 && (c.valeur == 1 || c.valeur == 2) && !VerifierGrille.verifierIle(c, solution))
              res = 4
            elsif(c.valeur == 3 && c.lstVoisins.length == 2 && !VerifierGrille.estAPeuPresBienReliee(c, solution))
              res = 5
            elsif(c.valeur == 5 && c.lstVoisins.length == 3 && !VerifierGrille.estAPeuPresBienReliee(c, solution))
              res = 6
            elsif(c.valeur == 7 && c.lstVoisins.length == 4 && !VerifierGrille.estAPeuPresBienReliee(c, solution))
              res = 7
            elsif(c.valeur == 6 && c.lstVoisins.include?(1) && !VerifierGrille.estAPeuPresBienReliee(c, solution))
              res = 8
            elsif(c.valeur == 1 && c.lstVoisins.length == 2 && !VerifierGrille.verifierIle(c, solution))
              res = 9
            elsif(c.valeur == 1 && grille.valeurPont(c, c.lstVoisins.bsearch{|v| v.valeur == 1}) < 0)
              res = 9
            elsif(c.valeur == 2 && c.lstVoisins.length == 2 && !VerifierGrille.estAPeuPresBienReliee(c, solution))
              res = 10
            elsif(c.valeur == 2 && grille.valeurPont(c, c.lstVoisins.bsearch{|v| v.valeur == 2}) == 2)
              res = 10
            elsif(c.valeur == 2 && c.lstVoisins.length == 3 && c.lstVoisins.count{|v| v.valeur == 1} == 2 && grille.valeurPont(c, c.lstVoisins.bsearch{|v| v.valeur != 1}) == 0)
              res = 11
            elsif(c.valeur == 3 && c.lstVoisins.length == 3 && c.lstVoisins.include?(1) && c.lstVoisins.count{|v| v.valeur == 2} == 1 && grille.valeurPont(c, c.lstVoisins.bsearch{|v| v.valeur != 1 && v.valeur != 2}) == 0)
              res = 12
            elsif(VerifierGrille.bTetard)
              res = 177013
            end
          end
        end
        return res
    end
end
