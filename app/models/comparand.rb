class Comparand < ActiveRecord::Base
  belongs_to :comparison
  belongs_to :item

  delegate :to_s, :rating, :update_rating!, :==, to: :item
end
