##
# Auteur JOLLIET Corentin
# Version 0.1 : Date : Fri Mar 06 09:24:44 CET 2020
#
require 'gtk3'


class Chrono

	@minutes
	@secondes
	@active
	@jeuCourant

	def initialize(jeuUI, labelChrono)
		@minutes = 0
		@secondes = 0
		@jeuCourant = jeuUI
		@labelChrono = labelChrono
	end

	def afficherTps()
		if(@minutes < 10)
			if(@secondes < 10)
				@labelChrono.set_label(" 0#{@minutes}:0#{@secondes}")
				#return ("0#{@minutes}:0#{@secondes}")
			else
				@labelChrono.set_label(" 0#{@minutes}:#{@secondes}")
				#return("0#{@minutes}:#{@secondes}")
			end
		else if(@secondes < 10)
				@labelChrono.set_label("#{@minutes}:0#{@secondes}")
				#return("#{@minutes}:0#{@secondes}")
			else
				@labelChrono.set_label("#{@minutes}:#{@secondes}")
				#return(#{@minutes}:#{@secondes}"
			end
		end
	end

	def activeChrono()
		if (@active)
			@active = false
		else
			@active = true
		end
	end

	def razChrono()
		@minutes = 0;
		@secondes = 0;
	end

	def razChrLbl(chr)
		self.razChrono();
		chr.set_label("00:00")
	end

	def lancerChrono()
	#Chrono sans arguments
		activeChrono()
		while( (@minutes < 59) && @active )
			afficherTps()
			sleep(1)
			@secondes += 1
			if(@secondes%10 == 0)
				@jeuCourant.modifScore(-50)
			end
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
		end
		#@jeuCourant.setTempsFin(@minutes, @secondes)
	end

	def lancerChrono2(tps, chrono)
	#Chrono avec arguments : Durée du Chrono, Label du Chrono
		self.activeChrono()
		while( (@minutes < tps) & @active )
			chrono.set_label(self.afficherTps())
			sleep(1)
			@secondes += 1
			if(@secondes >= 60)
				@minutes += 1
				@secondes = 0
			end
		end
	end

end	# Marqueur de fin de classe

# Test Chrono
# c = Chrono.new()
# c.lancerChrono()
