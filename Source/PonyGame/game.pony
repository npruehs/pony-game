use "collections"
use "files"
use "logger"

class Game
  let _env: Env
  
  let _clock: GameClock val
  
  var _config: GameConfig
  var _logger: Logger[String]
  var _fps_counter: FpsCounter
  var _frame: U64
  var _renderer: Renderer
  var _resource_manager: ResourceManager
  var _input: Input
  var _entity_manager: EntityManager
  var _event_manager: EventManager

  var _systems: List[GameSystem]
  var _running: Bool

  
  new create(env: Env) =>
    _env = env
    
    _config = GameConfig(env)
    _logger = StringLogger(Fine, env.out)
    _clock = GameClock
    _fps_counter = FpsCounter(_clock)
    _frame = 0
    _renderer = Renderer
    _resource_manager = ResourceManager
    _input = Input
    _entity_manager = EntityManager
    _event_manager = EventManager

    _systems = List[GameSystem]
    _running = false
    

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
    let game_log_formatter: GameLogFormatter val = GameLogFormatter(_clock)
    try
      // Create log file.
      let file_path = FilePath(_env.root as AmbientAuth, "ponygame.log")
      let file = recover File(file_path) end
      let file_stream = FileStream(consume file)

      _logger = StringLogger(log_level, file_stream, game_log_formatter)
    else
      // Write log to console.
      _env.out.print("Unable to open log file, logging to terminal.")
       _logger = StringLogger(log_level, _env.out, game_log_formatter)
    end
    
    _logger.log("Log Level: " + config_log_level)

    // Initialize renderer.
    var game_name: String = "PonyGame"
    var window_width: I32 = 1024 
    var window_height: I32 = 768 
    
    var config_game_name = _config("GameName")
      
    if config_game_name != "" then
      game_name = config_game_name
    end
    
    try
      var config_window_width = _config("WindowWidth").i32()
      
      if config_window_width > 0 then
        window_width = config_window_width
      end
    end
    
    try
      var config_window_height = _config("WindowHeight").i32()
      
      if config_window_height > 0 then
        window_height = config_window_height
      end
    end
    
    if not _renderer.init(game_name, window_width, window_height) then
      false
    end
    
    // Initialize all systems.
    for system in _systems.values() do
      if not system.init() then
        false
      end
    end 
    
    true
    
  fun ref add_system(system: GameSystem): None =>
    _systems.push(system)
    
  fun ref tick(): Bool =>
    _frame = _frame + 1
    _fps_counter.tick()
    
    var success: Bool = _update()
    
    if success then
      success = _draw()
    end
    
    if success then
      true
    else
      _shutdown()
      false
    end
    
  fun config(): this->GameConfig =>
    _config
    
  fun logger(): this->Logger[String] =>
    _logger
    
  fun clock(): this->GameClock =>
    _clock
    
  fun fps_counter(): this->FpsCounter => 
    _fps_counter
    
  fun resource_manager(): this->ResourceManager =>
    _resource_manager
  
  fun renderer(): this->Renderer =>
    _renderer
  
  fun input(): this->Input =>
    _input
    
  fun frame(): U64 =>
    _frame
    
  fun entity_manager(): this->EntityManager =>
    _entity_manager

  fun event_manager(): this->EventManager =>
    _event_manager
    
    
  fun ref _update(): Bool =>
    if not _running then
      // Start all systems.
      for system in _systems.values() do
        if not system.start() then
          false
        end
      end 

      _running = true
    end

    // Poll input.
    _input.tick()

    // Update all systems.
    for system in _systems.values() do
      system.update()
    end 

    // Handle events.
    _event_manager.process()

    // Clean up entities.
    _entity_manager.cleanup()
    
    true
    
  fun ref _draw(): Bool =>
    var success: Bool = _renderer.begin_draw()
    if success then
      for system in _systems.values() do
        system.draw()
      end
      
      success = _renderer.end_draw()
    end        
        
    success
    
  fun ref _shutdown(): None =>
     _renderer.shutdown()