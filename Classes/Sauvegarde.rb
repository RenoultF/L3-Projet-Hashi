

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Compte.rb"
require "./Grille.rb"
require "active_record"


#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille et de faire des recherches sur les sauvegardes
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

      new(:compte => compte, :grille => YAML.dump(grille), :taille => grille.getTaille(), difficulte => grille.getDifficulte())

    end

    #Cette méthode permet de connaitre les sauvegardes d'un joueur
    #
    #@param compte Le compte du joueur
    #
    #@return Le tableau des sauvegardes du compte
    def Sauvegarde.liste(compte)

      return Sauvegarde.where(compte: compte).to_a()

    end

    #Cette méthode permet de connaitre les sauvegardes d'un joueur
    #
    #@param compte Le compte du joueur
    #
    #@param taille La taille de la grille
    #
    #@param difficulte La difficulte de la grille
    #
    #@return Le tableau des sauvegardes du compte de taille et difficulte donné
    def Sauvegarde.liste(compte, taille, difficulte)

      return Sauvegarde.where(compte: compte, taille: taille, difficulte: difficulte).to_a()

    end


    #Cette méthode permet d'enregistrer la sauvegarde
    #
    #@return true si la sauvegarde est efféctué, false sinon
    def sauvegarder()

      return self.save();

    end

    #Cette méthode permet de recuperer la grille de la sauvegarde
    def getGrille()

      return YAML.load(self.grille.sauvegarde)

    end

    #Cette méthode permet de modifier la grille enregistré
    def setGrille(grille)

      self.grille.sauvegarde = YAML.dump(grille)

    end

    #Cette méthode permet d'afficher une sauvegarde
    def to_s

        return "#{self.compte} : #{self.grille_id}"

    end

end
