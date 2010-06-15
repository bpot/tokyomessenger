require 'pathname'
require Pathname(__FILE__).dirname.join('spec_base') unless $root

describe TokyoMessenger::DualMaster::DB, "with dual masters" do

  TMP_DIR = File.dirname(File.expand_path(__FILE__)) + '/../tmp'

  def start_server(port)
    `ttserver -dmn -port #{port} -pid #{TMP_DIR}/tt_#{port}.pid #{TMP_DIR}/tt_#{port}.tcb`
    sleep 0.2
  end

  def stop_server(port)
    pf = "#{TMP_DIR}/tt_#{port}.pid"
    File.exists?("#{TMP_DIR}/tt_#{port}.pid") && Process.kill(9, File.read(pf).strip.to_i) && File.delete(pf)
  end

  def stop_current_server(db)
    port = db.current_server.split(":").last
    stop_server(port)
    port
  end

  before do
    @servers = ["localhost:45010", "localhost:45020"]
    start_server("45010")
    start_server("45020")
  end

  after do
    stop_server("45010")
    stop_server("45020")
  end

  it "should fail over to another db if one server dies" do
    db  = TokyoMessenger::DualMaster::DB.new(@servers)
    db.put('suppage','nope')

    stopped_server = stop_current_server(db)
    db.put('sup','nuthin').should.be.true

    current_server = db.current_server.split(":").last
    current_server.should.not == stopped_server
  end 
  
  it "should should retry a failed server after a period" do
    db  = TokyoMessenger::DualMaster::DB.new(@servers, retry_period = 2)

    db.put('test','it')
    flapping_server = stop_current_server(db)

    db.put('funky','test') #failover
    stop_current_server(db) 

    sleep 3
    start_server(flapping_server) #and we're back

    db.put('holla','hollahollaholla').should.be.true
    db.current_server.split(":").last.should == flapping_server
  end

  it "should raise no available servers if servers are unavailable" do
    db  = TokyoMessenger::DualMaster::DB.new(@servers)

    stop_server("45010")
    stop_server("45020")
    lambda { db.put('test','ing') }.should.raise(TokyoMessenger::DualMaster::NoServersAvailable)
  end
end
