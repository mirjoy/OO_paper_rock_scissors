DECK = {'H2'=> 2, 'H3'=> 3, 'H4'=> 4, 'H5'=> 5, 'H6'=> 6, 'H7'=> 7, 'H8'=> 8, 'H9'=> 9, 'H10'=> 10, 'HJ'=> 10, 'HQ'=> 10, 'HK'=> 10, 'HA'=> 'Ace', 'D2'=> 2, 'D3'=> 3, 'D4'=> 4, 'D5'=> 5, 'D6'=> 6, 'D7'=> 7, 'D8'=> 8, 'D9'=> 9, 'D10'=> 10, 'DJ'=> 10, 'DQ'=> 10, 'DK'=> 10, 'DA'=> 'Ace', 'S2'=> 2, 'S3'=> 3, 'S4'=> 4, 'S5'=> 5, 'S6'=> 6, 'S7'=> 7, 'S8'=> 8, 'S9'=> 9, 'S10'=> 10, 'SJ'=> 10, 'SQ'=> 10, 'SK'=> 10, 'SA'=> 'Ace', 'C2'=> 2, 'C3'=> 3, 'C4'=> 4, 'C5'=> 5, 'C6'=> 6, 'C7'=> 7, 'C8'=> 8, 'C9'=> 9, 'C10'=> 10, 'CJ'=> 10, 'CQ'=> 10, 'CK'=> 10, 'CA'=> 'Ace'}

def shuffle_deck(cards)
	cards.keys.shuffle
end

def calculator_total(deck_hash, playercards)
	arr = deck_hash.values_at(*playercards)
	total = 0
	arr.each do|cardvalue|
		if cardvalue == 'Ace' && total > 10
		total+=1
		elsif cardvalue == 'Ace' && total <= 10
		total+=11
		else
		total+=cardvalue
		end
	end
	total
end

def hit(hand, cards)	
	deck_arr = shuffle_deck(cards)
	hand << deck_arr.pop
end

puts "Welcome to Blackjack"
	puts "What is your name? Type it below"
	username = gets.chomp

loop do
	
	player_hand = []
	dealer_hand = []
	
	hit(player_hand, DECK)
	hit(dealer_hand, DECK)
	hit(player_hand, DECK)
	hit(dealer_hand, DECK)
	
	player_total = calculator_total(DECK, player_hand)
	dealer_total = calculator_total(DECK, dealer_hand)

	hitorstay = ''

	while player_total < 21 && dealer_total < 21 do 
			puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. Would you like to hit or stay? To Hit, type 1, to Stay, type 2."
			hitorstay = gets.chomp
				if hitorstay == '1' && dealer_total < 17
					hit(player_hand, DECK)
					hit(dealer_hand, DECK)
				elsif hitorstay == '1' && dealer_total >= 17
						hit(player_hand, DECK)
				elsif hitorstay == '2' && dealer_total < 17
					puts "You chose to stay."
					hit(dealer_hand, DECK)
					player_total = calculator_total(DECK, player_hand)
					dealer_total = calculator_total(DECK, dealer_hand)
					break
				else hitorstay == '2' && dealer_total >= 17
					puts "You chose to stay."		
					player_total = calculator_total(DECK, player_hand)
					dealer_total = calculator_total(DECK, dealer_hand)
					break		
				end
		player_total = calculator_total(DECK, player_hand)
		dealer_total = calculator_total(DECK, dealer_hand)
		end

		if player_total < dealer_total
				puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. You win"	
		elsif player_total == 21
			puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. You win!"	
		elsif dealer_total == 21
			puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. The dealer wins!"			
		elsif player_total == dealer_total
			puts "It's a draw. You have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}"			
		elsif player_hand.include?("SJ")
			puts "#{username}, you have the Jack of Spades. You automatically win!"			
		elsif dealer_hand.include?("SJ")
			puts "The dealer has the Jack of Spades. The dealer automatically wins!"	
		elsif player_total > dealer_total 
			puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. Dealer wins. Game Over"			
		else dealer_total > player_total 
			puts "#{username}, you have #{player_hand} in your deck for a total of #{player_total}. The dealer has #{dealer_hand} for a total of #{dealer_total}. You win!"				
		end	

		puts "Would you like to play again? If yes, hit 1, otherwise, hit 2."
		playagain = gets.chomp
			until playagain == '1' || playagain == '2' do
			puts "That is not a valid selection. If you would like to play again hit 1, otherwise, hit 2."
			playagain = gets.chomp
			end
		if playagain == "1"
		puts "Great, let's play again"
		else
		puts "Bye! Thanks for playing!"
		break
	end
end
