# frozen_string_literal: true

class LedgerEntryPresenter
  def initialize(entry:, investor:)
    @entry = entry.with_indifferent_access
    @investor = investor
  end

  def present_data
    {
      amount: @entry[:amount],
      balance: @entry[:balance],
      description: description,
      transation_type: @entry[:type],
      date: DateTime.parse(@entry[:date]).strftime("%m/%d/%Y")
    }
  end

  private

  # The data has lots of descrepancies, but from what's provided this should work
  def description
    case @entry['type']
    when 'DEPOSIT'
      "Deposited $#{amount_value} from #{source_description}"
    when 'INVESTMENT'
      "Invested $#{amount_value} in #{destination_description}"
    when 'REFUND'
      "Refund of $#{amount_value} from #{source_description}"
    when 'WITHDRAWAL'
      "Withdrawal of $#{amount_value} to #{destination_description}"
    when 'TRANSFER'
      if @entry['source']['id'] == @investor.id
        "Transferred $#{amount_value} to #{destination_description}"
      else
        "Received $#{amount_value} from #{source_description}"
      end
    else
      "Unknown transaction type: #{@entry['type']}"
    end
  end

  def amount_value
    @entry[:amount]&.abs
  end

  def source_description
    @entry['source']['description'] || @entry['source']['type']
  end

  def destination_description
    @entry['destination']['description'] || @entry['destination']['type']
  end
end
