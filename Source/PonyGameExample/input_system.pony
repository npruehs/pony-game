use "ponygame"

class InputSystem is GameSystem
  var _game: Game
  var _falling_block: U64
  var _grid_width: I32


  new create(game: Game) =>
    _game = game
    _falling_block = 0
    _grid_width = 0


  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("GridInitializedEvent", this)
    _game.event_manager().add_listener("BlockSpawnedEvent", this)
    true
    
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    try
      let position_component = _game.entity_manager().get_component[PositionComponent](_falling_block, "PositionComponent")
      let grid_component = _game.entity_manager().get_component[GridComponent](_falling_block, "GridComponent")

      // Handle input.
      if (position_component.x > 0) and (_game.input().dpad_left_just_pressed(0)) then
        // Move left.
        position_component.x = position_component.x - 1

        // Notify listeners.
        let position_changed_event = PositionChangedEvent(_falling_block,
          position_component.x + 1,
          position_component.y,
          position_component.x,
          position_component.y)
        _game.event_manager().push(position_changed_event)
      elseif ((position_component.x + grid_component.width().i32()) < _grid_width) and (_game.input().dpad_right_just_pressed(0)) then
        // Move right.
        position_component.x = position_component.x + 1

        // Notify listeners.
        let position_changed_event = PositionChangedEvent(_falling_block,
          position_component.x - 1,
          position_component.y,
          position_component.x,
          position_component.y)
        _game.event_manager().push(position_changed_event)
      end
    end

    true

  fun draw(): None =>
    true

  fun ref notify(event: GameEvent): None =>
    try
      _on_grid_initialized(event as GridInitializedEvent)
      true
    end
    try
      _on_block_spawned(event as BlockSpawnedEvent)
      true
    end

  fun ref _on_grid_initialized(event: GridInitializedEvent): None =>
    // Remember grid width.
    _grid_width = event.width

  fun ref _on_block_spawned(event: BlockSpawnedEvent): None =>
    // Tie to input.
    _falling_block = event.entity