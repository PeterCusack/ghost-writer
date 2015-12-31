post '/users/letters/new' do
	# binding.pry
	# p params
	@lob = Lob.load(api_key: "test_cd149f37b86b109033dd4c639a99bc18584")
	letterHTML = params["fileHTML"]
	lob_object_response = @lob.objects.create(
	  name: "#{Letter.get_letter_count}",
	  file: letterHTML,
	  setting: "100",
	  template: "0"
	)

	object_id = lob_object_response["id"]
	current_user.letters.create(
		content: params["letterText"],
		letter_number: Letter.get_letter_count + 1,
		lob_object_id: object_id
	)

	# binding.pry
	# Should place this in a seperate worker
	send_user = find_sender(Letter.get_letter_count)
	# binding.pry
	@lob.jobs.create(
	  name: "Test",
	  from: send_user[:from_address],
	  to: current_user.addresss,
	  objects: send_user[:send_object],
	)
	Stripe.api_key = "sk_test_s8FghPjfshIHujtzhTZOjz8N"
	Stripe::Charge.create(
    	:amount   => 200,
    	:currency => "usd",
    	:customer => current_user.payment_id
  	)

end

post '/users/letters/template' do
	html = erb :letter_format, :layout => false
	content_type :json
	html.to_json
end