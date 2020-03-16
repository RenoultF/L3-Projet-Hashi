

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Compte.rb"
require "./Grille2Essai.rb"
require "active_record"


#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille et de faire des recherches sur les sauvegardes
class Sauvegarde < ActiveRecord::Base


    #@grille => Contient la grille que l'utilisateur a commencé à remplir


    validates :grille, presence: true



    #@compte => Contient le compte auquel appartient la sauvegarde
    belongs_to :compte

    validates :compte, presence: true


    validates :solution, presence: true


    private_class_method :new

    #Cette méthode permet de creer une grille pour un compte
    #
    #@param compte Le compte auquel la sauvegarde est lié
    #
    #@param grille La grille auquel la sauvegarde est lié
    #
    #@raise Si le compte possède déjà une sauvegarde de cette grille
    def Sauvegarde.creer(compte, grille)

      if(Sauvegarde.find_by(compte: compte, solution: YAML.dump(grille.matSolution)) == nil)

        new(:compte => compte, :grille => YAML.dump(grille), :taille => grille.tailleX(), :difficulte => grille.difficulte(), :solution => YAML.dump(grille.matSolution))

      else

        raise("Le compte a déjà une sauvegarde de cette grille")

      end

    end

    #Cette méthode permet de recuperer la sauvegarde d'un compte pour une grille
    #
    #@param compte Le compte auquel la sauvegarde est lié
    #
    #@param grille La grille auquel la sauvegarde est lié
    def Sauvegarde.recuperer(compte, grille)

      return Sauvegarde.find_by(compte: compte)

    end

    #Cette méthode permet de connaitre les sauvegardes d'un joueur
    #
    #@param compte Le compte du joueur
    #
    #@return Le tableau des sauvegardes du compte
    def Sauvegarde.listeCompte(compte)

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

      return self.save()

    end


    #Cette méthode permet de recuperer la grille de la sauvegarde
    def getGrille()

      return YAML.load(self.grille)

    end

    #Cette méthode permet de modifier la grille enregistré
    def setGrille(grille)

      self.grille = YAML.dump(grille)

      return self

    end

    #Cette méthode permet d'afficher une sauvegarde
    def to_s

        return "#{self.compte} : #{self.getGrille()}"

    end

end
