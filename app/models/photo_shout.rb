class PhotoShout < ApplicationRecord
  has_attached_file :image, styles: { thumb: "200x200"}
  has_one_attached :image
end
