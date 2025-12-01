position = 50
password = 0

file = File.open('day1_1_input.txt', 'r')

file.each_line do |line|                            # Loop through the lines of the file
    direction = line[0]                             # Get the turn direction
    amount = line[1..-1].to_i                       # Get the integer value of the turn amount

    mod = direction == 'R' ? 1 : -1                 # Get the 'modifier': 1 if right, -1 if left

    amount.times { |i|
        position += mod
        position = 0  if (position.abs) == 100
        password += 1 if position == 0
    }
end

puts password

file.close