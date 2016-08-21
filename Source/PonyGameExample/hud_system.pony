use "ponygame"

class HudSystem is GameSystem
  var _game: Game
  var _text_format_id: I32
  var _score: I32
  

  new create(game: Game) =>
    _game = game
    _text_format_id = 0
    _score = 0

    
  fun ref init(): Bool =>
    // Load font.
    _text_format_id = _game.resource_manager().load_text_format("Verdana", 16, HorizontalAlignmentLeft, VerticalAlignmentLeft)

    // Register listeners.
    _game.event_manager().add_listener("ScoreChangedEvent", this)
    true
    
  fun ref start(): Bool =>
    true
    
  fun ref update(): Bool =>
    true
   
  fun draw(): None =>
    var y: F32 = 10.0
    var line_height: F32 = 20.0

    // Show elapsed time.
    let elapsed_millis = _game.clock().elapsed_millis()
    let elapsed_seconds = elapsed_millis / 1000
    let time_string = "Time: " + elapsed_seconds.string() + "." + (elapsed_millis % 1000).string()
    
    _game.renderer().draw_text(time_string, 10.0, y, _text_format_id, 1.0, 1.0, 1.0, 1.0)
    y = y + line_height

    // Show FPS.
    let fps_string = "FPS: " + _game.fps_counter().fps().string()
    _game.renderer().draw_text(fps_string, 10.0, y, _text_format_id, 1.0, 1.0, 1.0, 1.0)
    y = y + line_height

    let frame_time_string = "Frame Time: " + _game.fps_counter().frame_time().string() + " ms"
    _game.renderer().draw_text(frame_time_string, 10.0, y, _text_format_id, 1.0, 1.0, 1.0, 1.0)
    y = y + line_height

    // Show score.
    let score_string = "Score: " + _score.string()
    _game.renderer().draw_text(score_string, 10.0, y, _text_format_id, 1.0, 1.0, 1.0, 1.0)

  fun ref notify(event: GameEvent): None =>
    try
      _on_score_changed(event as ScoreChangedEvent)
    end

  fun ref _on_score_changed(event: ScoreChangedEvent): None =>
    _score = event.score