


load "Compte.rb"


#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille
class Sauvegarde < ActiveRecord::Base


    #@grille => Contient la grille que l'utilisateur a commencé à remplir
    has_one :grille


    #@compte => Contient le compte auquel appartient la sauvegarde
    belongs_to :compte


    def to_s

        return "#{@compte} : #{@grille}"

    end

end
