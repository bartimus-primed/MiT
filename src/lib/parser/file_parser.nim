import streams
import strutils

proc find_byte_sequence*(search_bytes: seq[int], file_s: FileStream): bool =
    echo("checking: ", search_bytes)
    var matching_arr: seq[string]
    while not file_s.atEnd:
        block main_check:
            matching_arr = @[]
            var currentChar = int(file_s.readUint8())
            if currentChar == search_bytes[0]:
                matching_arr.add(currentChar.toHex(2))
                for i in 1..search_bytes.len()-1:
                    var nextChar = int(file_s.readUint8())
                    if nextChar == search_bytes[i]:
                        matching_arr.add(nextChar.toHex(2))
                    else:
                        matching_arr = @[]
                        break main_check
                echo(matching_arr)
                echo("MATCHED ALL")
                return true
    return false

proc find_string_sequence*(search_string: string, file_s: FileStream): bool =
    var byte_sequence: seq[int]
    for letter in search_string[0 ..< search_string.high]:
        byte_sequence.add(ord(letter))
    return find_byte_sequence(byte_sequence, file_s)

proc parse_byte_string*(search_string: string, file_s: FileStream): bool =
    var byte_sequence: seq[int]
    for each_byte in search_string.split(","):
        var b = each_byte.parseHexInt()
        byte_sequence.add(b)
    return find_byte_sequence(byte_sequence, file_s)

proc get_file_header*(file_s: FileStream): seq[int] =
    var this_test = @[0x4D, 0x5A, 0x90]
    return this_test