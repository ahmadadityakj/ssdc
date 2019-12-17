class Product < ApplicationRecord
  self.inheritance_column = 'ruby_type'

  scope :by_length, lambda { |length|
    return where nil if length.blank?

    where('length <= ?', length)
  }

  scope :by_width, lambda { |width|
    return where nil if width.blank?

    where('width <= ?', width)
  }

  scope :by_height, lambda { |height|
    return where nil if height.blank?

    where('height <= ?', height)
  }

  scope :by_weight, lambda { |weight|
    return where nil if weight.blank?

    where('weight <= ?', weight)
  }

  def self.search(params = {})
    params = {} if params.blank?

    by_length(params[:length])
      .by_width(params[:width])
      .by_height(params[:height])
      .by_weight(params[:weight])
  end
end
