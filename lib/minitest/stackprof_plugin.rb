module Minitest
    module StackProfPlugin
        def before_setup
            StackProf.start
            super
        end

        def after_teardown
            super
            StackProf.stop
        end
    end

    class StackProfReporter < AbstractReporter
        attr_reader :output_file

        def initialize(output_file)
            @output_file = output_file
        end

        def report
            StackProf.results(output_file)
        end
    end

    def self.plugin_stackprof_options(opts, options)
        opts.on '--stackprof[=FILE]', 'run under stackprof (optionally specifies the mode)' do |mode|
            options[:stackprof] = mode || "stackprof-minitest-#{Process.pid}.dump"
        end
    end
    def self.plugin_stackprof_init(options)
        if output_file = options[:stackprof]
            require 'stackprof'
            puts "Stackprof enabled - dumping results to #{output_file}"
            Minitest::Test.prepend StackProfPlugin
            reporter << StackProfReporter.new(output_file)
        end
    end
end

