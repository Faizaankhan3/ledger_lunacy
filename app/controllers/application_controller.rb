class ApplicationController < ActionController::Base
  def not_found(msg = 'could not be found')
    render(json: { errors: [ { detail: msg, title: 'Not Found'} ] }, status: :not_found)
  end
end
