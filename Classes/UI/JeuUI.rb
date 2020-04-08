

require 'gtk3'


class JeuUI < Gtk::Box



  def initialize()

    super()

  end

  def chargerGrille(nomCompte, taille, difficulte)

    puts nomCompte, taille, difficulte


    liste = Sauvegarde.liste(Compte.recuperer(nomCompte), taille, difficulte)

    @draw = GrilleUI.new(liste[0].getGrille(), 20)

    @draw.signal_connect "draw" do
      @draw.on_draw()
    end

    @draw.signal_connect "button-press-event" do |widget, event|
      @draw.clickOn(widget, event)
    end

    @draw.add_events([:button_press_mask])

    show_all


  end


  def on_draw(window)

    if(@draw != nil)
      @draw.on_draw(window)
    end

  end

end
