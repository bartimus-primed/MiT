import ../parser/yara_parser

proc load_yara_rules*(dir_path: string): string =
    let yara_file = open(filename=dir_path).readAll()
    parse_yara()
    return yara_file