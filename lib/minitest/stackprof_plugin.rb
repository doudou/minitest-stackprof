module Minitest
    module StackProfPlugin
        @include_setup_and_teardown = false

        def self.include_setup_and_teardown?
            @include_setup_and_teardown
        end

        def self.include_setup_and_teardown=(flag)
            @include_setup_and_teardown = !!flag
        end

        def before_setup
            if StackProfPlugin.include_setup_and_teardown?
                StackProf.start(raw: true)
            end
            super
        end

        def after_setup
            super
            if !StackProfPlugin.include_setup_and_teardown?
                StackProf.start(raw: true)
            end
        end

        def before_teardown
            super
            if !StackProfPlugin.include_setup_and_teardown?
                StackProf.stop
            end
        end

        def after_teardown
            super
            if StackProfPlugin.include_setup_and_teardown?
                StackProf.stop
            end
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
        opts.on '--profile-setup', 'profile the setup and teardown as well as the test' do
            StackProfPlugin.include_setup_and_teardown = true
        end
        opts.on '--stackprof[=FILE]', String, 'run under stackprof (optionally specifies the output file)' do |file|
            options[:stackprof] = file || "stackprof-minitest-#{Process.pid}.dump"
        end
    end
    def self.plugin_stackprof_init(options)
        if output_file = options[:stackprof]
            require 'stackprof'
            puts "Stackprof enabled - dumping results to #{output_file}"
            puts "Stackprof: #{"NOT " if !StackProfPlugin.include_setup_and_teardown?} profiling the setup/teardown"
            Minitest::Test.prepend StackProfPlugin
            reporter << StackProfReporter.new(output_file)
        end
    end
end

