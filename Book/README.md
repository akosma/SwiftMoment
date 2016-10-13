# Swift Playgrounds for iPad Book Generator

This Ruby program parses the Markdown file and generates a Swift
Playgrounds for iPad book (file with the extension .playgroundbook.)

## How It Works

The current version of this program simply generates a book with a
single chapter, separating the pages with horizontal rulers (that is,
the `---` marker in Markdown, which translates as a `<HR>` tag in HTML.)

It parses the first `<H1>` elements and uses its value as the title of
the chapter.

Run the `rake` tool to generate the book.

## Requirements

It requires the kramdown and plist gems:

    gem install kramdown
    gem install plist

## License

See the LICENSE file in the
[PlaygroundBookGenerator](https://github.com/akosma/PlaygroundBookGenerator)
project in Github.

