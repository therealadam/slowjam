require 'active_support/log_subscriber'

class Slowjam::QueryTracer < ActiveSupport::LogSubscriber
  
  def sql(event)
    return unless event.duration > Slowjam.threshold

    warn(marker)
    warn(summary(event))
    warn(backtrace(caller))
  end

  # Protected
  def marker
    '  SLOW QUERY'
  end

  # Protected
  def summary(event)
    name = '%s (%.1fms)' % [event.payload[:name], event.duration]
    sql  = event.payload[:sql].squeeze(' ')

    "    #{name} #{sql}"
  end

  # Protected
  def backtrace(stack)
    Slowjam.
      cleaner.
      clean(stack).
      select { |f| f =~ Slowjam.accept }.
      take(Slowjam.frames).
      map { |f| f.split(':').take(2).join(':') }.
      join(' | ')
  end
end
