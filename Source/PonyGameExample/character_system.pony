use "ponygame"

class CharacterSystem is GameSystem
  var _game: Game
  var _image_id: I32
  var _posX: F32
  var _posY: F32
  
  
  new create(game: Game) =>
    _game = game
    _image_id = 0
    _posX = 0.0
    _posY = 0
    
    
  fun ref init(): Bool =>
    _image_id = _game.resource_manager().load_image("pony.png")

    _posX = 100.0
    _posY = 300.0
    true
    
  fun ref start(): Bool =>
    true

  fun ref update(): Bool =>
    // Handle input.
    if _game.input().dpad_up_pressed(0) then
        _posY = _posY - 1
    end
    if _game.input().dpad_down_pressed(0) then
        _posY = _posY + 1
    end
    if _game.input().dpad_left_pressed(0) then
        _posX = _posX - 1
    end
    if _game.input().dpad_right_pressed(0) then
        _posX = _posX + 1
    end

    _posX = _posX + _game.input().get_left_thumb_x(0)
    _posY = _posY + _game.input().get_left_thumb_y(0)
    
    _posX = _posX + _game.input().get_right_thumb_x(0)
    _posY = _posY + _game.input().get_right_thumb_y(0)
    
    true
    
  fun draw(): None =>
    // Show pony.
    _game.renderer().draw_image(_image_id, _posX, _posY)