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

    def periods
      user.try(:periods) || []
    end

    def holidays
      user.try(:holidays) || []
    end

    def roles
      [['Administrador', 'admin'], ['Usuário', 'user']]
    end
  end
end
