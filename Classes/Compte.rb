
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Sauvegarde.rb"
require "active_record"


#Cette classe représente les comptes utilisateurs
class Compte < ActiveRecord::Base

    has_many :sauvegardes

    validates :name, presence: true, uniqueness: true

    #@pseudo => Contient l'identifiant du compte
    attr_reader :pseudo

    private_class_method :new

    #Cette méthode permet de creer un nouveau compte
    #
    #@param pseudo Le pseudo du compte
    def Compte.creer(pseudo)

      new(pseudo)

    end

    def initialize(pseudo)

      super(:name => pseudo)
      @pseudo = pseudo

    end

    #Cette méthode permet de récuperer un compte dans la base de données
    #
    #@param pseudo Le pseudo du compte
    def Compte.recuperer(pseudo)

      return Compte.where(name: pseudo).to_a()[0];

    end

    #Cette méthode permet de sauvegarder le compte
    #
    #@return true si la sauvegarde est efféctué, false sinon
    def sauvegarder()

      self.name = @pseudo

      return self.save();

    end

    #Cette méthode permet d'afficher un compte
    def to_s

        return "<Compte> '#{@pseudo}'"

    end

end
