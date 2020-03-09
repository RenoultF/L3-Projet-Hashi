class Checkpoint

    private_class_method :new

    def Checkpoint.creer(grille)
        new(grille)
    end

    def initialize(grille)
        @grille = grille
        @check = Array.new()
    end

    ##
    #valide l'hypothese et l'ajoute dans la pile d'action
    def valider()
        @longueurpileAvant = nil
        until checkpointVide()
            @grille.actions.push(@check.shift)
        end
    end

    ##
    #Supprime a derniere action réalisée dans l'hypothese
    def supprimer_derniere_action()
        @check.pop
    end

    ##
    #Supprime l'hypothese entierement si pleine fait rien sinon
    def supprimer_checkpoint()
        #Retire tout les elements sauf le dernier
        if(@longueurpileAvant != nil)
            until(@longueurpileAvant<@grille.getAction().size())
                @grille.removeAction()
            end
        else
            puts("Checkpoints non utilisé")
        end
    end

    ##
    #Permettre d'emettre une hypothese dans le checkpoint
    def emettre()
        @longueurpileAvant = @grille.getAction().size()
    end

    ##
    #Permet d'afficher l'hypothese
    def afficher_stack()
        puts "#{@check}"
    end

    ##
    #Verifie si le checkpoint est vide
    def checkpointVide()
        return @check.empty?
    end

    def getIndice()
        return @indice
    end




end

#checkpoint = Checkpoint.creer()

#checkpoint.emettre(5)
#checkpoint.emettre(4)
#checkpoint.supprimer_derniere_action
#checkpoint.emettre(10)
#checkpoint.emettre(6)
#checkpoint.afficher_stack()

#checkpoint.supprimer_checkpoint

#checkpoint.afficher_stack()
