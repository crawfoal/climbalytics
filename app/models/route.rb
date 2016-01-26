class Route < Climb
  # If this is ever modified, you need to be careful with production data! The definition below implicitly defines the integer ID stored for each grade - '5.4' is stored as 0, '5.5' as 1, and so on. It is fine to add things onto the end of this array, but if you make modifications to what is currently defined (e.g. you go to +/- instead of letters), or you add stuff in the middle of the aray (e.g. add +/- to 5.9), then you need to make sure they are assigned integer ID's above the highest current one ('5.15d' is stored as 29)
  enum grade: ((4..9).to_a.map {|num| "5.#{num}"}) +
              ((10..15).to_a.map {|num| ('a'..'d').to_a.map { |letter| "5.#{num}#{letter}"}}).flatten
end
