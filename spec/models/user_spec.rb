require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての入力フォームに正しい情報が存在するなら登録できる' do
        expect(@user).to be_valid 
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = "a12345"
        @user.password_confirmation = "a12345"
        expect(@user).to be_valid
      end
      it 'passwordが半角英数字混合であれば登録できる' do
        @user.password = "a1b2c3"
        @user.password_confirmation = "a1b2c3"
        expect(@user).to be_valid
      end
      it 'お名前(全角)が全角(漢字、ひらがな、カタカナ)であれば登録できる' do
        @user.last_name = "高橋"
        @user.first_name = "未来虹"
        expect(@user).to be_valid
      end
      it 'お名前カナ(全角)が全角(カタカナ)であれば登録できる' do
        @user.last_name_kana = "タカハシ"
        @user.first_name_kana = "ミクニ"
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空だと登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれてないと登録できない' do
        @user.email = 'qwertyuiop'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが空だと登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英字と半角数字の両方を含めて設定してください")
      end
      it 'passwordが半角数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英字と半角数字の両方を含めて設定してください")
      end
      it 'passwordが全角文字を含む場合は登録できない' do
        @user.password = 'a１b2c3'
        @user.password_confirmation = 'a１b2c3'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には半角英字と半角数字の両方を含めて設定してください")
      end
      it 'passwordとpassword_confirmationが一致してないと登録できない' do
        @user.password_confirmation = 'a12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空だと登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_nameとfirst_nameが全角(漢字、ひらがな、カタカナ)以外だと登録できない' do
        @user.last_name = 'takahasi'
        @user.first_name = 'mikuni'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name には全角文字のみ使用可能です", "First name には全角文字のみ使用可能です")
      end
      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'last_name_kanaとfirst_name_kanaが全角(カタカナ)以外だと登録できない' do
        @user.last_name_kana = 'takahasi'
        @user.first_name_kana = 'mikuni'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana には全角カナのみ使用可能です", "First name kana には全角カナのみ使用可能です")
      end
      it 'birth_dateが空だと登録できない' do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
