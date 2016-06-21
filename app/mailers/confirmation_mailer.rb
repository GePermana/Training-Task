class ConfirmationMailer < ActionMailer::Base

        def confirm_email(target_email, activation_token)

            @activation_token = activation_token

            mail(:to => target_email,

                        :from => "hackonrails@gmail.com",

                        :subject => "activation account ROR") do |format|

                            format.html { render 'confirm_email'}

                        end

        end

    end