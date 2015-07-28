class RegistroCompanyController < ApplicationController
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
  	@company = Company.new company_params
  	if params[:tipo] == 0
  		if params[:rfc] =~ /[A-Z]{4}[0-9]{6}[A-Z0-9]{2,3}/
  			if @company.save!
  				render json: {status:0, id:@company.id}
  			else
  				render json: {status:1}	
  			end
  		else
  			render json: {status:2}
  		end
  	elsif params[:tipo] == 1
  		if params[:rfc] =~ /[A-Z]{3}[0-9]{6}[A-Z0-9]{2,3}/
  			if @company.save!
  				render json: {status:0,id:@company.id}
  			else
  				render json: {status:1}	
  			end
  		else
  			render json: {status:2}
  		end
  	end
  end

  def direccion
  	@address = Address.new address_params
  	@company = Company.find(params[:id])
  	if @address.save! 
  		@company.update_attributes 'address_id' => @address.id
  		render json: {status: 0}
  	else
  		render json: {status: 1}
  	end
  end

  protected
  def company_params
  	params.permit(:name, :email, :rfc)
  end
  def address_params
  	params.permit(:street, :numExt, :numInt, :colonia, :delegacion, :state, :city, :cp)
  end
end
