



require 'gtk3'


class ReglesUI < Gtk::Box


  def initialize()

    super(:vertical)

    temp = Gtk::Label.new("Le Hashiparmentier est un jeu de connection de ponts.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("Le Hashiparmentier est résolu en connectant des iles \navec des ponts, selon certaines règles.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("Chaque puzzle affiche dans une rectangle un ensemble \nd'iles dans lesquelles le nombre inscrit représente le\nnombre de ponts qui doivent y être connéctés.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("Le but est de connecter toutes les iles selon leurs \nnombre de pont.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("  - Il n'y a pas plus de deux ponts dans la même direction.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("  - Les ponts sont seulement verticaux ou horizontaux,\net ne doivent pas traverser des iles ou croiser des ponts.\n")
    temp.set_alignment(0, 0)
    add(temp)

    temp = Gtk::Label.new("  - Quand la grille est fini, toutes les iles sont \ninterconnectés à l'aide des ponts.\n")
    temp.set_alignment(0, 0)
    add(temp)

    show_all

  end

end
