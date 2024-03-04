# frozen_string_literal: true

# This service is created just for showing a pattern I would use
# to clean the API response

module DataCleanerService
  extend self

  def call(data)
    formatted_data = data
    # Remove duplciates
    formatted_data.uniq! { |entry| entry['activity_id'] }

    # Sort the data
    formatted_data.sort_by! { |entry| DateTime.parse(entry['date']).utc }.reverse

    formatted_data
  end

  private

  def cleanup_item(item)
    # Example cleanup logic for a single item
    # Replace this with your actual cleanup logic
    item.transform_values { |value| value.strip if value.is_a?(String) }
  end
end
