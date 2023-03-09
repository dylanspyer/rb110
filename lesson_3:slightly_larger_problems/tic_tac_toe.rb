WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

game_stats = {
  'player_score' => 0,
  'computer_score' => 0,
  'best_out_of' => 0,
  'who_chooses' => '',
  'current_player' => '',
  'game_winner' => ''
}

def prompt(msg)
  puts "=> #{msg}"
end

def display_who_chooses_who_goes_first
  prompt "Who chooses who goes first? Player or computer (p or c)"
end

def get_who_chooses_who_goes_first!(game_stats)
  loop do
    who_chooses = gets.chomp.downcase
    if who_chooses.start_with?('p')
      game_stats['who_chooses'] = 'Player'
      break
    elsif who_chooses.start_with?('c')
      game_stats['who_chooses'] = 'Computer'
      break
    else
      prompt "Invalid input. Please try again (p or c)."
    end
  end
end

def display_who_goes_first
  prompt "Who goes first? Player or computer? (p or c)"
end

def get_who_goes_first!(game_stats)
  loop do
    first = gets.chomp.downcase
    if first.start_with?('p')
      game_stats['current_player'] = 'Player'
      break
    elsif first.start_with?('c')
      game_stats['current_player'] = 'Computer'
      break
    else
      prompt "Invalid input. Please try again (p or c)."
    end
  end
end

def display_goodbye_message(game_winner, goodbye_smack_talk)
  prompt "#{game_winner} is the winner of the game!"
  if game_winner == 'Computer'
    prompt goodbye_smack_talk[:player].sample
  elsif game_winner == 'Player'
    prompt goodbye_smack_talk[:computer].sample
  else
    prompt goodbye_smack_talk[:tie].sample
  end
  prompt "Thanks for playing Tic Tac Toe. Goodbye!"
end

def get_best_out_of_x!(game_stats)
  loop do
    prompt "Best out of how many rounds? Choose an odd number!"
    game_stats['best_out_of'] = gets.chomp.to_i
    if game_stats['best_out_of'].odd?
      break
    else
      prompt "#{game_stats['best_out_of']} isn't odd...try again."
    end
  end
  prompt "Ok, we're playing #{game_stats['best_out_of']} times!"
end

def display_score(game_stats)
  computer_score = game_stats['computer_score']
  player_score = game_stats['player_score']
  if computer_score > player_score
    prompt "The score is computer: #{computer_score} to player: #{player_score}"
  else
    prompt "The score is player: #{player_score} to computer: #{computer_score}"
  end
end

game_smack_talk = {
  player: [
    "Not looking so hot there, player.",
    "Maybe I forgot to explain the rules? You need THREE IN A ROW!",
    "Do better, player."
  ],
  computer: [
    "Peak computing performance, ladies and gentlemen.",
    "Did you try asking your cousin, Chat GPT, how to play this game?",
    "Try harder. Oh wait, you can't. You're just a computer."
  ],
  tie: [
    "What a boring game. Can one of you win already?",
    "This would be a lot more fun if someone won. Just saying...",
    "Have either one of you considered winning? I know, a novel concept."
  ]
}

goodbye_smack_talk = {
  player: [
    "The guy who programmed me BARELY knows what
    he's doing and I still beat you? Ha!",
    "Ever see the movie iRobot.
    It's based on a true story, puny human.",
    "AI 43v3r."
  ],
  computer: [
    "That's a win for all of humankind",
    "You beat the computer. I mean, it'd be pretty hard not to.
    Good job, I guess.",
    "Go humans!"
  ],
  tie: [
    "zzZZZzzzzzzZZzz...what? what? Sorry. Fell asleep during that snooze fest",
    "It would be much better for ratings if someone actually won..."
  ]
}

def display_smack_talk(winner, smack_talk)
  if winner == "Computer"
    prompt smack_talk[:player].sample
  elsif winner == "Player"
    prompt smack_talk[:computer].sample
  else
    prompt smack_talk[:tie].sample
  end
