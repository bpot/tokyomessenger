# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tokyomessenger}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Bauer"]
  s.date = %q{2010-12-06}
  s.email = %q{bauer@pedalbrain.com}
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["COPYING", "Rakefile", "README.rdoc", "ext/tokyo_messenger_table.h", "ext/tokyo_messenger_table.c", "ext/tcadb.h", "ext/tcrdb.c", "ext/tokyo_messenger_module.h", "ext/tt_myconf.h", "ext/tctdb.h", "ext/md5.h", "ext/tcfdb.c", "ext/tokyo_messenger.c", "ext/tc_myconf.h", "ext/tcutil.h", "ext/md5.c", "ext/tc_myconf.c", "ext/ttutil.c", "ext/tokyo_messenger_module.c", "ext/tokyo_messenger_db.h", "ext/tokyo_messenger_db.c", "ext/tctdb.c", "ext/tcbdb.h", "ext/tcadb.c", "ext/tokyo_messenger.h", "ext/tchdb.h", "ext/tcutil.c", "ext/tchdb.c", "ext/tt_myconf.c", "ext/tokyo_messenger_query.c", "ext/tcbdb.c", "ext/extconf.rb", "ext/tcrdb.h", "ext/tokyo_messenger_query.h", "ext/tcfdb.h", "ext/ttutil.h", "lib/tokyo_messenger/balancer.rb", "lib/tokyo_messenger/dual_master.rb", "spec/tokyo_tyrant_query_spec.rb", "spec/tokyo_tyrant_spec.rb", "spec/start_tyrants.sh", "spec/tokyo_tyrant_balancer_table_spec.rb", "spec/tokyo_tyrant_balancer_db_spec.rb", "spec/tokyo_tyrant_table_spec.rb", "spec/tokyo_tyrant_threaded_spec.rb", "spec/stop_tyrants.sh", "spec/ext.lua", "spec/plu_db.rb", "spec/spec.rb", "spec/tokyo_tyrant_dual_master_spec.rb", "spec/spec_base.rb", "benchmarks/db.rb", "benchmarks/balancer.rb", "benchmarks/table.rb", "benchmarks/bulk_db.rb", "benchmarks/bulk_table.rb"]
  s.homepage = %q{http://github.com/mattbauer/tokyomessenger/}
  s.require_paths = ["ext","lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A C based TokyoTyrant Ruby adapter that doesn't require TokyoCabinet or TokyoTyrant to be installed}
  s.test_files = ["spec/spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fast_hash_ring>, [">= 0.1.1"])
    else
      s.add_dependency(%q<fast_hash_ring>, [">= 0.1.1"])
    end
  else
    s.add_dependency(%q<fast_hash_ring>, [">= 0.1.1"])
  end
end
