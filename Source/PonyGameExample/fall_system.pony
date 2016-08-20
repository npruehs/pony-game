use "ponygame"

class FallSystem is (GameSystem & EventListener)
  // Duration a block stays at its current position before falling again.
  let _stay_duration_millis: U64 = 500

  var _game: Game
  var _falling_block: U64
  

  new create(game: Game) =>
    _game = game
    _falling_block = 0

    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("BlockSpawnedEvent", this)
    true
  
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    if (_falling_block <= 0) then
      // No falling block. Early out.
      true
    else
      try
        let fall_component = _game.entity_manager().get_component[FallComponent](_falling_block, "FallComponent")
        
        if fall_component.last_fall_time == 0 then
            // Setup initial timer.
            fall_component.last_fall_time = _game.clock().elapsed_millis()
        end

        if (_game.clock().elapsed_millis() - fall_component.last_fall_time) >= _stay_duration_millis then
          // Fall down.
          let position_component = _game.entity_manager().get_component[PositionComponent](_falling_block, "PositionComponent")
          position_component.y = position_component.y + 1

          // Update timer.
          fall_component.last_fall_time = _game.clock().elapsed_millis()

          // Notify listeners.
          let position_changed_event = PositionChangedEvent(_falling_block)
          _game.event_manager().push(position_changed_event)
        end
      end

      true
    end
    
  fun draw(): None =>
    true

  fun ref notify(event: GameEvent): None =>
    try
      _on_block_spawned(event as BlockSpawnedEvent)
    end

  fun ref _on_block_spawned(event: BlockSpawnedEvent): None =>
    // Start falling.
    _falling_block = event.entity
    _game.logger().log("Falling block set to " + _falling_block.string())