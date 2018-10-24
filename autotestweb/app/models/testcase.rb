class Testcase < ApplicationRecord
  belongs_to :app, optional: true
  validates_uniqueness_of :case_id

  def name
    case_name
  end
end
