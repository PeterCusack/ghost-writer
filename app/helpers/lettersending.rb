helpers do 
	def find_sender(current_letter_count)
		sender_letter = current_letter_count - 1 
		sender_letter = Letter.find(sender_letter)
		user_id = sender_letter.user_id
		send_user = User.find(user_id)
		# binding.pry
		send_data = {send_object: sender_letter.lob_object_id, from_address: send_user.addresss}
	end
end

