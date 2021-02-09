class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :accounts, id: :uuid, comment: 'account' do |t|
      t.string :username, null: false, comment: 'username'
      t.string :email, null: false, comment: 'email'
      t.string :avatar_url, null: true, comment: 'avatar url'
      t.string :password_digest, comment: 'encrypted password'

      t.timestamps
    end
  end
end
