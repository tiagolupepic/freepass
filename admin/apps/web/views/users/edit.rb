module Web::Views::Users
  class Edit
    include Web::View

    def form
      Form.new(:user, routes.user_path(id: user.id), { user: user }, { method: :patch })
    end

    def submit_label
      'Salvar'
    end


    def persisted?
      true
    end
  end
end
