require 'growl'

require_relative '../../lib/notifier'

describe Notifier do

  it "can annoy you" do
    subject.stub(:priority) { "Normal" }
    subject.annoy
  end

end
