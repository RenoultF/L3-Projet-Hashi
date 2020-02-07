

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


load "Compte.rb"
load "Sauvegarde.rb"
require "active_record"
require "rubygems"
load "ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte

compte = Compte.new(:pseudo => "toto")
compte.pseudo = "polo"
p compte
print compte, "\n"

compte.save

p compte
print compte.pseudo, "\n"