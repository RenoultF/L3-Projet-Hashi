# DEPRECATED
class Checkpoint

    private_class_method :new

    def Checkpoint.creer(grille)
        new(grille)
    end

    def initialize(grille)
        @grille = grille
        @check = Array.new()
    end

    def valider()
        @longueurpileAvant = nil
        #retire les actions de la liste et les mets dans la liste d'action
        #de la grille (@check.shift pour prendre le premier element)
    end

    def supprimer_derniere_action()
        @check.pop
    end

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

    def emettre()
        @longueurpileAvant = @grille.getAction().size()
    end

    def afficher_stack()
        puts "#{@check}"
    end

    def checkpointVide()
        return @check.empty?
    end

    def getIndice()
        return @indice
    end




end
=begin
checkpoint = Checkpoint.creer()

checkpoint.emettre(5)
checkpoint.emettre(4)
checkpoint.supprimer_derniere_action
checkpoint.emettre(10)
checkpoint.emettre(6)
checkpoint.afficher_stack()

checkpoint.supprimer_checkpoint

checkpoint.afficher_stack()
=end
