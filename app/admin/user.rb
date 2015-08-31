ActiveAdmin.register User do
  permit_params :email, :role

  index do
    selectable_column
    column "Email" do |user|
      link_to user.email, edit_admin_user_path(user)
    end
    column :role
    column "Person" do |user|
      link_to user.person.full_name, person_path(user.person) unless user.person.nil?
    end
    column "Creation", :created_at
    column "Last Signed In", :last_sign_in_at

    actions defaults: false do |user|
      link_to "Delete", admin_user_path(user), method: :delete, data: { confirm: 'Are you sure?' }
    end
  end
end
