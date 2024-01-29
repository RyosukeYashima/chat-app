require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージの作成' do
    context '保存できる場合' do
      it "contentとimageがどちらも存在すれば保存できる" do
        expect(@message).to be_valid
      end

      it "contentが存在すればimageが空でも保存できる" do
        @message.image = nil
        expect(@message).to be_valid
      end

      it "imageが存在すればcontentが空でも保存できる" do
        @message.content =nil
        expect(@message).to be_valid
      end
    end

    context '保存できない場合' do
      it "contentとimageがどちらも空だと保存できない" do
        @message.content = nil
        @message.image = nil
        @message.valid?
        expect(@message.errors[:content]).to include("can't be blank")
        expect(@message.errors[:image]).to include("can't be blank")
      end
      it 'roomが紐付いていないと保存できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Room must exist')
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('User must exist')
      end
    end
  end
end
