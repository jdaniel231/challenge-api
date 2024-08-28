module Api
  module V1
    class ChallengesController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :show, :destroy]
      before_action :set_challenge, only: [:show, :update, :destroy]
      before_action :authorize_admin, only: [:create, :update, :destroy]
      
      def index
        @challenges = Challenge.all
        render json: @challenges
      end

      def create
        # @challenge = Challenge.new(challenge_params.merge(user_id: current_user.id))
        @challenge = current_user.challenges.build(challenge_params)
        if @challenge.save
          render json: @challenge, status: :created
        else
          render json: @challenge.errors, status: :unprocessable_entity
        end
      end

      def show  
        render json: @challenge
      end

      def update
        if @challenge.update(challenge_params)
          render json: @challenge
        else
          render json: @challenge.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @challenge.destroy
        head :no_content
      end
    
      private

      def authorize_admin
        render json: { error: "You are not authorized to perform this action" } unless current_user.email == ENV['ADMIN_EMAIL']
      end

      def set_challenge
        @challenge = Challenge.find(params[:id])
      end
      
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date, :user_id)
      end
    end
  end
end
