class StaffLog < ApplicationRecord
    belongs_to :product
    belongs_to :staff
end
