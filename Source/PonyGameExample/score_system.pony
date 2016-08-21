use "ponygame"

class ScoreSystem is GameSystem
  var _game: Game
  var _score: I32
  
  new create(game: Game) =>
    _game = game
    _score = 0

    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("LineCompleteEvent", this)
    true
  
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    true

  fun ref notify(event: GameEvent): None =>
    try
      _on_line_complete(event as LineCompleteEvent)
    end

  fun ref _on_line_complete(event: LineCompleteEvent): None =>
    // Increase score.
    _score = _score + 1

    // Notify listeners.
    let score_changed_event = ScoreChangedEvent(_score)
    _game.event_manager().push(score_changed_event)

    _game.logger().log("Score increased to " + _score.string() + ".")