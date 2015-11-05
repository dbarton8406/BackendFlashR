class DeckController < ApplicationController

  def index
    @decks = Deck.all
    render "index.json.jbuilder", status: :ok
    # status 200
  end

  def create
    @deck = Deck.new(params[:deck])
    if @deck.save
     render "create.json.jbuilder", status: :ok
    else
      render json: @deck.errors, status: :unprocessable_entity }
    end
  end

  def show
    @deck = Deck.find(params[:id])
    @card = @deck.cards.paginate(:page => params[:page],
                                 :per_page => 6).order('id ASC')
    render "show.json.jbuilder", status: :ok
    # status 200
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update(deck: params[:deck]
    	            title: params [:title] 
    	            updated_at: DateTime.now
                   )
    else
      render json: @deck.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    if current_user.id == deck.user_id
      @deck.destroy
    else
      render json: { error: "Invalid (#{params[title]})" },
        status: :unauthorizedflash[:notice] = "You don't have access to this deck."
    end
  end
end