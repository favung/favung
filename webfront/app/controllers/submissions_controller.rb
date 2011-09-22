class SubmissionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @submissions = current_user.submissions
  end

  def new
  end

  def create
    submission = current_user.submissions.build(task: params[:submission][:task])
    submission.runs.build
    submission.save!
    GridFileSystemHelper::store_file(submission.id.to_s, params[:submission][:source])

    AgentConnection.run_submission(submission, submission.runs.last)

    redirect_to submissions_path, notice: 'Your solution has been submitted successfuly'
  end

  def show
    @submission = current_user.submissions.find(params[:id])
  end
end
