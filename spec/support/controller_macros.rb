module ControllerMacros
  def login(role=:user)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(role)
    end
  end
end
