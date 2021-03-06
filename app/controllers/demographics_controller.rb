class DemographicsController < ApplicationController
  include SignatureUpdater

  before_action :authenticate_student!

  def new
    update_signature_request
    @demographic_info = DemographicInfo.new
  end

  def create
    @demographic_info = DemographicInfo.new(current_student, demographic_info_params)
    if @demographic_info.save
      current_student.update(demographics: true)
      redirect_to payment_methods_path
    else
      render :new
    end
  end

private
  def demographic_info_params
    params.require(:demographic_info).permit(:birth_date, :disability, :veteran, :education, :cs_degree, :address, :city, :state, :zip, :country, :shirt, :job, :salary, :genders => [], :races => [])
  end
end
