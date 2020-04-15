
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require_relative "../Core/Compte.rb"
require_relative "../Core/Grille.rb"
require_relative "../Core/Sauvegarde.rb"
require "active_record"
require "rubygems"
require_relative "../Core/ConnectSqlite3.rb"

Compte.has_many :sauvegardes
Sauvegarde.belongs_to :compte


res = ""

res += "4=5---2"
res += "\"2\"1-2|"
res += "\"\"\"  |1"
res += "\"\"6==5 "
res += "2\"\"  \" "
res += " \"4=2\" "
res += " 4===4 "


#Commande pour créer une nouvelle sauvegarde
print "Donnez le nom de compte à récuperer : "
compte = Compte.recuperer(gets.chomp)
sauvegarde = Sauvegarde.creer(compte, Grille.creer(res, 7, 7, 0))
p sauvegarde
print sauvegarde, "\n"

if(!sauvegarde.sauvegarder())

  print sauvegarde.errors.messages, "\n"

end

p sauvegarde
print sauvegarde, "\n"


recupSauvegarde = Sauvegarde.liste(Compte.recuperer(gets.chomp), 7, 0)

recupSauvegarde.each do |s|

  s.getGrille().afficheToi()
  puts "\n"

end
