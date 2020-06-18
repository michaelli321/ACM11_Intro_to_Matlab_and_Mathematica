% This script allows a user to play the game of Blackjack

function BlackJack
    % ask user how many chips they want
    chips = input('How many chips would you like to start with?\n', 's');
    chips = str2double(chips);

    while ~validateNumericInput(chips) % ensure that they gave valid input
        chips = input('Please enter positive whole number only\n', 's');
        chips = str2double(chips);
    end
    
    % end the game when the user runs out of chips
    while chips > 0
        fprintf('\nYou have %i chips\n', chips);
        
        % ask the user how much they want to bet for the round
        bet = input('How many do you want to bet\n', 's');
        bet = str2double(bet);
        
        % validate the bet
        while ~validateNumericInput(bet) || bet > chips
            bet = input(['Please enter a valid bet that is less than '...
                'your chips\n'], 's');
            bet = str2double(bet);
        end
       
        % initialize player and dealerHands and draw two cards for each
        playerHand = [0 0 0 0 0];
        dealerHand = [0 0 0 0 0 0 0 0 0 0];
        playerHand([1 2]) = randi([1,13], 1, 2);
        dealerHand([1 2]) = randi([1,13], 1, 2);
        displayPlayerState(bet, playerHand, dealerHand);
        
        % keep track of where to draw next card in respective hands
        playerHandLen = 2;
        dealerHandLen = 2;
        
        % if the player hasn't busted or reached the 5 card limit
        while ScoreHand(playerHand) ~= -1 && playerHandLen ~= 5
            % allow them to make a move
            move = input('\nh for hit and s for stand\n', 's');
            while ~validateMove(move)
                move = input(['Please enter a valid move. h for hit '...
                    'or s for stand\n'], 's');
            end
            
            % if the player hits, draw a card and print game state
            if move == 'h'
                playerHand(playerHandLen+1) = randi([1,13], 1, 1);
                playerHandLen = playerHandLen + 1;
                displayPlayerState(bet, playerHand, dealerHand);
            else
                break
            end
        end
        
        % if the player busts, end the round
        if ScoreHand(playerHand) == -1
            fprintf('\nOh no, you busted\n');
            chips = chips - bet;
        else % otherwise let the dealer play
            displayDealerState(dealerHand);
            
            % dealer will keep hitting until 17 or busts
            while ScoreHand(dealerHand) < 17 && ScoreHand(dealerHand) ~= -1
                dealerHand(dealerHandLen+1) = randi([1,13], 1, 1);
                dealerHandLen = dealerHandLen + 1;
                displayDealerState(dealerHand);
            end
            
            % determine who won and distribute chips accordingly
            if ScoreHand(dealerHand) < ScoreHand(playerHand)
                disp('Congrats you won this hand!')
                chips = chips + bet;
            elseif ScoreHand(dealerHand) > ScoreHand(playerHand)
                disp('Oh no, the dealer won')
                chips = chips - bet;
            else
                disp('There was a tie')
            end
        end
        
    end
    
    disp('Oh no you ran out of money! Game Over');
end

function displayDealerState(dealerHand)
% prints the state of the game to the screen when dealer is going

    fprintf('---------------------------------------\n')
    fprintf("The Dealer Has:\n");
    displayHand(dealerHand);
    fprintf('The dealer total is %i\n\n', ScoreHand(dealerHand));
end

function displayPlayerState(bet, playerHand, dealerHand)
% prints the state of the game to the screen when player is going

    fprintf('---------------------------------------\n')
    fprintf('You are betting %i\n', bet);
    fprintf('The dealer is showing %s\n', Card2String(dealerHand(1)));
    disp('Your hand is:');
    displayHand(playerHand);
    fprintf('Your total is %i\n\n', ScoreHand(playerHand));
end

function bool = validateMove(move)
% returns whether or not the user gave a valid move

    if strcmp(move, 'h') || strcmp(move, 's')
        bool = true;
    else
        bool = false;
    end
end

function displayHand(hand)
% prints a given hand to the screen

    for i = 1:length(hand)
        fprintf('%s ', Card2String(hand(i)))
    end
    fprintf('\n')
end

function bool = validateNumericInput(num)
% returns whether or not numeric input is valid

    if ~isnan(num) && isreal(num)
        % is the number whole and greater than 0
        bool = mod(num, 1) == 0 & num > 0;
    else
        bool = false;
    end

end

function cardString = Card2String(card)
% returns the name of a given card as a string

    if card >= 2 && card <= 10
        cardString = num2str(card);
    elseif card == 1
        cardString = 'Ace';
    elseif card == 11
        cardString = 'Jack';
    elseif card == 12
        cardString = 'Queen';
    elseif card == 13
        cardString = 'King';
    else % 0 is not a card
        cardString = '';
    end
end

function score = ScoreHand(hand)
% returns the score of a given hand
    
    % sort the hand in descending order so we can score aces easier
    sortedHand = sort(hand, 'descend');
    score = 0;
    
    for card = sortedHand
        % 11, 12, 13 represent jack queen king which are worth 10
        if card > 10
            score = score + 10;
        elseif card == 1
            % if we have an ace decide what its worth should be
            if score + 11 > 21
                score = score + 1;
            else
                score = score + 11;
            end
        else
            score = score + card;
        end
        
        % determine if the player busted
        if score > 21
            score = -1;
            break
        end
    end
end