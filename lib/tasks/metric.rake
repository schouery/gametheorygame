require 'metric_fu'

MetricFu::Configuration.run do |config|
    config.metrics  = [
      # :churn, 
      :saikuro, 
      :stats, 
      :flog, 
      # :flay, 
      :rails_best_practices, 
      :rcov, 
      :roodi, 
      :reek
    ]
    config.graphs   = [
      # :churn, 
      # :saikuro, 
      :stats, 
      :flog, 
      # :flay,
      # :rails_best_practices, 
      :rcov, 
      :roodi, 
      :reek
    ]
    # config.graph_engine = :gchart
    config.rcov = { :environment => 'test',
                     :test_files => [#'test/**/*_test.rb', 
                                     'spec/**/*_spec.rb'],
                     :rcov_opts => ["--sort coverage", 
                                    "--no-html", 
                                    "--text-coverage",
                                    "--no-color",
                                    "--profile",
                                    "--rails",
                                    "--exclude /gems/,/Library/,/usr/,test",
                                    "--include spec"
                                    ],
                     :external => nil
                   }
     config.saikuro  = { :output_directory => 'tmp/metirc_fu/saikuro', 
                               :input_directory => ['app', 'lib'],
                               :cyclo => "",
                               :filter_cyclo => "0",
                               :warn_cyclo => "5",
                               :error_cyclo => "7",
                               :formater => "text"}
     config.flay = {:dirs_to_flay => ['app', 'lib'],
                    :minimum_score => 100,
                    :filetypes => ['rb'] }
     config.flog = { :dirs_to_flog => ['app', 'lib'] }
     config.reek = { :dirs_to_reek => ['app', 'lib'] }
     config.roodi = { :dirs_to_roodi => ['app', 'lib'] }
end
