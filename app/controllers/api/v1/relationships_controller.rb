class Api::V1::RelationshipsController < ApplicationController
    skip_before_action :authorized, only: [:index, :create, :update, :destroy]
  
    def index
      @relationships = Relationship.all
      render json: @relationships
    end
  
    def create
      @relationship = Relationship.create(relationship_params)
      
        ActionCable.server.broadcast 'notifications_channel', serialized_data
        render json: { relationship: RelationshipSerializer.new(@relationship) }, status: :created
      else
        render json: { error: 'failed to create relationship' }, status: :not_acceptable
      end
    end
  
    def update
      @relationship = Relationship.find_by(mentor_id: relationship_params[:mentor_id], mentee_id: relationship_params[:mentee_id])
      @relationship.update(accepted: relationship_params[:accepted])
      
        render json: @relationship, status: :accepted
      else
        render json: { error: 'failed to update relationship' }, status: :not_acceptable
      end
    end
  
    def destroy
      @relationship = Relationship.find_by(mentor_id: relationship_params[:mentor_id], mentee_id: relationship_params[:mentee_id])
      @notification = Notification.find_by(sender_id: relationship_params[:mentee_id], recipient_id: relationship_params[:mentor_id], text: "mentorship request")
      @relationship.destroy
      @notification.destroy
    end
  
    private
    def relationship_params
      params.require(:relationship).permit(:mentee_id, :mentor_id, :accepted)
    end
  
  end