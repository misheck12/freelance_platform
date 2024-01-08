# app/helpers/application_helper.rb

module ApplicationHelper
  def badge_color_for_status(status)
    case status
    when 'pending'
      'badge-secondary'
    when 'in_progress'
      'badge-primary'
    when 'completed'
      'badge-success'
    else
      'badge-warning'
    end
  end

  def badge_color_for_rating(rating)
    case rating
    when 5
      'badge-success'
    when 4
      'badge-info'
    when 3
      'badge-warning'
    when 1..2
      'badge-danger'
    else
      'badge-secondary'
    end
  end
end
