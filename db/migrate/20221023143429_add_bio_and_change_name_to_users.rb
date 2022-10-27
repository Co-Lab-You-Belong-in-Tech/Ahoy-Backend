class AddBioAndChangeNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :text

    # Combine first_name and last_name into name and drop last_name
    rename_column :users, :first_name, :name
    reversible do |dir|
      dir.up do
        User.all.each do |user|
          if user.name.present? and user.last_name.present?
            user.update! name: "#{user.name} #{user.last_name}"
          else
            user.update! name: "#{user.name}#{user.last_name}"
          end
        end
      end
    end

    remove_column :users, :last_name
  end
end
