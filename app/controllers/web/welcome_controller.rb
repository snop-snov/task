class Web::WelcomeController < Web::ApplicationController
  def index
    redirect_to orders_path if current_user.dispatcher?
    redirect_to schedule_path if current_user.driver?
  end
end
