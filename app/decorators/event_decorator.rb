class EventDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  decorates_association :users

  def friendly_date
    date.strftime("%b %d")
  end

  def friendly_hour
    time.strftime("%l:%M%P")
  end

  #Returns how long ago the event was created
  def time_created
    dif = (Time.now.hour - created_at.hour).abs
    if dif < 24
      return "#{dif}h"
    elsif dif < 168
      w = (dif/24).floor
      return "#{w}d"
    else 
      return ">1w"
    end
  end

end
