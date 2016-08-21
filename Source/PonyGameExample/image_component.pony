use "ponygame"

class ImageComponent is EntityComponent
  var image: String
  
  
  new create(image': String) =>
    image = image'
    
    
  fun component_type(): String =>
    "ImageComponent"