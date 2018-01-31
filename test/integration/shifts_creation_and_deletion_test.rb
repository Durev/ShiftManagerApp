require 'test_helper'

class ShiftsCreationAndDeletionTest < ActionDispatch::IntegrationTest

  def setup
    @worker = workers(:house)
  end

  test "shift creation" do
    @worker.save
    get shifts_path
    assert_select 'form'
    start_date = "2019-01-01"
    # Valid submission
    assert_difference 'Shift.count', 1 do
      post shifts_path, params: { shift: { start_date: start_date,
                                           worker_id: @worker.id } }
    end
    assert_redirected_to shifts_url
    follow_redirect!
    assert_not flash.empty?
    # Invalid submission (worker already busy)
    assert_no_difference 'Shift.count' do
      post shifts_path, params: { shift: { start_date: start_date,
                                           worker_id: @worker.id } }
    assert_select 'div#error_explanation'
    end
  end

  test "shift deletion" do
    @worker.save
    @worker.shifts.create!(start_date: "2019-01-01")
    get shifts_path
    assert_select 'a.btn-danger', text: 'X'
    first_shift = @worker.shifts.first
    assert_difference 'Shift.count', -1 do
      delete shift_path(first_shift)
    end
  end
end
