

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Compte.rb"
require "active_record"


#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille
class Sauvegarde < ActiveRecord::Base


    #@grille => Contient la grille que l'utilisateur a commencé à remplir
    has_one :grille

    validates :grille, presence: true, uniqueness: true



    #@compte => Contient le compte auquel appartient la sauvegarde
    belongs_to :compte

    validates :compte, presence: true


    private_class_method :new

    #Cette méthode permet de creer une grille pour un compte
    #
    #@param compte Le compte auquel la sauvegarde est lié
    #
    #@param grille La grille auquel la sauvegarde est lié
    def Sauvegarde.creer(compte, grille)

      new(:compte => compte, :grille => grille)

    end

    #Cette méthode permet d'enregistrer la sauvegarde
    #
    #@return true si la sauvegarde est efféctué, false sinon
    def sauvegarder()

      return self.save();

    end

    #Cette méthode permet de connaitre les sauvegardes d'un joueur
    #
    #@param compte Le compte du joueur
    def Sauvegarde.liste(compte)

      return Sauvegarde.where(compte: compte).to_a()

    end


    #Cette méthode permet d'afficher une sauvegarde
    def to_s

        return "#{compte} : #{grille_id}"

    end

end
