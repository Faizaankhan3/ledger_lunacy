# frozen_string_literal: true

class LedgersController < ApplicationController
  before_action :validate_ledger_type!

  # I am just considering that this show action returns the presentable ledger for
  # any given user
  def show
    render json: { ledger: presented_data }
  end

  private

  def presented_data
    ledger.map do |entry|
      LedgerEntryPresenter.new(entry: entry, investor: investor).present_data
    end
  end

  def ledger
    investor.ledger(ledger_type: params[:ledger_type].to_sym)
  end

  # Just mimicking that there's a user in the DB, it's essentially fake
  def investor
    @_investor ||= Investor.find(params[:id])
  end

  def validate_ledger_type!
    not_found unless Investor::VALID_LEDGER_TYPES.include?(params[:ledger_type].to_sym)
  end
end
