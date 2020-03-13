
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020


require "./Compte.rb"
require "./Grille2Essai.rb"
require "./Sauvegarde.rb"
require "active_record"
require "rubygems"
require "./ConnectSqlite3.rb"

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
sauvegarde = Sauvegarde.creer(compte, Grille2Essai.creer(res, 7, 7, 0))
p sauvegarde
print sauvegarde, "\n"

if(!sauvegarde.save)

  print sauvegarde.errors.messages, "\n"

end

p sauvegarde
print sauvegarde, "\n"


recupSauvegarde = Sauvegarde.liste(Compte.recuperer(gets.chomp), 7, 0)

recupSauvegarde.each do |s|

  s.getGrille().afficheToi()
  puts "\n"

end
