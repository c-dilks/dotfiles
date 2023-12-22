# pry configuration
require 'awesome_print'
AwesomePrint.pry!
require 'pry-doc'

# aliases
Pry.config.commands.alias_command 'sd', 'show-doc'
Pry.config.commands.alias_command 'ss', 'show-source'
