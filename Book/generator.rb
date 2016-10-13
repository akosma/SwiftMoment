# This program parses a Markdown file and
# generates a Swift Playgrounds for iPad book
# (file with the extension .playgroundbook)
# It requires the kramdown and plist gems.
#
# Usage: generator [options]
#    -i, --in FILENAME                Input in Markdown format
#    -o, --out FILENAME               Output in Playgroundbook format
#    -v, --verbose                    Toggle verbose mode
#
# Author::    Adrian Kosmaczewski
# Copyright:: Copyright (c) 2016 Adrian Kosmaczewski – All Rights Reserved
# License::   BSD License

require 'kramdown'
require 'plist'
require 'fileutils'
require 'optparse'
require 'ostruct'
require './lib'

# Main program
opts = parse_arguments
valid, error_message = validate_options(opts)
if !valid
    puts error_message
    exit
end
pages = read_input(opts)
create_structure(opts)

book_manifest = create_book_manifest(opts)
save_book_manifest(opts, book_manifest)

chapter_manifest = create_chapter_manifest(opts)
create_slides(opts, pages, chapter_manifest)

puts "Created #{opts.output}" if opts.verbose
puts "Finished" if opts.verbose

