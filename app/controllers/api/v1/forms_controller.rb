class Api::V1::FormsController < ApplicationController
    prepend_before_action -> { authorize_request }

    before_action :set_form, only: %i[show update destroy]
    
    def index
        forms = @current_user.forms
        render json: { body: FormEntity.represent(forms), messgae: 'successfully found'}, status: :ok
    end

    def show
        render json: { body: FormEntity.represent(@form), message: 'successfully found'}, include: 'questions', status: :ok if @form

        render json: { message: 'you are not authorized to view this form'}, status: :unauthorized if !@form
    end

    def create
        form = Form.create(form_params)
        if form.errors.empty?
            render json: { body: FormEntity.represent(form), message: 'successfuly created' }, status: :ok
        else
            render json: { errors: form.errors, message: 'not created' }, status: 403
        end
    end

    def update
        if @form.update(update_params)
            render json: { body: FormEntity.represent(@form),  message: 'successfuly updated'}, status: :ok
        else
            render json: { errors: @form.errors, message: 'not updated' }, status: :unprocessable_entity
        end
    end

    def destroy
        result = @form.destroy
        head :no_content if result
        render json: { errors: @form.errors, message: 'not deleted' }, status: 403 unless result
    end

    private

    def update_params
        params.require(:form).permit(:title, :description, :primary_color, :enable)
    end

    def form_params
        params.require(:form).permit(:title, :description, :primary_color, :enable).merge(user: @current_user)
    end

    def set_form
        @form = Form.find_by(slug: params[:id], user: @current_user)
    end
end
