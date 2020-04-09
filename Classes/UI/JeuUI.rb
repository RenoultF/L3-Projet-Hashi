
##
# Auteur Brabant Mano
# Version 0.1 : Date : 09/04/2020

require "../Core/DonnerTechnique.rb"
require "../Core/VerifierGrille.rb"

require "../UI/GrilleJouableUI.rb"
require 'gtk3'


class JeuUI < Gtk::Box

  attr_reader :window
  attr_reader :racine
  attr_reader :compte

  def initialize(racine)

    super(:horizontal , 0)

    @racine = racine

  end

  def chargerGrille(grille, nomCompte)

    @compte = Compte.recuperer(nomCompte)


    @verifGrille = VerifierGrille.creer(grille)
    @donnerTech = DonnerTechnique.creer(grille)
#    @chronoGrille = Chrono.new(@grille)
#    @threadChrono = Thread.new{@chronoGrille.lancerChrono()}

    @grille = GrilleJouableUI.new(grille)

    @undo = Gtk::Button.new(:label => "Undo")
    @undo.signal_connect "clicked" do
      @grille.grille.undo()
    end
    self.add(@undo)

    @redo = Gtk::Button.new(:label => "Redo")
    @redo.signal_connect "clicked" do
      @grille.grille.redo()
    end
    self.add(@redo)

    @hypotheseCreer = Gtk::Button.new(:label => "Creer")
    @hypotheseCreer.signal_connect "clicked" do
      @grille.grille.creerHypothese()
    end
    self.add(@hypotheseCreer)

    @hypotheseValider = Gtk::Button.new(:label => "Valider")
    @hypotheseValider.signal_connect "clicked" do
      @grille.grille.valideHypothese()
    end
    self.add(@hypotheseValider)


    @hypotheseSupprimer = Gtk::Button.new(:label => "Supprimer")
    @hypotheseSupprimer.signal_connect "clicked" do
      @grille.grille.supprimeHypothese(self)
    end
    self.add(@hypotheseSupprimer)

    @sauvegarder = Gtk::Button.new(:label => "Sauvegarder")
    @sauvegarder.signal_connect "clicked" do
      puts "Classe : " + @grille.to_s()
      puts "Classe : " + @grille.grille.to_s()
      Sauvegarde.recuperer(@compte, @grille.grille).setGrille(@grille.grille).sauvegarder()
    end
    self.add(@sauvegarder)


    @aideValide = Gtk::Button.new(:label => "Verifier grille")
    @aideValide.signal_connect "clicked" do
      @verifGrille.aider()
    end
    self.add(@aideValide)

    @labelTechnique = Gtk::Label.new()
    self.add(@labelTechnique)

    @aideTechnique = Gtk::Button.new(:label => "Donner technique")
    @aideTechnique.signal_connect "clicked" do
      @labelTechnique.text = @donnerTech.aider()
    end
    self.add(@aideTechnique)



    self.add(@grille)

    show_all

  end

  def grille=(grille)
    @grille.grille=(grille)
  end


  def grilleChoisi(grille)

    @racine.commancerPartie(grille)

  end


end
