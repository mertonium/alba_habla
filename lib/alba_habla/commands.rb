module AlbaHabla
  # Main class used to process commands
  class Commands
    attr_reader :voice

    DEFAULT_VOICES = {
      'say' => 'Fiona',
      'espeak' => 'en-westindies',
    }.freeze

    def initialize(book_path, voice = nil)
      @voice = voice || DEFAULT_VOICES[executable]
      @book_path = book_path
    end

    def process_command(command)
      subcommand = command.split(' ').first
      if available_subcommands.include? subcommand
        send(subcommand, command.split(' ')[1..-1].join(' '))
      else
        talk(command)
      end
    end

    private

    def executable
      @executable ||= %w[espeak say].reject do |ex|
        `which #{ex}` == ''
      end.first
    end

    def cli_options
      "-v #{voice}"
    end

    def talk_command
      "#{executable} #{cli_options}"
    end

    def talk(string)
      `#{talk_command} "#{string}"`
    end

    # Convenience mapping of a few books.
    # i.e. typing "read sam" is the same as "read green_eggs_and_ham.txt"
    def books
      {
        'sam' => 'green_eggs_and_ham.txt',
        'cat' => 'the_cat_in_the_hat.txt',
        'ladybird' => 'what_the_ladybird_heard.txt',
        'ladybird2' => 'what_the_lady_bird_heard_next.txt',
        'fox' => 'fox_in_socks.txt',
      }
    end

    def book_file(book_name)
      File.join(
        @book_path,
        books.key?(book_name) ? books[book_name] : book_name
      )
    end

    def word_bag
      @word_bag || begin
        bag = []
        books.values.each do |book_file|
          IO.foreach(@book_path + book_file) do |line|
            bag << line.gsub(/[,'\.!\?]/, '').split(' ')
          end
        end
        bag.flatten.compact.uniq
      end
    end

    def read(book_name)
      if File.exist?(book_file(book_name))
        IO.foreach(book_file(book_name)) do |line|
          puts line
          talk line.delete('"')
        end
      else
        talk "Sorry, I don't know that book. Ask Daddy to add it."
      end
    end

    def spell(_)
      word = word_bag.sample
      puts word.downcase
      talk "Let's spell #{word}."
      talk word.split('').join(' ').to_s
    end

    def available_subcommands
      %w[read spell]
    end
  end
end
