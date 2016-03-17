class Users::SessionsController < Devise::SessionsController
  self.responder = ActionController::Responder
end
