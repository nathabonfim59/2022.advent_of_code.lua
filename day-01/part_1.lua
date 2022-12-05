--- Read the input file
local input_file = 'data/input.txt'
local file = io.open(input_file, "r")

-- Store each elf's calories in an table
local elves = {}
local elf_number = 0

-- Read through the file line by line and store
-- each elf total calories in an table
print('Reading input file...')
for calories in file:lines() do
    local new_elf = calories == ''

    if (not new_elf) then
        -- Default value for the elf's calories
        elves[elf_number] = (elves[elf_number] or 0) + tonumber(calories)
    else
        elf_number = elf_number + 1
    end
end

-- Find the elf with the most calories
print('-- Analysing data --')
local richest_elf = {}
for elf_number, calories in pairs(elves) do
    print('Elf ' .. elf_number .. ' has ' .. calories .. ' calories')

    if (not richest_elf.calories or calories > richest_elf.calories) then
        richest_elf = {
            number = elf_number,
            calories = calories
        }
    end
end

-- Print the richest elf
print('-- Results --')
print('Richest elf is ' .. richest_elf.number .. ' with ' .. richest_elf.calories .. ' calories')

