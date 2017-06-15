class AlbaHabla
  attr_reader :voice

  DEFAULT_VOICES = {
    'say' => 'Fiona',
    'espeak' => 'en-westindies',
  }

  def initialize(book_path)
    @voice = DEFAULT_VOICES[executable]
    @book_path = book_path
  end

  def executable
    @executable ||= %w[espeak say].reject { |ex|
      `which #{ex}` == ''
    }.first
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

  def books
    {
      'sam' => 'green_eggs_and_ham.txt',
      'cat' => 'the_cat_in_the_hat.txt',
      'ladybird' => 'what_the_ladybird_heard.txt',
      'ladybird2' => 'what_the_lady_bird_heard_next.txt',
      'fox' => 'fox_in_socks.txt',
    }
  end

  def word_bag
    @word_bag || begin
      bag = []
      books.values.each do |book_file|
        IO.foreach(@book_path + book_file) { |line| bag << line.gsub(/[,'\.!\?]/, '').split(' ')  }
      end
      bag.flatten.compact.uniq
    end
  end

  def process_command(command)
    subcommand = command.split(' ').first
    if(available_subcommands.include? subcommand)
      send(subcommand, command.split(' ')[1..-1].join(' '))
    else
      talk(command)
    end
  end

  def read(book_name)
    if (books.has_key? book_name)
      IO.foreach(@book_path + books[book_name]) do |line|
        puts line
        talk line.gsub('"', '')
      end
    else
      talk "Sorry, I don't know that book. Ask Daddy to add it."
    end
  end

  def spell(_)
    word = word_bag.sample
    puts word.downcase
    talk "Let's spell #{word}."
    talk "#{word.split('').join(' ')}"
  end

  def available_subcommands
    %w{read spell}
  end
end
