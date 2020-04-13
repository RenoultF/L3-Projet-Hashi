require 'gtk3'


#
# CSS MENU
#
@@CSS_BG_MENU ||= Gtk::CssProvider.new
@@CSS_BG_MENU.load(data: <<-CSS)
    * {
        background-image: url("../glade/bg.jpg");
    }
    CSS

@@CSS_BG_JEU ||= Gtk::CssProvider.new
@@CSS_BG_JEU.load(data: <<-CSS)
    * {
        background-image: url("../glade/wJapStylePlusNet.jpg");
    }
    CSS

    

@@CSS_BUTTON_ACTIVE ||= Gtk::CssProvider.new
@@CSS_BUTTON_ACTIVE.load(data: <<-CSS)
    button{
        background-image: image(#F9CEC7);
        border: 2px solid #e29085;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
    }
    button:checked {
        background-image: image(#e7b7b0);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
        font-weight: bold;
    }
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
    button{
        background-image: image(#ae9bf4);
        border: 2px solid #6e4af2;
        box-shadow: 3px 3px 2px #656565;
    }
    button:active {
        background-image: image(#FAECBA);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
    }
    CSS

@@CSS_BTN_TOPMENU ||= Gtk::CssProvider.new
@@CSS_BTN_TOPMENU.load(data: <<-CSS)
    button{
        background-image: image(#ae9bf4);
        border: 2px solid #6e4af2;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
        
    }
    button:active {
        background-image: image(#FAECBA);
        border-style: solid;
        border-width: 2px;
        border-color: #c47d73;
        font-weight: bold;
    }
    button:hover{
        text-decoration: none;
    }
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
    button{
        background-image: image(#F9CEC7);
        border: 2px solid #e29085;
        box-shadow: 3px 3px 2px #656565;
        font-weight: bold;
    }
    CSS