system "clear"
puts "Welcome to Blackjack!"

def total_value(cards)
  #[['J', '3'], ['A', '2'], ...]
  arr = cards.map{ |e| e[1] }
  
  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 #'J', 'Q', 'K'
      total += 10
    else 
      total += value.to_i
    end    
  end
  
  # Ace value adjustment
  arr.select {|e| e == 'A'}.count.times do
    total -= 10 if total > 21
  end
  
  total
end

# save user's name
puts "What's your name?"
name = gets.chomp

# blackjack setup
suits = ["H", "D", "C", "S"]
cards = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

begin
  deck = suits.product(cards)
  deck.shuffle!
  puts ".........."
  
  # Deal cards
  mycards = []
  dealercards =[]
  
  mycards << deck.pop
  dealercards << deck.pop
  mycards << deck.pop
  dealercards << deck.pop
  
  mytotal = total_value(mycards)
  dealertotal = total_value(dealercards)
  
  #Show cards
  
  puts "Dealer has: #{dealercards[1]} as face card"
  puts "You have: #{mycards[0]} and #{mycards[1]}, total value is: #{mytotal}"
  puts ""
  sleep 1
  
  # Player turn
  if mytotal == 21 && dealertotal != 21
    puts "Wow, you hit blackjack in the first round! Congratulations, #{name}, you win!"
  end
  
  while mytotal < 21
    puts "#{name}, would you like to hit or stay? 1) hit 2) stay"
    hit_or_stay = gets.chomp
    
    if !["1", "2"].include?(hit_or_stay)
      puts "Error, you must enter 1 or 2"
      next
    end
    
    if hit_or_stay == "2"
      puts "#{name}, you choose to stay."
      break
    end
    
    #hit
    new_card = deck.pop
    puts "Dealing card to player #{name}: #{new_card}"
    mycards << new_card
    mytotal = total_value(mycards)
    sleep 0.5
    puts "Your total value now is #{mytotal}"
    
    if mytotal == 21
      puts "Congratulations! You hit blackjack, #{player_name} win!"
    elsif mytotal > 21
      puts "Opps, you busted! You lose!"
    end
  end
  
  # Dealer turn
  if dealertotal == 21 && mytotal != 21
    puts "Sorry, dealer hits blackjack, you lose."
    puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, total value is: #{dealertotal}"
  end
  
  while dealertotal < 17
    #hit
    new_card = deck.pop
    puts "Dealing card for dealer: #{new_card}"
    dealercards << new_card
    dealertotal = total_value(dealercards)
    sleep 0.5
    
    if dealertotal == 21
      puts "Dealer total value now is #{dealertotal}."
      puts "Sorry, dealer hit blackjack, #{player_name} lost!"
    elsif dealertotal > 21
      puts "Dealer total value now is #{dealertotal}"
      puts "Dealer busted! You win!"
    end
  end
  
  # Compare dealer and player cards
  
  puts "Dealer's cards:"
  dealercards.each do |card|
    puts "=> #{card}"
  end
  puts ""
    
  puts "#{name}'s cards:"
  mycards.each do |card|
    puts "=> #{card}"
  end
  puts ""
  
  if dealertotal > mytotal
    puts "Dealer has more points, dealer wins!"
  elsif dealertotal < mytotal
    puts "You have more points, #{name} is the winner!"
  else
    puts "You and dealer have the same points, it's a tie round."
  end
  
  print "Want to try again? (y/n)"
  play_again = gets.chomp.downcase
end until play_again == "n"

puts "Thanks for playing!"

exit