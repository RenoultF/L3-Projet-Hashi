

require "./Grille2Essai.rb"

res = ""

res += "4=5---2"
res += "\"2\"1-2|"
res += "\"\"\"  |1"
res += "\"\"6==5 "
res += "2\"\"  \" "
res += " \"4=2\" "
res += " 4===4 "



grille = Grille2Essai.creer(res, 7, 7, 0)

grille.afficheToi()
