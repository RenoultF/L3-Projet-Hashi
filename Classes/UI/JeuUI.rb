

require "../Core/DonnerTechnique.rb"
require "../Core/VerifierGrille.rb"
require "../Core/UndoRedo.rb"

require "../UI/GrilleJouableUI.rb"
require 'gtk3'

##
# Auteur:: Brabant Mano
# Version:: 0.1
# Date:: 09/04/2020
class JeuUI < Gtk::Box

  attr_reader :racine
  attr_reader :compte

  def initialize(racine)

    super(:vertical , 0)

    @racine = racine

  end

  ##
  #Cette méthode permet de charger la grille avec laquelle on va jouer
  #param::
  # * grille La grille avec laquelle on va jouer
  # * nomCompte Le nom du compte qui joue
  def chargerGrille(grille, nomCompte)

    each_all do |c|
      remove(c)
    end


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

    @redo = Gtk::Button.new(:label => "Redo")
    @redo.signal_connect "clicked" do
      @grille.grille.redo()
    end

    @hypotheseCreer = Gtk::Button.new(:label => "Creer hypothèse")
    @hypotheseCreer.signal_connect "clicked" do
      @grille.grille.creerHypothese()
    end

    @hypotheseValider = Gtk::Button.new(:label => "Valider hypothèse")
    @hypotheseValider.signal_connect "clicked" do
      @grille.grille.valideHypothese()
    end


    @hypotheseSupprimer = Gtk::Button.new(:label => "Supprimer hypothèse")
    @hypotheseSupprimer.signal_connect "clicked" do
      @grille.grille.supprimeHypothese(self)
    end

    @sauvegarder = Gtk::Button.new(:label => "Sauvegarder")
    @sauvegarder.signal_connect "clicked" do
      Sauvegarde.recuperer(@compte, @grille.grille).setGrille(@grille.grille).sauvegarder()
    end


    @aideValide = Gtk::Button.new(:label => "Verifier grille")
    @aideValide.signal_connect "clicked" do
      @verifGrille.aider()
    end

    @labelTechnique = Gtk::Label.new()

    @aideTechnique = Gtk::Button.new(:label => "Donner technique")
    @aideTechnique.signal_connect "clicked" do
      @labelTechnique.text = @donnerTech.aider()
    end

    @valider = Gtk::Button.new(:label => "Valider")
    @valider.signal_connect "clicked" do
      finir()
    end

    aides = Gtk::Box.new(:horizontal)
    aides.pack_start(@aideValide, :expand => true, :fill => true)
    aides.pack_start(@aideTechnique, :expand => true, :fill => true)

    labelTechnique = Gtk::Box.new(:vertical)
    labelTechnique.pack_start(@labelTechnique, :expand => true, :fill => true)
    labelTechnique.pack_start(aides, :expand => true, :fill => true)

    undoRedo = Gtk::Box.new(:horizontal)
    undoRedo.pack_start(@undo, :expand => true, :fill => true)
    undoRedo.pack_start(@redo, :expand => true, :fill => true)

    hypotheses = Gtk::Box.new(:vertical)
    hypotheses.pack_start(@hypotheseCreer, :expand => true, :fill => true)
    hypotheses.pack_start(@hypotheseValider, :expand => true, :fill => true)
    hypotheses.pack_start(@hypotheseSupprimer, :expand => true, :fill => true)

    controle = Gtk::Box.new(:vertical)
    controle.pack_start(hypotheses, :expand => true, :fill => true)
    controle.pack_start(undoRedo, :expand => true, :fill => true)
    controle.pack_start(labelTechnique, :expand => true, :fill => true)


    jeu = Gtk::Box.new(:horizontal)
    jeu.pack_start(@grille, :expand => true, :fill => true)
    jeu.pack_start(controle, :expand => true, :fill => true)

    pack_start(jeu, :expand => true, :fill => true)
    pack_start(@valider, :expand => true, :fill => true)

    show_all

  end

  def grille=(grille)
    @grille.grille=(grille)
  end


  def finir()

    if(@grille.grille.fini?())
      puts "Bravo vous avez gagné !!!"
      @grille.recommencer()
      @grille.sauvegarder(@compte)
      @racine.finirPartie(@grille.grille.tailleX, @grille.grille.difficulte)
    end

  end


  def sauvegardeGrille()

    if(!@grille.eql?(nil))

      @grille.sauvegarder(@compte)

    end

  end


end
