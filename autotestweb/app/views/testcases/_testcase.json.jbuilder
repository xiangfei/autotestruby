json.extract! testcase, :id, :case_id, :case_name, :is_done, :app_id, :case_type, :folder_name, :created_at, :updated_at
json.url testcase_url(testcase, format: :json)
