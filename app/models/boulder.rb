class Boulder < Climb
  # If this is ever modified, you need to be careful with production data! The definition below implicitly defines the integer ID stored for each grade - 'VB' is stored as 0, 'V0' as 1, and so on. It is fine to add things onto the end of this array, but if you add stuff in the middle of the aray (e.g. add +/-), then you need to make sure they are assigned integer ID's above the highest current one ('V16' is stored as 17)
  enum grade: (["VB"] + ((0..16).to_a.map {|num| "V#{num}"}))
end
