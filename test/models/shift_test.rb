require 'test_helper'

class ShiftTest < ActiveSupport::TestCase

  def setup
    @worker = workers(:house)
    @shift = @worker.shifts.build(start_date: "2018-01-30")
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

  test "associated shifts should be destroyed" do
    @worker.save
    @worker.shifts.create!(start_date: "2018-01-30")
    assert_difference 'Shift.count', -1 do
      @worker.destroy
    end
  end
end
