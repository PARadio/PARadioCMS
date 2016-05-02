class User < ActiveRecord::Base
  # adds virtual attr (password) which is plain text.
  # adds validations for that password
  # auto encrypts that password
  has_secure_password
  has_many :episodes, class_name: "Admin::Episode", dependent: :destroy
  validates :email, uniqueness: true, email: true

end
