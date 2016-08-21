use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)

use @BeginDraw[Bool]()
use @EndDraw[Bool]()

use @RenderText[None](text: Pointer[U8] tag, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32)
use @RenderImage[None](image_id: I32, x: F32, y: F32)

use @Uninitialize[None]()


class Renderer
  var _initialized: Bool
  var _can_draw: Bool

  new create() =>
    _initialized = false
    _can_draw = false

  fun ref init(game_name: String, width: I32, height: I32): Bool =>
    if @Initialize(game_name.cstring(), width, height) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      _initialized = true
    end
    
    _initialized

  fun ref begin_draw(): Bool =>
    _can_draw = @BeginDraw()
    _can_draw

  fun ref end_draw(): Bool =>
    var result = @EndDraw()
    _can_draw = false
    result
    
  fun draw_text(text: String, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32): None =>
    if _can_draw then
      @RenderText[None](text.cstring(), x, y, text_format_id, red, green, blue, alpha)
    end
  
  fun draw_image(image_id: I32, x: F32, y: F32): None =>
    if _can_draw then
      @RenderImage[None](image_id, x, y)
    end
    
  fun ref shutdown(): None =>
    _can_draw = false
    @Uninitialize()