
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

#load "Sauvegarde.rb"
require "active_record"


#Cette classe représente les comptes utilisateurs
class Compte < ActiveRecord::Base

    #@pseudo => Contient l'identifiant du compte
    attr_reader :pseudo

    private_class_method :new

    def Compte.creer(pseudo)

        new(pseudo)

    end

    #:nodoc:
    def initialize(pseudo)

        @pseudo = pseudo

    end
    #:doc:

    has_many :sauvegardes

    #Cette méthode permet d'afficher un compte
    def to_s

        return "#{@pseudo}"

    end

end
