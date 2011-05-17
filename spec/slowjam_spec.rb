require 'slowjam'

describe Slowjam do

  it 'attaches the tracer to ActiveRecord' do
    Slowjam::QueryTracer.should_receive(:attach_to).with(:active_record)
    Slowjam.attach
  end

end
