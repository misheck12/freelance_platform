module ApplicationHelper
    def badge_color_for_status(status)
      case status
      when 'pending'
        'badge-secondary'
      when 'in_progress'
        'badge-info'
      when 'completed'
        'badge-success'
      when 'cancelled'
        'badge-danger'
      else
        'badge-primary'
      end
    end
  end
  