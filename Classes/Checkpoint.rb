class Checkpoint

    private_class_method :new

    def Checkpoint.creer(grille)
        new(grille)
    end

    def initialize(grille)
        #indice = 
        @grille = grille
        @check = Array.new()
    end

    def valider()
        #retire les actions de la liste et les mets dans la liste d'action
        #de la grille (@check.shift pour prendre le premier element)
    end

    def supprimer_derniere_action()
        @check.pop
    end

    def supprimer_checkpoint()
        i = 0
        #Retire tout les elements sauf le dernier
        while i <  @check.size #+ 2
            @check.pop
            i += 1
        end
        #Retire le dernier element
        @check.pop
    end

    def emettre(valeur)
        @check.push(valeur)
    end

    def afficher_stack()
        puts "#{@check}"
    end

end

checkpoint = Checkpoint.creer()

checkpoint.emettre(5)
checkpoint.emettre(4)
checkpoint.supprimer_derniere_action
checkpoint.emettre(10)
checkpoint.emettre(6)
checkpoint.afficher_stack()

checkpoint.supprimer_checkpoint

checkpoint.afficher_stack()
