class SessionsController < ApplicationController
  def new
  end



  def create
    user=User.find_by_email(params[:session][:email].downcase)
    #if user && user.authenticate('123456')
    if user && user.authenticate(params[:session][:password])
      sign_in user #sign_in is self defined method in session helper
      redirect_back_or user
    else
      flash.now[:error]='Invalid email/password combination'
      render 'new'
      end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end