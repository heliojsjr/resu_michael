class UserSessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(email: params[:user_session][:email].downcase)

        if user && user.authenticate(params[:user_session][:password])
            log_in user
            #redirect_to user
            redirect_to root_path, notice: t('flash.notice.signed_in')

        else
            #flash[:danger] = 'Invalid email/password combination' # Not quite right!
            #errors.add(:base, :invalid_login)
            render 'new'
        end
        
	end

    def destroy
        # Ainda não :-)
    end

end
