class CacheUserJob < ApplicationJob
  queue_as :default

  def perform(user)
		user.cache_scrobbles_after(Time.at 0)
  end
end
