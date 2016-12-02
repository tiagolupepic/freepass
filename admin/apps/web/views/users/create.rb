module Web::Views::Users
  class Create
    include Web::View
    template 'users/new'

    def form
      Form.new(:user, routes.users_path, { user: user })
    end

    def submit_label
      'Salvar'
    end

    def persisted?
      false
    end

    def periods
      user.try(:periods) || []
    end

    def holidays
      user.try(:holidays) || []
    end
  end
end
