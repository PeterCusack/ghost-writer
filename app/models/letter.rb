class Letter < ActiveRecord::Base

def self.get_letter_count
	if Letter.all.last
		current_letter_count = Letter.all.last.letter_number
	else 
		current_letter_count = 0
	end
end

end
