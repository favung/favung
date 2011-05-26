class RunsController < ApplicationController
  def show
    submission = Submission.find(params[:submission_id])
    run = submission.runs.find(params[:id])

    @output = GridFileSystemHelper::read_file(run.id.to_s)
  end
end
