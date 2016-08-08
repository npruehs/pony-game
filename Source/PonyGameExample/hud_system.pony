use "ponygame"

class HudSystem is GameSystem
  var _game: Game
  var _text_format_id: I32
  
  
  new create(game: Game) =>
    _game = game
    _text_format_id = 0
    
    
  fun ref init(): Bool =>
    _text_format_id = _game.resource_manager().get_text_format("Verdana", 16, HorizontalAlignmentLeft, VerticalAlignmentLeft)
    true
    
  fun ref update(): Bool =>
    true
   
  fun draw(): None =>
    // Show elapsed time.
    let elapsed_millis = _game.clock().elapsed_millis()
    let elapsed_seconds = elapsed_millis / 1000
    let time_string = "Time: " + elapsed_seconds.string() + "." + (elapsed_millis % 1000).string()
    
    _game.renderer().draw_text(time_string, 10.0, 10.0, _text_format_id, 1.0, 1.0, 1.0, 1.0)
    
    // Show FPS.
    let fps_string = "FPS: " + _game.fps_counter().fps().string()
    _game.renderer().draw_text(fps_string, 10.0, 30.0, _text_format_id, 1.0, 1.0, 1.0, 1.0)
    
    let frame_time_string = "Frame Time: " + _game.fps_counter().frame_time().string() + " ms"
    _game.renderer().draw_text(frame_time_string, 10.0, 50.0, _text_format_id, 1.0, 1.0, 1.0, 1.0)