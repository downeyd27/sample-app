require 'rails_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include a page title" do
      expect(full_title("foo")) =~ /foo/
    end

    it "should include a base title" do
      expect(full_title("foo")) =~ /Project Name/
    end
    it "should not include a bar for the home page" do
      expect(full_title("")).to_not eq(/\|/)
    end
  end
end