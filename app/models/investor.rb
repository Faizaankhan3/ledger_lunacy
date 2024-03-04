# frozen_string_literal: true

# Assume you have investors data for whom you fetch the ledger from Bank Service,
# right now just a class method is fine for demonstration

class Investor
  VALID_LEDGER_TYPES = %i[simple complicated duplicate].freeze

  # Does nothing with id, may be just give a feel that you found the investor and fetched his ledger.
  def self.find(_id)
    Investor.new
  end

  # As per the data we have we have the details for a specific id, so let's hardcode it here
  def id
    76510190788
  end

  def ledger(ledger_type:)
    BankApiService.new(ledger_type: ledger_type).fetch_ledger
  end
end
