class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        students = Student.all 
        render json: students 
    end

    def show
        student = Student.find_by!(id: params[:id])
        render json: student
    end

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end

    def update
        student = Student.find_by!(id: params[:id])
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find_by!(id: params[:id])
        student.destroy
        render json: {}
    end

    private

    def render_not_found_response
        render json: {error: "Student not found"}, status: :not_found
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
