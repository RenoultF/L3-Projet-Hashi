
##
# Auteur Brabant Mano
# Version 0.1 : Date : 07/02/2020

require "../Core/Sauvegarde.rb"
require "active_record"


#Cette classe représente les comptes utilisateurs
class Compte < ActiveRecord::Base


  COMPTE_DEFAULT = "_DEFAULT"

  has_many :sauvegardes

  validates :name, presence: true, uniqueness: true

  #@pseudo => Contient l'identifiant du compte
  attr_reader :pseudo

  private_class_method :new

  def Compte.razAllCompte()

    Compte.delete_all()

  end


  def Compte.maj()

    Sauvegarde.razAllSauvegarde()

    Compte.razAllCompte()

    default = new(COMPTE_DEFAULT)

    grilles = Grille.chargerGrilles("../NouvellesGrilles")

    Sauvegarde.creerAll(default, grilles)

  end

  #Cette méthode permet de créer un nouveau compte
  #
  #@param pseudo Le pseudo du compte
  def Compte.creer(pseudo)

    if(pseudo == COMPTE_DEFAULT)
      raise(pseudo + " : Ce nom n'est pas disponible")
    end
    puts "Création du compte #{pseudo}"
    new(pseudo)

  end

  #:nodoc:
  def initialize(pseudo)

    super(:name => pseudo)
    @pseudo = pseudo
    self.sauvegarder()
    if(pseudo != COMPTE_DEFAULT)
      self.initialiseSauvegarde()
    end

  end
  #:doc:

  ##
  #Cette méthode permet de récuperer toutes les grilles de base
  def initialiseSauvegarde()

    sauvegardes = Sauvegarde.listeCompte(Compte.recuperer(COMPTE_DEFAULT))

    sauvegardes.each do |s|

      Sauvegarde.creer(self, s.getGrille()).sauvegarder()

    end

  end

  #Cette méthode permet de récuperer un compte dans la base de données
  #
  #@param pseudo Le pseudo du compte
  #
  #@raiseException Si le compte n'existe pas
  def Compte.recuperer(pseudo)

    compte = Compte.find_by(name: pseudo);

    if(compte == nil)

      raise("Le compte " + pseudo + " n'existe pas")

    else

      return compte

    end

  end


  #Cette méthode permet de récuperer un compte dans la base de données
  #
  #@param pseudo Le pseudo du compte
  #
  #@raiseException Si le compte n'existe pas
  def Compte.recuperer_ou_creer(pseudo)

    compte = Compte.find_by(name: pseudo);

    if(compte == nil)

      Compte.creer(pseudo)

    else

      return compte

    end

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
