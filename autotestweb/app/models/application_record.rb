class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_save :check_attribute

  def check_attribute
    unless self.attributes["name"]
      raise "需要在method 或者 attribute 定义name" if self.methods.grep(:name).empty?
    end
  end
end
