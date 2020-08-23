class BandsController < ApplicationController
  def index
    @q = Band.paginate(page: params[:page]).ransack(params[:q])
    @collections = User.pluck(:name, :id).unshift(['募集中', 0])
    @bands = @q.result.includes(:users, :relationships).distinct(:true)
  end

  def new
    @band = Band.new
    @band.relationships.build
    @collections = User.pluck(:name, :id).unshift(['募集中', 0])
  end

  def create
    @band=Band.new(band_params)
    if @band.save
      redirect_to @band
      flash[:notice] = "バンドの登録に成功しました"
    else
      flash[:notice] = "バンドの登録に失敗しました"
      render 'bands/new'
    end
  end

  def edit
    @band=Band.find(params[:id])
    @collections = User.pluck(:name, :id).unshift(['募集中', 0])
  end

  def update
    @band=Band.find(params[:id])
    @band.update(band_params)
    if @band.save
      redirect_to @band
      flash[:notice] = "バンド情報の編集に成功しました"
    else
      flash[:notice] = "バンド情報の編集に失敗しました"
      render "bands/edit"
    end
  end

  def show
    @band=Band.find(params[:id])
    @members=@band.users
    @offerings=Relationship.where(user_id: 0,band_id: @band.id)
  end

  def destroy
    @band=Band.find(params[:id])
    if @band.delete
      redirect_to bands_path
      flash[:notice] = '削除に成功しました'
    else
      flash[:notice] = '削除に失敗しました'
      render @band
    end
  end

  # privateメソッド
  private

  def band_params
    params.require(:band).permit(
        :name,
        relationships_attributes: [
            :id,
            :part,
            :band_id,
            :user_id,
            :_destroy
        ]
    )
  end
end
