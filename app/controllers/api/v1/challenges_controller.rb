module Api
  module V1
    class ChallengesController < ApplicationController
      
      def index
        @challenges = Challenge.all
        render json: @challenges
      end

      def create
        @challenge = Challenge.new(challenge_params)
        if @challenge.save
          render json: @challenge, status: :created
        else
          render json: @challenge.errors, status: :unprocessable_entity
        end
      end

      def show  
        @challenge = Challenge.find(params[:id])
        render json: @challenge
      end

      def update
        @challenge = Challenge.find(params[:id])
        if @challenge.update(challenge_params)
          render json: @challenge
        else
          render json: @challenge.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @challenge = Challenge.find(params[:id])
        @challenge.destroy
        head :no_content
      end
    
      private
      
      def challenge_params
        params.require(:challenge).permit(:title, :description, :start_date, :end_date)
      end
    end
  end
end