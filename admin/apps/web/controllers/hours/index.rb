module Web::Controllers::Hours
  class Index
    include Web::Action
    expose :hours

    def call(params)
      @hours = Hour.all
    end
  end
end
