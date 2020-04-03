class VendorStaff < User
  belongs_to :vendor
  # self.inheritance_column = false
  # 可直接查詢到所有 User。通常不會這樣用，只是做的紀錄

end
