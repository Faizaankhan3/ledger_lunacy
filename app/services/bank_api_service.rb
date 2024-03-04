# frozen_string_literal: true

# This service is created just for showing a pattern I would use
# The intention is to mimic calling a bank service to fetch ledger data.

class BankApiService
  ASSETS_PATH = Rails.root.join('lib', 'assets')

  def initialize(ledger_type:)
    @ledger_type = ledger_type
  end

  def fetch_ledger
    if response
      DataCleanerService.call(response)
    else
      raise StandardError, 'Failed to fetch API response'
    end
  end

  private

  def response
    JSON.parse(File.read(ASSETS_PATH.join(filename)))
  end

  def filename
    case @ledger_type
    when :simple
      'simple_ledger.json'
    when :complicated
      'complicated_ledger.json'
    when :duplicate
      'duplicate_ledger.json'
    end
  end
end
