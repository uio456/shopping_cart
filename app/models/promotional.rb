class Promotional < ApplicationRecord
  # validates :title, uniqueness: true

  DISCOUNT = {
    "原價" => 1,
    "打九折" => 0.9,
    "打八折" => 0.8,
    "打五折" => 0.5,
  }


end
