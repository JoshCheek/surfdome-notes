#!/usr/bin/env ruby

# **CODE GOES HERE**

# define and invoke the specific notes
if $0 =~ /rspec/
  describe 'CommandLineNotes' do
    it 'prints the description if you give it -h or --help'
    it 'returns all notes by default'
    it 'filters notes by key'
    it 'filters notes by value'
    it 'filters notes by tags'
    it 'each param filters the previous results'
    it 'does not display the tags'
    it 'aligns the key and the value'
    it 'supports and aligns all lines on multiline values'
    it 'removes leading spacing'
    it 'displays every other line in a different colour'
  end
else
  # THE NOTES!
  notes = CommandLineNotes.new do |cln|
    cln.description = 'Command Line Notes'

    # American vs English
    cln.note 'cookie',       'biscuit',      'american', 'english'
    cln.note 'band-aid',     'plaster',      'american', 'english'
    cln.note 'chips',        'crisps',       'american', 'english'
    cln.note 'french fries', 'chips',        'american', 'english'
    cln.note 'soccer',       'football',     'american', 'english'
    cln.note 'sneakers',     'trainers',     'american', 'english'
    cln.note 'sweater',      'jumper',       'american', 'english'
    cln.note 'pants',        'trousers',     'american', 'english'
    cln.note 'underpants',   'pants',        'american', 'english'
    cln.notw 'cigarette',    'fag',          'american', 'english'
    cln.note 'cell phone',   'mobile phone', 'american', 'english'

    # readline
    cln.note "beginning of history",            "M-<",   "readline", "keybindings"
    cln.note "end of history",                  "M->",   "readline", "keybindings"
    cln.note "forward search history",          "C-s",   "readline", "keybindings"
    cln.note "yank last arg (iteratively)",     "M-.",   "readline", "keybindings"
    cln.note "yank last arg (iteratively)",     "M-.",   "readline", "keybindings"
    cln.note "delete right",                    "C-d",   "readline", "keybindings"
    cln.note "transpose words",                 "M-t",   "readline", "keybindings"
    cln.note "upcase word",                     "M-u",   "readline", "keybindings", "capitalize", "uppercase", "capitalization"
    cln.note "downcase word",                   "M-l",   "readline", "keybindings", "lowercase", "capitalization"
    cln.note "delete next word",                "M-d",   "readline", "keybindings"
    cln.note "show possible completions",       "M-?",   "readline", "keybindings"
    cln.note "insert all possible completions", "M-*",   "readline", "keybindings", "expand", "expansions"
    cln.note "start keyboard macro",            "C-x (", "readline", "keybindings", "begin"
    cln.note "end keyboard macro",              "C-x )", "readline", "keybindings", "stop"
    cln.note "execute keyboard macro",          "C-x e", "readline", "keybindings", "run"
    cln.note "incremental undo",                "C-_",   "readline", "keybindings"
    cln.note "tilde expand",                    "M-&",   "readline", "keybindings", "expansion"

    # **ADD MORE NOTES HERE**
  end
  puts CommandLineNotes::Binary.new(notes, ARGV).stdout
end
