class RegistroCompradorController < ApplicationController
	protect_from_forgery with: :null_session
  # before_action :check_auth
  respond_to :json
   rescue_from(ActiveRecord::RecordInvalid) do |invalid|
   response = {status: 'error', fields: invalid.record.errors}
   render json: response, status: :unprocesaable_entity
   end
   rescue_from(ActiveRecord::RecordNotFound) do |invalid|
   response = {status: 'error', fields: 'registro no encontrado'}
   render json: response, status: :unprocesaable_entity
   end
  

  def check_auth
    authenticate_or_request_with_http_basic do |username,password|
      resource = Comapny.find_by_email(username) 
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
	def registrar
		@buyer = Buyer.new buyer_params
		if @buyer.save!
			render json: {status:0}
  		else
  			render json: {status:1}	
  		end
	end

	protected
	def buyer_params
		params.permit(:name, :password, :email)
	end
end