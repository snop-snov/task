class Web::SchedulesController < Web::ApplicationController
  authorize_actions_for ScheduleType

  def new
  end

  def create
    schedule = ScheduleType.new(schedule_params)

    if schedule.valid?
      ScheduleService.import(schedule.file)

      f(:success)
      redirect_to root_path
    else
      f(:error, now: true)
      render :new
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:file)
  rescue ActionController::ParameterMissing
    ActionController::Parameters.new
  end
end
