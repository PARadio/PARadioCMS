class User < ActiveRecord::Base
  # adds virtual attr (password) which is plain text.
  # adds validations for that password
  # auto encrypts that password
  has_secure_password

end
