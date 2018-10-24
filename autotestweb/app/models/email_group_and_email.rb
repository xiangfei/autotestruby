class EmailGroupAndEmail < ApplicationRecord
  belongs_to :email
  belongs_to :emailgroup

  def name

  end

end
