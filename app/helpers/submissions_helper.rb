module SubmissionsHelper
  def feedback?(feedback)
     if feedback == nil?
      @feedback = 0
    else
      @feedback = 1
    end
  end
end
