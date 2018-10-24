class Email < ApplicationRecord
  has_many :email_group_and_emails
  has_many :emailgroups , :through => :email_group_and_emails


end
