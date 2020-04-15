

##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require_relative "../Core/Grille.rb"

res = ""

res += "4=5---2"
res += "\"2\"1-2|"
res += "\"\"\"  |1"
res += "\"\"6==5 "
res += "2\"\"  \" "
res += " \"4=2\" "
res += " 4===4 "



grille = Grille.creer(res, 7, 7, 0)

grille.afficheToi()

grille.setDernierIle(grille.getCase(0, 0))

grille.afficheToi()
