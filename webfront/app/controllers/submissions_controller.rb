class SubmissionsController < ApplicationController
  def new
  end
  
  def create
    submission = Submission.create!
    run = submission.runs.build
    submission.save!
    GridFileSystemHelper::store_file(submission.id.to_s, params[:script][:script])

    agent = AgentConnection.new
    agent.run_script(submission.id.to_s, run.id.to_s)

    redirect_to submission_run_path(submission, run)
  end
end
