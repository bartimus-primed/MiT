import strutils

proc parse_yara*() =
    var x = """
    rule sakura_jar : EK
    {
    meta:
       author = "Josh Berry"
       date = "2016-06-26"
       description = "Sakura Exploit Kit Detection"
       hash0 = "a566ba2e3f260c90e01366e8b0d724eb"
       sample_filetype = "unknown"
       yaragenerator = "https://github.com/Xen0ph0n/YaraGenerator"
    strings:
       $string0 = "Rotok.classPK"
       $string1 = "nnnolg"
       $string2 = "X$Z'\\4^=aEbIdUmiprsxt}v<" wide
       $string3 = "()Ljava/util/Set;"
       $string4 = "(Ljava/lang/String;)V"
       $string5 = "Ljava/lang/Exception;"
       $string6 = "oooy32"
       $string7 = "Too.java"
       $string8 = "bbfwkd"
       $string9 = "Ljava/lang/Process;"
       $string10 = "getParameter"
       $string11 = "length"
       $string12 = "Simio.java"
       $string13 = "Ljavax/swing/JList;"
       $string14 = "-(Ljava/lang/String;)Ljava/lang/StringBuilder;"
       $string15 = "Ljava/io/InputStream;"
       $string16 = "vfnnnrof.exnnnroe"
       $string17 = "Olsnnfw"
    condition:
       17 of them
    }
    """.split("\n")
    var cleaned: seq[string]
    var meta = (0,0)
    var strings = (0,0)
    var conditions = (0,0)
    for index, line in x:
        var v = line.strip()
        if v == "meta:":
            meta[0] = index
        elif v == "strings:":
            meta[1] = index-1
            strings[0] = index
        elif v == "condition:":
            strings[1] = index-1
            conditions[0] = index
            conditions[1] = x.len()-3
        cleaned.add(v)
    var meta_items = cleaned[meta[0]..meta[1]]
    var string_items = cleaned[strings[0]..strings[1]]
    var condition_items = cleaned[conditions[0]..conditions[1]]
    echo(meta_items, string_items, condition_items)