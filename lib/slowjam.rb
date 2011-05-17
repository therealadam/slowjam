require 'active_support/core_ext/module'

module Slowjam

  mattr_accessor :threshold
  mattr_accessor :frames # 5
  mattr_accessor :accept # TODO: %r{^(app|config|lib)}.freeze
  mattr_accessor :cleaner # ActiveSupport::BacktraceCleaner

  def self.attach
    QueryTracer.attach_to :active_record
  end

  autoload :QueryTracer, 'slowjam/query_tracer'

end

