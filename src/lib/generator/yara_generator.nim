import streams
import ../parser/file_parser
import ../filemgr/load_file
import strutils
import strformat
import times

var strings_count = 0

proc yara_template(file_name: string, meta: string, strings: string, conditions:string): string =
    return 

proc build_string_from_int_seq(seq_to_transform: seq[int]): string =
    var string_obj = &"$string{strings_count} = "
    result = string_obj & "{"
    for index, val in seq_to_transform:
        if index == seq_to_transform.len() - 1:
            result &= &"{val:02X}"
        else:
            result &= &"{val:02X} "
    result &= "}"
    strings_count += 1

proc generate_rules_from_file*(file_name: string): string =
    var mf = load_file(file_name)
    var file_header = build_string_from_int_seq(get_file_header(mf))
    var t_name = file_name.split("\\")
    t_name = t_name.pop().split(".")
    var cleaned_name = t_name[0]
    var rule_head = &"rule {cleaned_name} : AUTOCREATION{cleaned_name}"
    var rule_meta = &"\tmeta:\n\t\tauthor = \"MiT Auto Generator\"\n\t\tdate = \"{times.getDateStr()}\""
    var rule_strings = &"\n\tstrings:\n\t\t{file_header}\n"
    var rule_conditions = &"\tcondition:\n\t\t{strings_count} of them"
    var full_rule = rule_head & "\n{\n" & rule_meta & rule_strings & rule_conditions & "\n}"
    return full_rule