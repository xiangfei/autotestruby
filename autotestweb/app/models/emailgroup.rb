class Emailgroup < ApplicationRecord
  has_many :email_group_and_emails
  has_many :emails ,  :through => :email_group_and_emails
end
