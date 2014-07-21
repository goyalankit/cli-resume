require 'spec_helper'

describe  ResumeCli::Controllers::Command do	
  def app
    ResumeCli::Controllers::Command
  end

  it "should do nothing" do
    get '/'
    last_response.status.should == 200
  end
end


