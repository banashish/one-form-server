class Api::V1::QuestionsController < ApplicationController

    prepend_before_action -> { authorize_request }

    before_action :set_form, only: %i[index create]
    before_action :set_question, only: %i[update destroy]

    def index
        render json: @form.questions
    end

    def create
        question = Question.create(question_params.merge(form: @form))
        if question.errors.empty?
            render json: { body: QuestionEntity.represent(question), message: 'successfuly created' }, status: :created
        else
            render json: { errors: question.errors, message: 'not created' }, status: 403
        end
    end

    def update
        if @question.update(question_params)
            render json: { body: QuestionEntity.represent(@question), message: 'updated successfully'}, status: :ok
        else
            render json: { body: @question.errors, message: 'not updated'}, status: :unprocessable_entity
        end
    end

    def destroy
        puts 'request is here'
        res = @question.destroy
        head :no_content if res
        render json: { errors: @question.errors, message: 'not deleted' }, status: 403 unless res
    end

    private

    def set_form
        @form = Form.find_by(slug: params[:form])
    end

    def set_question
        @question = Question.find_by(slug: params[:id])
    end

    def question_params
        params.permit(:title, :kind, :order, :mandatory)
    end
end
