require 'pathname'
require Pathname(__FILE__).dirname.join('spec_base') unless $root

describe TokyoMessenger::DB, "with multiple databases" do

  before do
    load('spec/plu_db.rb') unless $codes
    @db1 = TokyoMessenger::DB.new('127.0.0.1', 45000)
    @db2 = TokyoMessenger::DB.new('127.0.0.1', 45001)
    @db1.clear
    @db2.clear
    @db1.mput($codes)
    @db2.mput($codes)
  end

  def realtime
    start = Time.now
    yield
    Time.now - start
  end
  
  it "should allow multiple threads to execute commands simultaneously on TT servers" do
    combined_time = nil
    elapsed_time = realtime {
      threads = []
      threads << Thread.new { realtime { @db1.optimize } }
      threads << Thread.new { realtime { @db2.optimize } }
      combined_time = threads.inject(0) { |sum,t| sum += t.value }
    }

    (combined_time > elapsed_time).should.be.true
  end
end
