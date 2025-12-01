
def rotate(position, amount, direction)
    password = 0
    mod = direction == 'R' ? 1 : -1           # Get the 'modifier': 1 if right, -1 if left

    amount_of_100 = (amount / 100)            # Get the amount of 100 in the number
    amount = amount - 100*amount_of_100       # Remove the multiples of 100
    amount *= mod                             # Modify the amount based of direction

	old_position = position
    position += amount                        # Add the shift amount to the position

    if position < 0                           # If position is negative return it to positive
        position = 100 + position
        password +=1 if position != 100 \
					and old_position != 0	  # Add the transition only if start != 0 and end != 100
	end
    if position >= 100						  # If position is 100 or grater reduce it by 100
        position = position - 100
		password +=1 if old_position != 100 \
					and position != 0		  # Add the transition only if start != 100 and end != 0
	end

    password += 1 if position == 0			  # Sum 1 if end is 0
    password += amount_of_100                 # Sum the amount of times 100 is passed

    return position, password
end

position = 50
password = 0

file = File.open('input.txt', 'r')

file.each_line do |line|                      # Loop through the lines of the file
    direction = line[0]                       # Get the turn direction
    amount = line[1..-1].to_i                 # Get the integer value of the turn amount

    position, pass_mod = rotate(position, amount, direction)
    password += pass_mod
end

puts password

file.close
