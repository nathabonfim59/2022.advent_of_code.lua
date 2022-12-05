-- Read the input file
local input_file = 'data/input.txt'
local file = io.open(input_file, "r")

-- Lookup table with the strategy symbols
local lookup_table = {
    rock = {
        name = 'Rock',
        beats = 'scissor',
        loses = 'paper',
        points = 1,
        emoji = '👊',
        symbols = {
            'A',
        },
    },
    paper = {
        name = 'Paper',
        beats = 'rock',
        loses = 'scissor',
        points = 2,
        emoji = '📄',
        symbols = {
            'B',
        },
    },
    scissor = {
        name = 'Scissor',
        beats = 'paper',
        loses = 'rock',
        points = 3,
        emoji = '✂️',
        symbols = {
            'C',
        },
    }
}

local expected_results = {
    X = 'lose',
    Y = 'draw',
    Z = 'win',
}

function symbol_to_emoji(symbol)
    for _, strategy in pairs(lookup_table) do
        for _, strategy_symbol in pairs(strategy.symbols) do
            if (strategy_symbol == symbol) then
                return strategy.emoji
            end
        end
    end
end

function symbol_to_points(symbol)
    for _, strategy in pairs(lookup_table) do
        for _, strategy_symbol in pairs(strategy.symbols) do
            if (strategy_symbol == symbol) then
                return strategy.points
            end
        end
    end
end

function symbol_to_name(symbol)
    for _, strategy in pairs(lookup_table) do
        for _, strategy_symbol in pairs(strategy.symbols) do
            if (strategy_symbol == symbol) then
                return string.lower(strategy.name)
            end
        end
    end
end

local match_points = {
    lost = 0,
    draw = 3,
    won = 6,
}

function expected_to_choice(opponent_choice, expected_result)
    expected_result = string.lower(expected_results[expected_result])
    opponent_choice_name = string.lower(symbol_to_name(opponent_choice))

    local choice = nil

    for _, strategy in pairs(lookup_table) do
        if (expected_result == 'draw') then
            choice = opponent_choice
        end
        if (strategy.beats == opponent_choice_name and expected_result == 'win') then
            choice = strategy.symbols[1]
        end
        if (strategy.loses == opponent_choice_name and expected_result == 'lose') then
            choice = strategy.symbols[1]
        end
    end

    print('-------------------------------------------------------------------------')
    print(string.format('--->> Expected %s against %s, so I choose %s', expected_result, opponent_choice_name, symbol_to_name(choice)))
    print('-------------------------------------------------------------------------')

    return choice
end

index = 0
match_results = {}

-- Read the file line by line
for match in file:lines() do
    index = index + 1

    opponent_choice = match:sub(1, 1)
    expected_result = match:sub(3, 3)

    player_choice = expected_to_choice(opponent_choice, expected_result)

    print('----- Match ' .. index .. ' -----')
    print('Player choice: ' .. symbol_to_emoji(player_choice))
    print('Opponent choice: ' .. symbol_to_emoji(opponent_choice))

    match_results[index] = 0

    -- Verify the match result
    if (symbol_to_name(player_choice) == symbol_to_name(opponent_choice)) then
        print('Result: Draw')
        match_results[index] = match_points.draw
    else
        for _, strategy in pairs(lookup_table) do
            if (player_choice == strategy.symbols[1]) then
                if (symbol_to_name(opponent_choice) == strategy.beats) then
                    print('Result: Won')
                    match_results[index] = match_points.won
                else
                    print('Result: Lost')
                    match_results[index] = match_points.lost
                end
            end
        end
    end

    print('-> Choice points: ' .. symbol_to_points(player_choice))
    print('-> Winning: ' .. match_results[index])

    match_results[index] = match_results[index] + symbol_to_points(player_choice)
    print('Points: ' .. match_results[index])
end

-- Calculate the total points
total_points = 0
for _, points in pairs(match_results) do
    total_points = total_points + points
end



-- Print the results
print('--- Results ---')
print('Total matches: ' .. index)
print('Total points: ' .. total_points)
