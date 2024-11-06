class FightersController < ApplicationController
  def index
    @fighters = Fighter.all
  end

  def new
    @fighter = Fighter.new
  end

  def create
    @fighter = Fighter.new(fighter_params)
    if @fighter.save
      redirect_to fighters_path, notice: 'Lutador criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def fighter_params
    params.require(:fighter).permit(:name, :category, :weight, :bio, :photo)
  end
end