# Alba Habla

_A fun little wrapper around your OS's speech synthesizer_

Alba Habla simply repeats what you type through your local speech synthesizer. It was originally made as a "game" for a 2 year old named Alba :) ([backstory here](https://www.mertonium.com/alba-habla))

```
$ alba_habla
What shall I say?
```

## Installation

Your system will need either `say` or [`espeak`](https://en.wikipedia.org/wiki/ESpeakNG) installed (if you're on a Mac, `say` should already be installed).
```
$ gem install alba_habla
```

## Executable options
```bash
$ alba_habla -h

Usage: alba_habla [options]
    -b, --books=BOOK_PATH        Path to folder with book files
    -v, --voice=VOICE            Voice to be used by your speech synthesizer
```

**-b, --books=BOOK_PATH** (defaults to current directory)

The "read" subcommand uses this path to look for books (a.k.a. text files, possibly containing the text of some well known childrens' stories). Example:

```
$ ls books/
green_eggs_and_ham.txt             the_cat_in_the_hat.txt

$ alba_habla --books=books/
What shall I say? read green_eggs_and_ham.txt
I am Sam
Sam I am

That Sam-I-am
That Sam-I-am!
...
```

**-v, --voice=VOICE**

This option determines the voice your OS's speech synthesizer will use. Behind the scenes we just pass this param directly to `say` or `espeak`.

If you are using `say` you can view your installed voices by running
```
$ say -v?
```
If you are using `espeak` you can view your installed voices by running
```
$ espeak --voices
```

## Subcommands

**read** - this command opens a given file and feeds it, line by line, into the speech synthesizer. The path where Alba Habla looks for the file can be set via the `--books` option.

## Exiting the program

**Note:** to exit the program, just enter "bye".
