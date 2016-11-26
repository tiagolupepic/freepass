class Cards < Roda
  include RequestHelper
  include TokenAuthenticable
  include FilterParams

  route do |r|
    r.post do
      r.is 'auth' do
        auth = CardAuthenticator.new(params[:number])

        response.status = 403 unless auth.valid?
        { success: auth.valid?, user: auth.object }
      end

      r.is do
        card = Card.create(card_params)
        response.status = card.persisted? ? 201 : 422
        card
      end
    end

    r.is ":id" do |id|
      card = Card.find(id)

      r.get do
        card
      end

      r.put do
        card.update_attributes(card_params)
        response.status = 422 unless card.valid?
        card
      end

      r.delete do
        card.destroy
      end
    end

    r.get do
      r.is do
        paginate Card.paginate(page: params[:page])
      end
    end
  end
end
