position = 50
password = 0

file = File.open('day_1_1_input.txt', 'r')

file.each_line do |line|                          # Loop through the lines of the file
    direction = line[0]                           # Get the turn direction
    amount = line[1..-1].to_i                     # Get the integer value of the turn amount
    original = amount

    mod = direction == 'R' ? 1 : -1               # Get the 'modifier': 1 if right, -1 if left

    amount = amount - 100 * (amount / 100)        # Remove useless multiples of 100
    amount *= mod                                 # Modify the amount based of direction

    position += amount                            # Add the shift amount to the position

    position = 100 + position if position < 0     # If position is negative return it to positive
    position = position - 100 if position >= 100  # If position is 100 or grater reduce it by 100
    
    password+=1 if position == 0                  # Now if position is 0 add 1 to password
end

puts password

file.close