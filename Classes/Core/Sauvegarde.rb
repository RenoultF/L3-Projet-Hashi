

require "../Core/Compte.rb"
require "../Core/Grille.rb"
require "active_record"

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
#
#Cette classe permet de sauvegarder dans une base de données la progression d'un joueur sur une grille et de faire des recherches sur les sauvegardes
class Sauvegarde < ActiveRecord::Base


  #@grille => Contient la grille que l'utilisateur a commencé à remplir

  validates :grille, presence: true



  #@compte => Contient le compte auquel appartient la sauvegarde
  belongs_to :compte

  validates :compte, presence: true


  ##
  #Cette méthode permet de supprimer toutes les sauvegardes dans la base de donnée
  def Sauvegarde.razAllSauvegarde()
    Sauvegarde.delete_all()
  end

  ##
  #Cette méthode permet de créer un sauvegarde pour un ensemble de grille
  #param::
  # * compte Le compte pour lequel on va créer les sauvegardes
  # * grilles Un tableau qui contient les grilles à sauvegarder
  def Sauvegarde.creerAll(compte, grilles)

    grilles.each do |g|
      Sauvegarde.creer(compte, g).sauvegarder()
    end

  end


  private_class_method :new

  ##
  #Cette méthode permet de creer une grille pour un compte
  #param::
  # * compte Le compte auquel la sauvegarde est lié
  # * grille La grille auquel la sauvegarde est lié
  #return::
  # * raiseException Si le compte possède déjà une sauvegarde de cette grille
  def Sauvegarde.creer(compte, grille)

    begin
      temp = Marshal.dump(grille).force_encoding("ISO-8859-1").encode("UTF-8")
      Marshal.load(temp)
    rescue
      temp = YAML.dump(grille)
    end
    new(:compte => compte, :grille => temp, :taille => grille.tailleX(), :difficulte => grille.difficulte(), :meilleurScore => 0)

  end

  ##
  #Cette méthode permet de recupérer la sauvegarde d'un compte pour une grille
  #param::
  # * compte Le compte auquel la sauvegarde est lié
  # * grille La grille auquel la sauvegarde est lié
  #return::
  # * La sauvegarde si elle existe
  # * nil Sinon
  def Sauvegarde.recuperer(compte, grille)

    liste = Sauvegarde.listeCompte(compte)
    liste.each do |s|
      if(s.getGrille().memeSolution(grille))
        return s
      end
    end
    return nil

  end

  ##
  #Cette méthode permet de connaitre les sauvegardes d'un joueur
  #param::
  # * compte Le compte du joueur
  #return::
  # * Le tableau des sauvegardes du compte
  def Sauvegarde.listeCompte(compte)
    return Sauvegarde.where(compte: compte).to_a()
  end

  ##
  #Cette méthode permet de connaitre les sauvegardes d'un joueur pour les grilles d'une certaine taille et d'une certaine difficulté
  #param::
  # * compte Le compte du joueur
  # * taille La taille de la grille
  # * difficulte La difficulte de la grille
  #return::
  # * Le tableau des sauvegardes du compte de taille et difficulté données
  def Sauvegarde.liste(compte, taille, difficulte)
    return Sauvegarde.where(compte: compte, taille: taille, difficulte: difficulte).to_a()
  end

  ##
  #Cette méthode permet d'enregistrer la sauvegarde
  #return::
  # * true Si la sauvegarde est efféctué
  # * false Sinon
  def sauvegarder()
    return self.save()
  end

  ##
  #Cette méthode permet de recupérer la grille de la sauvegarde
  #return::
  # * La grille sauvegardé
  def getGrille()

    begin
      return Marshal.load(self.grille)
    rescue
      return YAML.load(self.grille)
    end

  end

  ##
  #Cette méthode permet de modifier la grille enregistrée
  #param::
  # * grille La nouvelle grille
  def setGrille(grille)

    begin #Active record peut enregistrer du TEXT avec UTF-8 uniquement
      temp = Marshal.dump(grille).force_encoding("ISO-8859-1").encode("UTF-8") #on force donc la chaine en UTF-8
      Marshal.load(temp) #à condition que l'on puisse la recharger sans exception
    rescue
      temp = YAML.dump(grille) #Sinon on enregistre avec YAML qui est plus lent
    end
    self.grille = temp
    return self

  end

  ##
  #Cette méthode permet de recupérer le meilleur score associé à la grille enregistré
  #return::
  # * Le score de la sauvegarde
  def getScore()
    return self.meilleurScore
  end

  ##
  #Cette méthode permet de modifier le meilleur score associé à la grille enregistré
  #param::
  # * score Le nouveau score
  def setScore(score)

    self.meilleurScore = score
    return self

  end

  ##
  #Cette méthode permet d'afficher une sauvegarde
  def to_s()
      return "#{self.compte} : #{self.getGrille()}"
  end

end
