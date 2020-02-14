
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "./Sauvegarde.rb"
require "active_record"


#Cette classe représente les comptes utilisateurs
#
#self.pseudo => Contient l'identifiant du compte
class Compte < ActiveRecord::Base

    has_many :sauvegardes

    validates :pseudo, presence: true, uniqueness: true

    private_class_method :new

    def Compte.creer(pseudo)

      new(:pseudo => pseudo)

    end

    #Cette méthode permet d'afficher un compte
    def to_s

        return "<Compte> '#{self.pseudo}'"

    end

end
