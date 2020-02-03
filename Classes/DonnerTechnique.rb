load("Aide.rb")
class DonnerTechnique < Aide
    ##
    #donne une technique de resolution à l'utilisateur en fonction de l'état de la grille
    #@param [grille] la grille de jeu actuel
    #@return [String] une chaine de caractère décrivant une technique à utiliser
    def demandeAide(grille, solution)
        #pont : valeur, direction
        #aide -> entier
        
        aide = decideTech(grille)

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
            "Repères les \"3\" dans les coins, ou possédant 2 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons pas forcément si il s'agit de pont simple ou double."
        when 6
            "Repères les \"5\" au bord de la grille, ou possédant 3 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons pas forcément si il s'agit de pont simple ou double."
        when 7
            "Repères les \"7\" possédant 4 îles voisines. Ils sont reliés à tous leurs voisins, bien que nous ne savons forcément pas si il s'agit de pont simple ou double."
        when 8
            "Quand un \"6\" et un \"1\" sont voisins, le \"6\" est relié par au moins 1 pont à ses trois autres voisins."
        when 9
            "On verras après."
        end
    end

    ##
    #donne l'entier correspondant à une technique à donner en fonction de la grille
    #@param [grille] la grille de jeu
    #@return [int]
    def decideAide(grille)
        
    end
end