


require "active_record"

ActiveRecord::Base.establish_connection

	:adapter => "sqlite3",
	:database => "tp4l3.sqlite",
	:timeout => 5000

end

