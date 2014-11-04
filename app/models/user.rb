class User < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :tweets
       #defはPHPでいう、functionと同じ
  def set_image(file)
  	   # nullをRubyではnulという。
    if !file.nil?
    	# ファイル名
      file_name = file.original_filename
      # 画像をアップロード #{file_name}にしているのは、そのままfilenameと入れてしまうと、変数として認識してもらえない。ここで#{}をつけることによって変数としてあつかってもら合える。
      File.open("public/docs/#{file_name}", 'wb'){|f| f.write(file.read)}
      # データベースにファイルを保存するための準備としてこの一行が必要。
      self.image = file_name
    end
  end
end