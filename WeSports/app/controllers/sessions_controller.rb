class SessionsController < ApplicationController
#purpose: logging a user in, logging a user out, omniauth
    def welcome
    end

    def new
    end

    def quick_login
        raise "quick login only works in cucumber environment! it's meant for acceptance tests only" unless Rails.env.test?
        u = Player.find params[:id]
        if u
            session[:user_id] = u.id
            render :text => "assumed identity of #{u.username}"
        else
            raise "failed to assume identity"
        end
    end

    def create
        u = Player.find_by_email(params[:email])
        if u
            session[:user_id] = u.id
            redirect_to user_path(u)
        else
            flash[:message] = "Invalid credentials. Please try again."
            redirect_to '/login', alert: "Invalid credentials. Please try again."
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/login'
    end

    def omniauth  #log users in with omniauth
        user = Player.create_from_omniauth(auth)
        if user.valid?
            session[:user_id] = user.id
            redirect_to games_path
        else
            flash[:message] = user.errors.full_messages.join(", ")
            redirect_to '/login'
        end
    end

    private
    def auth
        request.env['omniauth.auth']
    end

end