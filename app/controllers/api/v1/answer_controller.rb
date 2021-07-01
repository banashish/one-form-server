class Api::V1::AnswerController < ApplicationController
    prepend_before_action -> {authorize_request} , except: [:create]

    def show
        form = Form.find_by(slug: params[:id])
        answers_list = form.answer.includes(questions_answer: :question)
        render json: { body: AnswerEntity.represent(answers_list) }, status: :ok
    end

    def create
        form = Form.find_by(slug: answer_params[:form])
        if !form.enable?
            return render json: { message: 'this form has been discontinued' }, status: 404
        end
        Answer.create_with_question_answer(form,answer_params[:questions])
        render json: { message: 'successfully submitted'}, status: :ok
    end

    private

    def answer_params
        params.permit(:form,questions: [:id,:value])
    end
end
