module RequestHelper
  def self.included(base)
    base.plugin :all_verbs
    base.plugin :indifferent_params
    base.plugin :json_parser
    base.plugin :param_matchers
    base.plugin :json, classes: [Array, Hash, ActiveRecord::Base, ActiveRecord::Relation],
      include_request: true, serializer: proc { |object| DecoratorDelegator.new(object).run.to_json }
  end

  def halt_request(status, body)
    response.status = status
    response.write(body.to_json)
    request.halt
  end

  def errors_or_object(object)
    object.valid? ? object : halt_request(422, {error: object.errors.full_messages })
  end

  def paginate(object)
    response.headers["X-Total-Pages"] = object.total_pages.to_s
    response.headers["X-Total-Count"] = object.total_entries.to_s
    response.headers["X-Per-Page"]    = WillPaginate.per_page.to_s
    object
  end
end
