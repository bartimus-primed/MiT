import strutils

type
    YFlags = enum
        y_nothing,
        y_body,
        y_meta,
        y_strings,
        y_conditions

proc parse_yara*(yara_file: TaintedString) =
    var y_meta_body = ""
    var y_strings_body = ""
    var y_conditions_body = ""
    # We are using an array as a parsing table
    # YFlags.y_rule_body, YFlags.y_meta_body, YFlags.y_strings_body, YFlags.y_conditions_body
    var current_op = y_nothing
    for x in yara_file:
        var letter = ""
        letter.add(x)
        echo(current_op, letter)
        if current_op == y_body:
            if letter == ":":
                currentop = y_meta
                continue
        if current_op == y_meta:
            if letter != ":":
                y_meta_body &= letter
            else:
                currentop = y_strings
                continue
        if current_op == y_strings:
            if letter != ":":
                y_strings_body &= letter
            else:
                current_op = y_conditions
                continue
        if current_op == y_conditions:
            if letter != "}":
                y_conditions_body &= letter
            else:
                current_op = y_nothing
                break
        if current_op == y_nothing:
            if letter == "{":
                currentop = y_body
                continue
        letter = ""
    echo("meta: ", y_meta_body)
    echo("strings: ", y_strings_body)
    echo("conditions: ", y_conditions_body)
            # of y_strings:
            # of y_conditions:

        
    # var cleaned: seq[string]
    # var meta = (0,0)
    # var strings = (0,0)
    # var conditions = (0,0)
    # for index, line in yara_file:
    #     var v = line.strip()
    #     if v == "meta:":
    #         meta[0] = index
    #     elif v == "strings:":
    #         meta[1] = index-1
    #         strings[0] = index
    #     elif v == "condition:":
    #         strings[1] = index-1
    #         conditions[0] = index
    #         conditions[1] = x.len()-3
    #     cleaned.add(v)
    # var meta_items = cleaned[meta[0]..meta[1]]
    # var string_items = cleaned[strings[0]..strings[1]]
    # var condition_items = cleaned[conditions[0]..conditions[1]]
    # echo(meta_items, string_items, condition_items)