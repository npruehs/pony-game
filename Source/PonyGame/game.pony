use "files"
use "logger"

class Game
  let _env: Env
  
  let _clock: GameClock val
  
  var _config: GameConfig
  var _logger: Logger[String]
  var _fps_counter: FpsCounter

  new create(env: Env) =>
    _env = env
    
    _config = GameConfig(env)
    _logger = StringLogger(Fine, env.out)
    _clock = GameClock
    _fps_counter = FpsCounter(_clock)
    
  fun ref init(): Bool =>
    // Read config.
    _config.parse("ponygame.ini")
    
    // Get log level.
    var log_level: LogLevel = Fine
    var config_log_level: String = _config("LogLevel")
    
    if config_log_level == "Info" then
      log_level = Info
    elseif config_log_level == "Warn" then
      log_level = Warn
    elseif config_log_level == "Error" then
      log_level = Error
    else
      config_log_level = "Fine"
    end
    
    // Initialize logger.
    try
      // Create log file.
      let file_path = FilePath(_env.root as AmbientAuth, "ponygame.log")
      let file = recover File(file_path) end
      let file_stream = FileStream(consume file)

      _logger = StringLogger(log_level, file_stream)
    else
      // Write log to console.
      _env.out.print("Unable to open log file, logging to terminal.")
       _logger = StringLogger(log_level, _env.out)
    end
      _logger.log("Log Level: " + config_log_level)
          
  fun config(): this->GameConfig =>
    _config
    
  fun logger(): this->Logger[String] =>
    _logger
    
  fun clock(): this->GameClock =>
    _clock
    
  fun fps_counter(): this->FpsCounter => 
    _fps_counter