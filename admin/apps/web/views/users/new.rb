module Web::Views::Users
  class New
    include Web::View

    def form
      Form.new(:user, routes.users_path)
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
