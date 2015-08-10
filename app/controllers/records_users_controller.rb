class RecordsUsersController < ApplicationController
	before_action :check_auth
	def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = User.find_by_email(username) 
      if resource != nil
        if resource.valid_password?(password)
        sign_in :user, resource
        $identi = resource
        else
          render :json => {status: 0}
        end
      else
        render :json => {status: 2}
      end
      
      end
  end


  def records
  	@records = Record.where(user_id:$identi.id)
  	render json: @records.as_json(:include => {:branch => {:include => :address}})
  	# render json: @records.as_json(:include => {:card => {:include => {:branch => {:include => address}}}})
  end

  def record
  	@record = Record.find(params[:id])
  	if @record.user_id == $identi.id 
  		render json: @record.as_json(:include => {:branch => {:include => :address}})
  	else
  		render json: {status: 1}
  	end
  end

end
