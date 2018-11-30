# frozen_string_literal: true

module Response
  def json_response(object, status = :ok)
    raise ActiveRecord::RecordNotFound if object.nil?

    render json: object, status: status
  end
end
