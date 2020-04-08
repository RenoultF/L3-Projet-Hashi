

require 'gtk3'


class ChoixTailleUI < Gtk::Box

  attr_reader :menu

  def initialize(menu)

    super(:horizontal, 10)

    @menu = menu

    for i in [7, 10, 15]

      temp = Gtk::Button.new(:label => "#{i}*#{i}")
      temp.signal_connect "clicked" do
        @menu.taille=i
      end
      self.add(temp)

    end

  end

end
