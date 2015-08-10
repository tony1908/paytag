class RecordsCompanyController < ApplicationController
		before_action :check_auth
	def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = Company.find_by_email(username) 
      if resource != nil
        if resource.valid_password?(password)
        sign_in :company, resource
        $identi = resource
        else
          render :json => {status: 0}
        end
      else
        render :json => {status: 2}
      end
      
      end
  end


  def record
  	@record = Record.find(params[:id])
  	if @record.company_id == $identi.id 
  		render json: @record.to_json(:include => {:branch => {:include => :address}})
  	else
  		render json: {status: 1}
  	end
  end



  def records
  	@company = Company.find($identi.id)
  	render json: @company.to_json(:include => {:records => {:branch => {:include => :address}}})
  end
end
