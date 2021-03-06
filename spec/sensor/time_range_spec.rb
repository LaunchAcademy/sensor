require 'spec_helper'

describe Sensor::TimeRange, :vcr do
  before do
    Timecop.freeze
  end

  after do
    Timecop.return
  end

  let(:day) { 24 * 60 * 60 }

  let(:start_time) do
    twenty_four_hours_ago = Time.now - day
    Date.new(twenty_four_hours_ago.year,
      twenty_four_hours_ago.month,
      twenty_four_hours_ago.day).to_time
  end

  let(:end_time) do
    now = Time.now
    (Date.new(now.year, now.month, now.day) + 1).to_time - 1
  end

  let(:date_range) { Sensor::TimeRange.new(start_time, end_time) }

  context 'instantiated with Time objects' do
    it 'has a start correlated to the constructor argument' do
      expect(date_range.start).to eql(start_time)
    end

    it 'has an end correlated to the constructor argument' do
      expect(date_range.end).to eql(end_time)
    end

    it 'has a start date' do
      date = Date.new(start_time.year, start_time.month, start_time.day)
      expect(date_range.start_date).to eql(date)
    end

    it 'has an end date' do
      date = Date.new(end_time.year, end_time.month, end_time.day)
      expect(date_range.end_date).to eql(date)
    end
  end

  context 'instantiated with strings' do
    let(:string_range) { Sensor::TimeRange.new('yesterday at 0', 'today at 11:59:59PM') }

    it 'parses a string for the start' do
      expect(string_range.start).to eql(start_time)
    end

    it 'parses a string for the end' do
      expect(string_range.end).to eql(end_time)
    end
  end

end
