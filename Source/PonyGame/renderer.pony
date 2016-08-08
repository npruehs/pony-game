use @Initialize[Bool](game_name: Pointer[U8] tag, width: I32, height: I32)
use @SetClearColor[None](red: F32, green: F32, blue: F32, alpha: F32)

use @BeginDraw[Bool]()
use @EndDraw[Bool]()

use @RenderText[None](text: Pointer[U8] tag, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32)
use @RenderImage[None](image_id: I32, x: F32, y: F32)

use @Uninitialize[None]()


class Renderer
  var _initialized: Bool
  
  new create() =>
    _initialized = false
    
  fun ref init(game_name: String, width: I32, height: I32): Bool =>
    if @Initialize(game_name.cstring(), width, height) then
      @SetClearColor(0.0, 0.0, 0.0, 1.0)
      _initialized = true
    end
    
    _initialized

  fun begin_draw(): Bool =>
    @BeginDraw()
    
  fun end_draw(): Bool =>
    @EndDraw()
  
  fun draw_text(text: String, x: F32, y: F32, text_format_id: I32, red: F32, green: F32, blue: F32, alpha: F32): None =>
    @RenderText[None](text.cstring(), x, y, text_format_id, red, green, blue, alpha)
  
  fun draw_image(image_id: I32, x: F32, y: F32): None =>
    @RenderImage[None](image_id, x, y)
    
  fun shutdown(): None =>
    @Uninitialize()