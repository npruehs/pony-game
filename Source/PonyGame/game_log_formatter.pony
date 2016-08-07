class val GameLogFormatter
  let _clock: GameClock
  
  new val create(clock: GameClock) =>
    _clock = clock
    
  fun apply(msg: String, loc: SourceLoc): String =>
    let elapsed_millis: String = _clock.elapsed_millis().string()
    let file_name: String = loc.file()
    let file_linenum: String  = loc.line().string()
    let file_linepos: String  = loc.pos().string()

    let output = recover String(elapsed_millis.size() + 3
    + file_name.size() + 1
    + file_linenum.size() + 1
    + file_linepos.size() + 2
    + msg.size()
    ) end

    output.append("[")
    output.append(elapsed_millis)
    output.append("] ")
    output.append(file_name)
    output.append(":")
    output.append(file_linenum)
    output.append(":")
    output.append(file_linepos)
    output.append(": ")
    output.append(msg)
    output
