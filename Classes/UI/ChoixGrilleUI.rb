

require 'gtk3'


class ChoixGrilleUI < Gtk::Box

  attr_reader :grilles
  attr_reader :window
  def initialize()

    super(:vertical , 20)

  end

  def chargerGrille(nomCompte, taille, difficulte)

    @grilles = Gtk::Scrollbar.new(:vertical)

    liste = Sauvegarde.liste(Compte.recuperer(nomCompte), taille, difficulte)

    liste.each_with_index do |s, i|

      puts "TEST : #{@window}"

      temp = GrilleUI.new(s.getGrille(), 40)

      temp.signal_connect "button-press-event" do |widget, event|
        puts "Jeanne oscour : " + event.to_s()
      end

      temp.add_events([:button_press_mask])

      self.add(temp)


    end

    self.add(@grilles)

    show_all

  end


end
