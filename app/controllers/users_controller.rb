class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  # userの全員をとってきたいとき
  # ページネイトさせている。
   def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
      def create
    @user = User.new(user_params)
    file = params[:user][:image]
    @user.set_image(file)
    if @user.save
      flash[:success] = "Welcome to Twitter!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    # 連想配列になっている。paramsはPHPのPOSTと同じ。
    # :nameなどの':'から始まるものをシンボルといって' 'の文字列とかわらない。しかし、処理が早い。
    file = params[:user][:image]
    @user.set_image(file)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  # DELETE /users/1
  # DELETE /users/1.json
   def destroy
    @user.destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # 特定のidの人をとってきたいとき
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # ユーザーのデータを保存するとき、いたずらをされないように、以下の4つしか変更できないようにしている。
   def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
