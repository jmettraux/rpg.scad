
# counters/symbols.rb

# https://www.ling.upenn.edu/courses/Spring_2003/ling538/UnicodeRanges.html

sel = []

#r = (0x2190..0x21FF) # arrows
#r = (0x2600..0x26FF) # miscellaneous symbols
#sel = [ 58, 59, 60, 64, 66, 96, 99, 101, 102, 106, 107, 111 ]
#r = (0x2200..0x22FF) # mathematical operators
#sel = [ 2, 6, 17, 18, 21, 25, 26, 30, 31, 41, 43, 72, 73, 96, 97, 98, 100, 101, 110, 111, 112, 113 ]
r = (0x2300..0x23FF) # misc technical
sel = [ 2, 16, 32, 33 ]


puts("symbols = [ " + r
  .each_with_index
  .collect { |h, i| [ i, "\\u#{h.to_s(16)}" ] }
  .select { |i, x| sel.empty? || sel.include?(i) }
  .each_with_index
  .collect { |(i, x), j| "[ #{j}, \"#{x}\" ]" }
  .join(', ') + " ];")

