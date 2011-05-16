require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Runners::RubyRunner do
  it "should run ruby script" do
    runner = Runners::RubyRunner.new
    output = runner.run("puts 'Hello world'")
    
    output.should == "Hello world\n"
  end
  
end