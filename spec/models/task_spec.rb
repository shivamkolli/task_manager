require "rails_helper"

RSpec.describe Task, type: :model do
  describe "validations" do
    it "is valid with a title, status, and priority" do
      task = Task.new(
        title: "Learn RSpec",
        status: "pending",
        priority: "medium"
      )

      expect(task).to be_valid
    end

    it "is invalid without a title" do
      task = Task.new(
        title: nil,
        status: "pending",
        priority: "medium"
      )

      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end

    it "is invalid with an unsupported status" do
      task = Task.new(
        title: "Invalid task",
        status: "unknown",
        priority: "medium"
      )

      expect(task).not_to be_valid
      expect(task.errors[:status]).to include(
        "is not included in the list"
      )
    end

    it "is invalid with an unsupported priority" do
      task = Task.new(
        title: "Invalid task",
        status: "pending",
        priority: "urgent"
      )

      expect(task).not_to be_valid
      expect(task.errors[:priority]).to include(
        "is not included in the list"
      )
    end
  end

  describe "defaults" do
    it "sets the default status to pending" do
      task = Task.new

      expect(task.status).to eq("pending")
    end

    it "sets the default priority to medium" do
      task = Task.new

      expect(task.priority).to eq("medium")
    end

    it "does not override an explicitly provided status" do
      task = Task.new(status: "completed")

      expect(task.status).to eq("completed")
    end

    it "does not override an explicitly provided priority" do
      task = Task.new(priority: "high")

      expect(task.priority).to eq("high")
    end
  end

  describe ".search" do
    let!(:rails_task) do
      Task.create!(
        title: "Learn Ruby on Rails",
        description: "Study Rails architecture",
        status: "pending",
        priority: "high"
      )
    end

    let!(:python_task) do
      Task.create!(
        title: "Learn Python",
        description: "Study Python fundamentals",
        status: "pending",
        priority: "medium"
      )
    end

    it "finds tasks by title" do
      results = Task.search("Ruby")

      expect(results).to contain_exactly(rails_task)
    end

    it "finds tasks by description" do
      results = Task.search("architecture")

      expect(results).to contain_exactly(rails_task)
    end

    it "performs a case-insensitive search" do
      results = Task.search("RUBY")

      expect(results).to contain_exactly(rails_task)
    end

    it "returns an empty relation when there are no matches" do
      results = Task.search("Docker")

      expect(results).to be_empty
    end

    it "matches partial words" do
      results = Task.search("Arch")

      expect(results).to contain_exactly(rails_task)
    end
  end
end
