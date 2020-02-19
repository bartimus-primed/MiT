# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

import lib/ui/terminal
import os
import strformat
import lib/generator/yara_generator

when isMainModule:
  # If program is ran with a filename argument, then we will spit out yara rules for the file.
  if commandLineParams().len() > 0:
    var file_name = commandLineParams()[0]
    if os.existsFile(file_name):
      echo(&"Generating yara rules for: {file_name}\n\n")
      echo(&"Loading file, could take awhile depending on size...")
      echo(generate_rules_from_file(file_name))
    else:
      echo(&"{file_name} not found, or MiT might not have permissions to the file.")
    quit()
  else:
    entrance()