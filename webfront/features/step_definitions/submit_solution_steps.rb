When /^I submit the solution$/ do
  @solution_source = 'Solution source'
  fill_in 'submission_source', with: @solution_source
  click_button 'Submit'
end

Before do
  # TODO(zurkowski) Write nice mocking for Bunny.
  # Sample interface
  # mock_bunny - stub all Bunny calls
  # Bunny.queue('queue_name').published_messages

  @published_messages = []
  AgentConnection.stubs(:published_messages).returns(@published_messages)
  def AgentConnection.publish message
    published_messages << message
  end
end

Then /^the solution should be send to the queue$/ do
  Submission.first.source.should == @solution_source

  @published_messages.should have(1).message
  @published_messages.first.should == {
    input: Submission.first.id.to_s,
    output: "outputs/#{Submission.first.runs.last.id.to_s}"
  }
end
