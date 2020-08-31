class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i.freeze
  MAIN_PART_VALUE = %w[Vo Gt Ba Dr Key].freeze
  ROLL_VALUE = %w[平部員 平部長 幹事 会計 渉外 機材 部長 副部長 次期部長 次期副部長].freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :gender, presence: true, numericality: { less_than_or_equal_to: 1 }
  validates :participated_at, presence: true
  validates :main_part, presence: true,  inclusion: {in: MAIN_PART_VALUE}
  validates :roll, presence: true
  validates :roll, uniqueness: true, if: :leader_uniqueness?
  has_many :relationships, dependent: :destroy
  has_many :bands, through: :relationships

  # メソッド
  #部長副部長は一意でなければならない
  def leader_uniqueness?
    roll == "部長" || roll ==  "副部長" || roll == "次期部長" || roll ==  "次期副部長"

  end
  # 渡されたユーザーの性別を文字列で返す
  def what_gender
    if gender == 0
      '男'
    else
      '女'
    end
  end

  #渡されたユーザーの代を返す
  def what_generation?
    self.participated_at - 1969
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
