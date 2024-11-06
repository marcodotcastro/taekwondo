class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :start, :stop, :add_point, :add_penalty]

  def index
    @matches = Match.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @match = Match.new
    @fighters = Fighter.all
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to @match, notice: 'Luta criada com sucesso!'
    else
      @fighters = Fighter.all
      render :new, status: :unprocessable_entity
    end
  end

  def start
    unless @match.in_progress?
      @match.update(status: :in_progress, started_at: Time.current)
      broadcast_match_update
    end
    head :ok
  end

  def stop
    if @match.in_progress?
      @match.update(status: :finished)
      broadcast_match_update
    end
    head :ok
  end

  def add_point
    fighter = params[:fighter] == '1' ? :fighter1_score : :fighter2_score
    @match.increment!(fighter)
    broadcast_match_update
    head :ok
  end

  def add_penalty
    fighter = params[:fighter] == '1' ? :fighter1_penalties : :fighter2_penalties
    @match.increment!(fighter)
    broadcast_match_update
    head :ok
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:fighter1_id, :fighter2_id, :duration)
  end

  def broadcast_match_update
    Turbo::StreamsChannel.broadcast_replace_to(
      "match_#{@match.id}",
      target: "match_#{@match.id}",
      partial: "matches/match",
      locals: { match: @match }
    )
  end
end