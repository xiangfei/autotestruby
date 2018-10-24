class Runtestcase < ApplicationRecord
  def name
    appx = App.find_by_name(app)
    if appx
      appx.name
    else
      "app deleted"
    end
  end
end
