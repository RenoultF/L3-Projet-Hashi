


require 'gtk3'




class FinUI < Gtk::Box

  def initialize(racine)

    super(:vertical, 10)

    @racine = racine

    add(Gtk::Label.new("Bravo vous avez gagné !!!"))

  end

end
