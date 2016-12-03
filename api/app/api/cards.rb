module Api
  class Cards < Roda
    include RequestHelper
    include TokenAuthenticable
    include FilterParams

    route do |r|
      r.post do
        r.is 'auth' do
          auth = AuthenticatorService.new('card', params[:number]).run
          response.status = 403 unless auth[:success]
          auth
        end

        r.is do
          card = Card.create(card_params)
          response.status = card.persisted? ? 201 : 422
          card
        end
      end

      r.is ":id" do |id|
        card = find_card(id)

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
        r.on :param => 'q' do
          paginate Card.search(params[:q]).paginate(page: params[:page])
        end

        r.is do
          paginate Card.paginate(page: params[:page])
        end
      end
    end

    def find_card(id)
      Card.find(id)
    rescue ActiveRecord::RecordNotFound
      halt_request(404, { error: 'Card not found.' })
    end
  end
end
