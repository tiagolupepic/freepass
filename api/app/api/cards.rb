class Cards < Roda
  include RequestHelper
  include TokenAuthenticable

  route do |r|
    r.post do
      r.is 'auth' do
        { success: true }
      end

      r.is do
        errors_or_object Card.create(params)
      end
    end

    r.is ":id" do |id|
      card = Card.find(id)

      r.get do
        card
      end

      r.put do
        card.update_attributes(params) ? card : halt_request(422, { error: card.errors.full_messages })
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
