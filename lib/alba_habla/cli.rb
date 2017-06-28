require 'optparse'

module AlbaHabla
  # Class used to parse command line arguments
  class Cli
    DEFAULT_OPTIONS = {
      book_path: ''
    }.freeze

    def self.parse(args)
      options = DEFAULT_OPTIONS.dup

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: alba_habla [options]'

        opts.on('--books=BOOK_PATH', 'Path to folder with book files') do |bp|
          options[:book_path] = bp.end_with?('/') ? bp : "#{bp}/"
        end
      end

      opt_parser.parse!(args)
      options
    end
  end
end
