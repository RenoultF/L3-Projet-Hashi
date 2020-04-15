require 'gtk3'


#
# CSS MENU
#
@@CSS_BG_MENU ||= Gtk::CssProvider.new
@@CSS_BG_MENU.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/bg.jpg");
    }
    CSS

@@CSS_BG_JEU ||= Gtk::CssProvider.new
@@CSS_BG_JEU.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/wJapStylePlusNet.jpg");
    }
    CSS

@@CSS_BG_JEU15 ||= Gtk::CssProvider.new
@@CSS_BG_JEU15.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/wJapStylePlusNet15.jpg");
    }
    CSS



@@CSS_BUTTON_ACTIVE ||= Gtk::CssProvider.new
@@CSS_BUTTON_ACTIVE.load(data: <<-CSS)

    CSS

@@CSS_LABEL_MENU ||= Gtk::CssProvider.new
@@CSS_LABEL_MENU.load(data: <<-CSS)
    label {
       margin-top: 30px;
       margin-bottom: 5px;
       font-weight: bold;
    }
    CSS


@@CSS_BTN_BOTMENU ||= Gtk::CssProvider.new
@@CSS_BTN_BOTMENU.load(data: <<-CSS)


    CSS

@@CSS_BTN_TOPMENU ||= Gtk::CssProvider.new
@@CSS_BTN_TOPMENU.load(data: <<-CSS)


    CSS

@@CSS_BTN_JEU ||= Gtk::CssProvider.new
@@CSS_BTN_JEU.load(data: <<-CSS)


    CSS

@@CSS_ENTRY_MENU ||= Gtk::CssProvider.new
@@CSS_ENTRY_MENU.load(data: <<-CSS)
    #entryPseudo {
        border-width: 2px;
        border-color: red;
    }
    CSS


#
# CSS AIDE
#
@@CSS_AIDE ||= Gtk::CssProvider.new
@@CSS_AIDE.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#e7b7b0, white);
    }
    CSS

@@CSS_BUTTON_ROSE ||= Gtk::CssProvider.new
@@CSS_BUTTON_ROSE.load(data: <<-CSS)

    CSS

@@CSS_ASTUCES ||= Gtk::CssProvider.new
@@CSS_ASTUCES.load(data: <<-CSS)
    * {
        background-image: linear-gradient(#e7b7b0, white);
    }
    CSS

@@CSS_BOX_STAT ||= Gtk::CssProvider.new
@@CSS_BOX_STAT.load(data: <<-CSS)
    * {
        border-radius: 15px;
        border: 2px solid #a40d0f;
        font-weight: bold;
        padding: 5px;
        font-size:12px;
    }
    CSS

@@CSS_BG_SCORE1 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE1.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/1stars.png");
    }
    CSS

@@CSS_BG_SCORE2 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE2.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/2stars.png");
    }
    CSS

@@CSS_BG_SCORE3 ||= Gtk::CssProvider.new
@@CSS_BG_SCORE3.load(data: <<-CSS)
    * {
        background-image: url("lib/Hashiparmentier/glade/images/3stars.png");
    }
    CSS
