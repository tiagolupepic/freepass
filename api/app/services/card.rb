class CardAuthenticator
  # check if exist card
  # check if card have period to access
  # check if card is strict to access same hours
  # check if card have holiday permissions
  # check if user is blocked
  WDAYS = { sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6 }

  attr_accessor :number

  def initialize(number)
    @number = number
  end

  def valid?
    return false unless number
    card.present? and valid_user? and valid_period? and valid_hour? and valid_holiday?
  end

  def object
    return unless valid?
    decorated_user
  end

  private

  def valid_user?
    user.activated?
  end

  def valid_period?
    return true if user_periods.empty?
    user_periods.include? today.to_date
  end

  def valid_hour?
    return true if user.hours.empty?
    user_hours.any?
  end

  def valid_holiday?
    return true unless holiday
    user.holidays.include? holiday
  end

  def wday_valid?(h)
    days = h.days.select { |_,d| d == "true" }
    return true if days.empty?
    days.keys.include? WDAYS.key(today.wday).to_s
  end

  def user_periods
    @periods ||= user.periods.collect { |period| (period.start_at.to_date..period.end_at.to_date).to_a }.flatten.uniq
  end

  def user_hours
    user.periods.select do |period|
      next unless (period.start_at.to_date..period.end_at.to_date).to_a.include? today.to_date

      period.hours.empty? or
      period.hours.any? do |h|
        today >= today.change(hour: h.start_at.hour, min: h.start_at.min) and today <= today.change(hour: h.end_at.hour, min: h.end_at.min) and wday_valid?(h)
      end
    end
  end

  def holiday
    @holiday ||= Holiday.find_by happen_at: today.to_date
  end

  def card
    @card ||= Card.find_by number: number
  end

  def user
    card.user
  end

  def decorated_user
    UserDecorator.new(user)
  end

  def today
    Time.now
  end
end
