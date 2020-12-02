class ApplicationController < ActionController::Base
     before_action :authenticate_user!
     protect_from_forgery with: :exception

        before_action :configure_permitted_parameters, if: :devise_controller?

        protected

             def configure_permitted_parameters
                  devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}

                  devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
             end

     def generate_integer(l,r)
        rand(l..r).to_s
     end

     def generate_integer_1d_array(n,l,r)
        a = n.to_s + " "
        for i in 1..n do
             a += generate_integer(l,r) + " "
        end
        a
     end

     def generate_integer_2d_array(n,m,l,r)
        a = n.to_s + " " + m.to_s + " "
        limit = m*n
        for i in 1..limit do
             a += generate_integer(l,r) + " "
        end
        a
     end


     def generate_string(l,r,flag)
        number = rand(l..r)
        if flag==0
             charset = Array('A'..'Z') + Array('a'..'z')
             return Array.new(number) { charset.sample }.join
        elsif flag==1
             charset = Array('A'..'Z')
             return Array.new(number) { charset.sample }.join
        else
             charset = Array('a'..'z')
             return Array.new(number) { charset.sample }.join
        end
     end

     def generate_string_array(n,l,r,flag)
        a = n.to_s + " "
        for i in 1..n do
             a += generate_string(l,r,flag) + " "
        end
        a
     end
   end
