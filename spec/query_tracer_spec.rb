require 'slowjam'
require 'active_support/backtrace_cleaner'

describe Slowjam::QueryTracer do
  before do
    Slowjam.threshold = 1000
    Slowjam.frames = 5
    Slowjam.accept = %r{}
    Slowjam.cleaner = ActiveSupport::BacktraceCleaner.new
  end

  it 'logs an event if it exceeds the threshold' do
    Slowjam.threshold = 100

    subject.should_receive(:warn).exactly(3).times
    event = stub(:duration => 500, :payload => {:sql => ''})

    subject.sql(event)
  end

  it 'does nothing if an event is below the threshold' do
    subject.should_receive(:warn).never
    event = stub(:duration => 500)

    subject.sql(event)
  end

  it 'generates a marker message' do
    subject.marker.should =~ /SLOW QUERY/
  end

  it 'logs a summary' do
    event = stub(
      :duration => 1120,
      :payload => {:name => 'Users', :sql => 'SELECT * FROM USERS'}
    )
    subject.summary(event).should == '    Users (1120.0ms) SELECT * FROM USERS'
  end

  it 'logs a pretty backtrace' do
    Slowjam.frames = 2

    stack = [
      "foo.rb:6:in `three'",
      "foo.rb:5:in `two'",
      "foo.rb:3:in `one'"
    ]

    subject.backtrace(stack).should == 'foo.rb:6 | foo.rb:5'
  end
end
