require 'test_helper'

class ShiftTest < ActiveSupport::TestCase

  def setup
    @worker = workers(:house)
    @shift = @worker.shifts.build(start_date: "2018-01-15")
  end

  test "should be valid" do
    assert @shift.valid?
  end

  test "worker id should be present" do
    @shift.worker_id = nil
    assert_not @shift.valid?
  end

  test "start_date should be present" do
    @shift.start_date = nil
    assert_not @shift.valid?
  end

  test "worker should not be able to do 2 shifts the same day" do
    @worker = workers(:house)
    @shift = @worker.shifts.build(start_date: "2018-01-30")
    @shift.save
    @same_shift = @worker.shifts.build(start_date: "2018-01-30")
    assert_not @same_shift.valid?
  end
end
