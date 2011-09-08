class SubmissionsController < ApplicationController
  def index
    @submissions = current_user.submissions
  end

  def new
  end

  def create
    submission = current_user.submissions.build(task: params[:submission][:task])
    submission.save!
    GridFileSystemHelper::store_file(submission.id.to_s, params[:submission][:source])

    AgentConnection.run_submission(submission)

    redirect_to submissions_path
  end

  def show
    @submission = current_user.submissions.find(params[:id])
  end
end
