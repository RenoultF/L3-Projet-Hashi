

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Compte.rb"
require "active_record"


#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille
class Sauvegarde < ActiveRecord::Base


    #@grille => Contient la grille que l'utilisateur a commencé à remplir
  #  has_one :grille


    #@compte => Contient le compte auquel appartient la sauvegarde
    belongs_to :compte

    #Cette méthode permet d'afficher une sauvegarde
    def to_s

        return "#{compte} : #{grille_id}"

    end

end
