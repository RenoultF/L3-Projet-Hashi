


require 'gtk3'




class FinUI < Gtk::Box

  def initialize(racine)

    super(:vertical, 10)

    @racine = racine

  end

  def reussi(taille, difficulte)

    each_all do |c|
      remove(c)
    end

    add(Gtk::Label.new("Bravo vous avez gagné !!!"))

    puts "OSCOUR !!! : " , taille.inspect, difficulte.inspect

    if(difficulte == 0)

      if(taille == 7)

        puts "JEANNE !!!!!!"

        add(Gtk::Image.new(:file => "../Data/Pont Gaulois.jpg"))

      elsif(taille == 10)

        add(Gtk::Image.new(:file => "../Data/Pont Gaulois.jpg"))

      elsif(taille == 15)

        add(Gtk::Image.new(:file => "../Data/Pont Gaulois.jpg"))

      end

    elsif(difficulte == 1)

      if(taille == 7)

        add(Gtk::Image.new(:file => "../Data/Zubi Zuri.jpg"))

      elsif(taille == 10)

        add(Gtk::Image.new(:file => "../Data/Zubi Zuri.jpg"))

      elsif(taille == 15)

        add(Gtk::Image.new(:file => "../Data/Zubi Zuri.jpg"))

      end

    elsif(difficulte == 2)

      if(taille == 7)

        add(Gtk::Image.new(:file => "../Data/Golden Bridge.jpg"))

      elsif(taille == 10)

        add(Gtk::Image.new(:file => "../Data/Golden Bridge.jpg"))

      elsif(taille == 15)

        add(Gtk::Image.new(:file => "../Data/Golden Bridge.jpg"))

      end

    end

    show_all

  end

end
