class Api::PropertyController < ApplicationController
  def search
    begin
      @properties = Properties::SearchPropertiesService.call(
                            params[:property_type],
                            params[:marketing_type],
                            params[:lat],
                            params[:lng],
                            params[:page],
                            params[:limit]
                          )

      render json: @properties,
             each_serializer: PropertySerializer

    rescue NoDataError => e
      render json: { error: e }, :status => :ok
    rescue InvalidInputParamsError => e
      render json: { error: e.errors_hash }, :status => :unprocessable_entity
    rescue StandardError => e
      render json: { error: e }, :status => :internal_server_error
    end
  end
end