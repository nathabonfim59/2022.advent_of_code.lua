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

-- Find the top 3 elves with the most calories
print('-- Analysing data --')
local top_3_elves = {}
for elf_number, calories in pairs(elves) do
    print('Elf ' .. elf_number .. ' has ' .. calories .. ' calories')

    -- Verify if the elf is in the top 3
    for i = 1, 3 do
        if (not top_3_elves[i] or calories > top_3_elves[i].calories) then
            -- Insert the elf in the top 3
            table.insert(top_3_elves, i, {
                number = elf_number,
                calories = calories
            })

            -- Remove the last element
            if (#top_3_elves > 3) then
                table.remove(top_3_elves, #top_3_elves)
            end

            break
        end
    end
end

-- Print the top 3 elves
print('-- Top 3 elves --')

for i = 1, 3 do
    print('Elf ' .. top_3_elves[i].number .. ' with ' .. top_3_elves[i].calories .. ' calories')
end

-- Print the richest elf
local calories_sum = 0
for i = 1, #top_3_elves do
    calories_sum = calories_sum + top_3_elves[i].calories
end

print('-- Results --')
print('The sum of the top 3 elves is ' .. calories_sum .. ' calories')
