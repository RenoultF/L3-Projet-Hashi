


require 'gtk3'


class ChoixNomUI < Gtk::Entry

  attr_reader :menu

  def initialize(menu)

    super()

    @menu = menu

  end

end
