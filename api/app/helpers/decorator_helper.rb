module DecoratorHelper
  def format_time(d)
    return if d.blank?
    d.to_formatted_s(:time)
  end

  def format_date(d)
    return if d.blank?
    d.strftime('%d/%m/%Y')
  end

  def state_name(state)
    case state.to_s
    when 'activated'
      'Ativo'
    else
      'Inativo'
    end
  end
end
