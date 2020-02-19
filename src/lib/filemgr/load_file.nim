import streams

proc load_file*(filepath: string): FileStream =
    return newFileStream(filepath, fmRead)