class AlbaHabla
  attr_reader :voice

  DEFAULT_VOICE = "Fiona"
#DEFAULT_VOICE = "Tessa"
  def initialize(book_path)
    @voice = DEFAULT_VOICE
    @book_path = book_path
  end

  def talk(string)
    `say --voice #{voice} "#{string}"`
  end

  def books
    {
      'sam' => 'books/green_eggs_and_ham.txt',
      'cat' => 'books/the_cat_in_the_hat.txt'
    }
  end

  def word_bag
    bag = []
    books.values.each do |book_path|
      IO.foreach(book_path) { |line| bag << line.split('\s+')  }
    end
    bag.flatten.compact.uniq
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
      IO.foreach(books[book_name]) do |line|
        puts line
        talk line
      end
    else
      talk "Sorry, I don't know that book. Ask Daddy to add it."
    end
  end

  def available_subcommands
    %w{read}
  end
end

