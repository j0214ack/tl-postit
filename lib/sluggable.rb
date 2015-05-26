module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true, uniqueness: true
    before_validation :generate_slug, on: :create
    class_attribute :slug_column
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

  def to_slug(str)
    str.downcase.gsub(/\s*[^a-zA-Z0-9]\s*/, "-").gsub(/-+/,"-")
  end

  def generate_slug
    self.slug = to_slug(self.send(self.class.slug_column.to_sym))
    suffix = ""
    counter = 1
    other_obj = self.class.find_by(slug: self.slug)
    while( other_obj && other_obj != self ) do
      suffix = "-#{counter}"
      counter += 1
      other_obj = self.class.find_by(slug: (self.slug + suffix))
    end
    self.slug += suffix
  end

  def to_param
    self.slug
  end
end
