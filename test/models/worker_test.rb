require 'test_helper'

class WorkerTest < ActiveSupport::TestCase

  def setup
    @worker = Worker.new(status: "medic", first_name: "Gregory")
  end

  test "should be valid" do
    assert @worker.valid?
  end

  test "first name should be present" do
    @worker.first_name = "  "
    assert_not @worker.valid?
  end

  test "status should be present" do
    @worker.status = ""
    assert_not @worker.valid?
  end

  test "status should be medic, interne or interim" do
    @worker.status = "surgeon"
    assert_not @worker.valid?
  end

  test "name should not be too long" do
    @worker.first_name = "a" * 51
    assert_not @worker.valid?
  end

  test "name should be unique" do
    duplicate_worker = @worker.dup
    duplicate_worker.first_name = @worker.first_name.upcase
    @worker.save
    assert_not duplicate_worker.valid?
  end

  test "associated shifts should be destroyed" do
    @worker.save
    @worker.shifts.create!(start_date: "2018-03-30")
    assert_difference 'Shift.count', -1 do
      @worker.destroy
    end
  end

end