end

def display_scoreboard(game_stats)
  if game_stats['computer_score'] > game_stats['player_score']
    prompt "Computer: #{game_stats['computer_score']}
    ; Player: #{game_stats['player_score']}"
  else
    prompt "Player: #{game_stats['player_score']}
    ; Computer: #{game_stats['computer_score']}"
  end
end

def update_score!(game_stats, winner)
  if winner == 'Player'
    game_stats['player_score'] += 1
  elsif winner == 'Computer'
    game_stats['computer_score'] += 1
  end
end

def display_winner(winner)
  prompt "#{winner} won the round!"
end

# rubocop: disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_square(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def display_choices(brd, join_word = 'or')
  remaining_choices = empty_square(brd)
  if remaining_choices.count >= 2
    prompt "#{remaining_choices[0..-2].join(', ')},
    #{join_word} #{remaining_choices[-1]}"
  else
    prompt remaining_choices[0].to_s
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square:"
    display_choices(brd)
    square = gets.chomp.to_i
    break if empty_square(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |_|
    square = find_at_risk_squares(brd)
    break if square
  end
  if !square && empty_square(brd).include?(5)
    square = 5
  elsif !square
    square = empty_square(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, game_stats)
  if game_stats['current_player'] == 'Player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player!(game_stats)
  game_stats['current_player'] = if game_stats['current_player'] == 'Player'
                                   'Computer'
                                 else
                                   'Player'
                                 end
end

def board_full?(brd)
  empty_square(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def computer_offense(brd)
  at_risk = 0
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2
      brd.values_at(*line).zip(line).each do |sub_arr|
        if sub_arr[0] == INITIAL_MARKER
          at_risk = sub_arr[1]
        end
      end
    end
  end
  at_risk
end

def computer_defense(brd)
  at_risk = 0
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2
      brd.values_at(*line).zip(line).each do |sub_arr|
        if sub_arr[0] == INITIAL_MARKER
          at_risk = sub_arr[1]
        end
      end
    end
  end
  at_risk
end

def find_at_risk_squares(brd)
  at_risk = 0
  at_risk = computer_offense(brd) if computer_offense(brd) > 0
  at_risk = computer_defense(brd) if at_risk == 0 && computer_defense(brd) > 0
  at_risk > 0 ? at_risk : nil
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def game_winner(game_stats)
  if game_stats['player_score'] > game_stats['computer_score']
    game_stats['game_winner'] = 'Player'
  elsif game_stats['computer_score'] > game_stats['player_score']
    game_stats['game_winner'] = 'Computer'
  else
    game_stats['game_winner'] = "NO ONE"
  end
end

get_best_out_of_x!(game_stats)

display_who_chooses_who_goes_first
get_who_chooses_who_goes_first!(game_stats)

if game_stats['who_chooses'] == 'Computer'
  game_stats['current_player'] = ['Player', 'Computer'].sample
else
  display_who_goes_first
  get_who_goes_first!(game_stats)
end

loop do
  board = initialize_board
  loop do
    display_board(board)
    display_scoreboard(game_stats)
    place_piece!(board, game_stats)
    alternate_player!(game_stats)
    break if someone_won?(board) || board_full?(board)
  end
  display_board(board)
  if someone_won?(board)
    winner = detect_winner(board)
    prompt "#{winner} won the round!"
    update_score!(game_stats, winner)
    display_score(game_stats)
  else
    prompt "It's a tie!"
  end
  if game_stats['best_out_of'] > 1
    display_smack_talk(winner, game_smack_talk)
    prompt "Press enter to play the next round"
    _ = gets.chomp
  end

  game_stats['best_out_of'] -= 1
  break if game_stats['best_out_of'] == 0
end

game_winner(game_stats)

display_goodbye_message(game_stats['game_winner'], goodbye_smack_talk)
