import ../parser/yara_parser

proc load_yara_rules*(dir_path: string): string =
    let yara_file = open(filename=dir_path)
    let yara_string = yara_file.readAll()
    yara_file.close()
    parse_yara(yara_string)
    return "none"