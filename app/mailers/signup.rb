class Signup < ActionMailer::Base
  default from: 'no-reply@domain.net'
    
  def confirm_email(user)
    @user = user
   
    @confirmation_link = confirmation_url({
      token: @user.confirmation_token
    })

    mail(
        to: @user.email,
        bcc: ["Signups <emailtocheck@doamin.com>"],
        subject: I18n.t('signup.confirm_email.subject')
    )

  end
end
