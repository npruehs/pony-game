use "collections"

use "ponygame"

class BlockRenderSystem is (GameSystem & EventListener)
  let _tile_size: F32 = 32.0

  var _game: Game
  var _blocks: List[U64]
  

  new create(game: Game) =>
    _game = game
    _blocks = List[U64]

    
  fun ref init(): Bool =>
    // Register listeners.
    _game.event_manager().add_listener("BlockSpawnedEvent", this)
    true
  
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    true
    
  fun draw(): None =>
    // Draw all blocks.
    for block in _blocks.values() do
      try
        let image_component = _game.entity_manager().get_component[ImageComponent](block, "ImageComponent")
        let image = _game.resource_manager().get_image(image_component.image)

        let position_component = _game.entity_manager().get_component[PositionComponent](block, "PositionComponent")
        let x = position_component.x
        let y = position_component.y

        _game.renderer().draw_image(image, F32.from[I32](x) * _tile_size, F32.from[I32](y) * _tile_size)
      end
    end

  fun ref notify(event: GameEvent): None =>
    try
      _on_block_spawned(event as BlockSpawnedEvent)
    end

  fun ref _on_block_spawned(event: BlockSpawnedEvent): None =>
    try
      let block = event.entity

      // Pre-load image.
      let image_component = _game.entity_manager().get_component[ImageComponent](block, "ImageComponent")
      _game.resource_manager().load_image(image_component.image)

      // Add block.
      _blocks.push(block)
    end
