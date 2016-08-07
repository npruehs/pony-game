use "collections"

use @LoadImageResource[I32](file_name: Pointer[U8] tag)
use @CreateTextFormat[I32](font_name: Pointer[U8] tag, fontSize: F32, textAlignment: I32, paragraphAlignment: I32)

class ResourceManager
  let _images: Map[String, I32]
  let _text_formats: Map[TextFormat, I32]
  
  
  new create() =>
    _images = Map[String, I32]
    _text_formats = Map[TextFormat, I32]
    
    
  fun ref get_image(image: String): I32 =>
    try
      _images(image)
    else
      var image_id: I32 = @LoadImageResource(image.cstring())
      _images(image) = image_id
      image_id
    end

  fun ref get_text_format(font_name: String, font_size: F32, horizontal_alignment: HorizontalAlignment, vertical_alignment: VerticalAlignment): I32 =>
    let text_format = TextFormat(font_name, font_size, horizontal_alignment, vertical_alignment)
    
    try
      _text_formats(text_format)
    else
      var text_format_id: I32 = @CreateTextFormat(font_name.cstring(), font_size, horizontal_alignment(), vertical_alignment())
      _text_formats(text_format) = text_format_id
      text_format_id
    end
