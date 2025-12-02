# Initialize password accumulator
password = 0

# Read input file containing comma-separated ID ranges
content = File.read('input.txt')
ids = content.split(',')

# Process each ID range
ids.each { |id|
  left, right = id.split('-') # Parse range bounds (e.g., "102-1020")

  # Skip if both bounds have the same odd length
  # (no valid palindromic numbers exist in such ranges)
  next if ((left.length == right.length) and (right.length % 2 == 1))

  left_num = left.to_i
  right_num = right.to_i

  # Adjust range boundaries to ensure even-length numbers only
  # If left bound has odd length and is shorter than right, round up to next even-length number
  # Example: 102-1020 becomes 1000-1020 (skip all 3-digit numbers)
  left_num = (10 ** left.length) if ((left.length % 2 == 1) and (left.length < right.length))
  
  # If right bound has odd length and is longer than left, round down to previous even-length number
  # Example: 1020-10200 becomes 1020-9999 (skip all 5-digit numbers)
  right_num = (10 ** (right.length - 1) - 1) if ((right.length % 2 == 1) and (left.length < right.length))

  # Convert adjusted bounds back to strings for processing
  left = left_num.to_s
  right = right_num.to_s

  # Extract the first half of the left bound
  # For palindromes, we only need to work with the first half since second half mirrors it
  # Example: for "1020", first half is "10"
  left_half = left[0..(left.length/2 - 1)]

  # If doubling the first half produces a number less than left bound, increment it
  # Example: for bound 1020, half "10" gives palindrome "1010" < 1020, so use "11" → "1111"
  left_half = (left_half.to_i + 1).to_s if (left_half + left_half).to_i < left_num
  
  # Calculate the smallest valid palindrome in range
  left_min = (left_half + left_half).to_i

  # Skip this range if the smallest palindrome exceeds the right bound
  next if left_min > right_num

  # Apply same logic to right bound to find largest valid palindrome
  right_half = right[0..(right.length/2 - 1)]

  # If doubling the first half produces a number greater than right bound, decrement it
  # Example: for bound 1020, half "10" gives palindrome "1010" ≤ 1020, so keep "10"
  right_half = (right_half.to_i - 1).to_s if (right_half + right_half).to_i > right_num

  # Convert halves to integers for arithmetic
  left_half = left_half.to_i
  right_half = right_half.to_i

  # Calculate sum of all first-halves in the valid palindrome range
  # Using arithmetic series formula: sum(a..b) = b(b+1)/2 - a(a-1)/2
  range_sum = (right_half * (right_half + 1) / 2) - (left_half * (left_half - 1) / 2)

  # Calculate contribution to password
  # Each palindrome's value = first_half * 10^(digits/2) + first_half
  # Example: for "1221", value = 12 * 10^2 + 12 = 1212
  # Sum all palindromes: range_sum * 10^(length/2) + range_sum
  password += range_sum * (10 ** (left.length / 2)) + range_sum
}

# Output the final password
puts password