require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "nameが空では登録できない" do
        user = FactoryBot.build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end
      it "emailが空では登録できない" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end
      it "passwordが空では登録できない" do
        user = FactoryBot.build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end
      it "passwordとpassword_confirmationが不一致では登録できない" do
        user = FactoryBot.build(:user, password: "password", password_confirmation: "mismatch")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
  
      it "重複したemailが存在する場合、登録できない" do
        user = FactoryBot.create(:user, email: "test@example.com")
        user = FactoryBot.build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end
  
      it "emailのフォーマットが無効な場合、登録できない" do
        user = FactoryBot.build(:user, email: "invalid_email")
        user.valid?
        expect(user.errors[:email]).to include("is invalid")
      end

      it "emailが@を含まない場合、登録できない" do
        user = FactoryBot.build(:user, email: "no_at_symbol_example.com")
        user.valid?
        expect(user.errors[:email]).to include("is invalid")
      end
      
      it 'passwordが5文字以下では登録できない' do
        user = FactoryBot.build(:user, password: "short")
        user.valid?
        expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
      user = FactoryBot.build(:user, password: "a" * 129)
      user.valid?
      expect(user.errors[:password]).to include("is too long (maximum is 128 characters)")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        user = FactoryBot.build(:user, password: "password", password_confirmation: "mismatch")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end
end

