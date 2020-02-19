import pure/terminal
import ../filemgr/load_file
import ../filemgr/load_yara_file
import ../parser/file_parser
import strutils
import streams

proc show_search_help() =
    echo("string")
    echo("bytes")

proc enter_string_command(mf: FileStream): bool =
    echo("Type the string you would like to find: ")
    var search_string = readLine(stdin)
    find_string_sequence(search_string, mf)

proc enter_bytes_command(mf: FileStream): bool =
    echo("Type the byte sequence you would like to find: ex. 0x32,0x22,0x34")
    var search_string = readLine(stdin)
    (parse_byte_string(search_string, mf))

proc enter_search_constraints(mf: FileStream): seq[string] =
    var search_items: seq[string]
    var command = ""
    while command != "exit":
        case command:
            of "exit":
                break
            of "help":
                echo("Available Commands: ")
                show_search_help()
            of "string":
                echo(enter_string_command(mf))
            of "bytes":
                echo(enter_bytes_command(mf))
        echo("Please enter your search constraints: Type help for additional information")
        command = readLine(stdin)
        eraseScreen()
    return search_items

proc show_main_help() =
    echo("\t help")
    echo("\t load")
    echo("\t rules")
    echo("\t exit")

proc load_file_cmd(): (FileStream, string) =
    var file_path = readLine(stdin)
    echo("Loading file: $1" % file_path)
    var mf = load_file(file_path)
    return (mf, file_path)

proc load_yara_file_cmd(): string =
    var file_path = readLine(stdin)
    return load_yara_rules(file_path)

proc entrance*() =
    var mf: FileStream
    var filename: string
    eraseScreen()
    var choice = ""
    while choice != "exit":
        case choice:
            of "load":
                echo("($1) Please type the full file path of the suspect file: " % choice)
                (mf, filename) = load_file_cmd()
            of "help":
                echo("($1) Avaliable Commands: " % choice)
                show_main_help()
            of "rules":
                echo("($1) Load rules from file: " % choice)
                echo(load_yara_file_cmd())
            of "search":
                echo(enter_search_constraints(mf))
            of "generate":
                echo("Coming soon")
        if filename != "":
            echo("($1) What would you like to do?" % filename)
        else:
            echo("What would you like to do? type 'help' for more information")
        choice = readLine(stdin)
        eraseScreen()
    if filename != "":
        mf.close()