require 'test_helper'

class WorkerCreationTest < ActionDispatch::IntegrationTest

  test "invalid worker information" do
    get workers_path
    assert_no_difference 'Worker.count' do
      post workers_path, params: { worker: { first_name: "",
                                             status: "surgeon"}}
    end
    assert_template 'workers/index'
    assert_select 'div#error_explanation'
  end

  test "valid worker creation" do
    get workers_path
    assert_difference 'Worker.count', 1 do
      post workers_path, params: { worker: { first_name: "Lisa",
                                             status: "medic"}}
    end
    follow_redirect!
    assert_template 'workers/show'
    assert_not flash.empty?
  end
end
