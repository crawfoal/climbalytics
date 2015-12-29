class Boulder < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  enum grade: (["VB"] + ((0..16).to_a.map {|num| "V#{num}"}))
end
