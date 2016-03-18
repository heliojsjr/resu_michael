class User < ActiveRecord::Base
	
    EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  
    scope :confirmed, -> { where.not(confirmed_at: nil) }

    validates_presence_of :email, :full_name
    validates_uniqueness_of :email

    has_secure_password  

	# Callback to create the confirmation_token
    before_create do |user|
	   user.confirmation_token = SecureRandom.urlsafe_base64
	end

	# Confirm the user's email, validating the account
	def confirm!
        return if confirmed?
        self.confirmed_at = Time.current
        self.confirmation_token = ''
        save!
	end

    # Check if the User is confirmed
    def confirmed?
        confirmed_at.present?
	end

	# Check if e-mail and password matches and if yes, store user's session
	def self.authenticate(email, password)
		# Using Scope to filter only confirmed Users
        user = confirmed.find_by(email: email)
        if user.present?
            user.authenticate(password)
        end
    end
	
    # Validate the e-mail according to the RegExp
    validates_format_of :email, with: EMAIL_REGEXP

end
