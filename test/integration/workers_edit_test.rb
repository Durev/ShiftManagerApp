require 'test_helper'

class WorkersEditTest < ActionDispatch::IntegrationTest

  def setup
    @worker = workers(:house)
  end

  test "invalid update information" do
    get edit_worker_path(@worker)
    assert_template 'workers/edit'
    patch worker_path(@worker), params: { worker: { first_name: "",
                                                    status: "doc" } }
    assert_template 'workers/edit'
  end

  test "valid update information" do
    get edit_worker_path(@worker)
    assert_template 'workers/edit'
    first_name = "Gregory"
    status = "medic"
    patch worker_path(@worker), params: { worker: { first_name: first_name,
                                                    status: status } }
    assert_not flash.empty?
    assert_redirected_to @worker
    @worker.reload
    assert_equal first_name, @worker.first_name
    assert_equal status, @worker.status
  end

  test "deleting worker" do
    get edit_worker_path(@worker)
    assert_template 'workers/edit'
    assert_difference 'Worker.count', -1 do
      delete worker_path(@worker)
    end
  end
end
