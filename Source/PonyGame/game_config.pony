use "collections"
use "files"
use "ini"

class GameConfig
  let _env: Env
  
  var _config: Map[String, String]
  
  
  new create(env: Env) =>
    _env = env
    _config = Map[String, String]

  fun ref parse(file_path: String) =>
    try
      // Open ini file.
      let ini_file = File(FilePath(_env.root as AmbientAuth, file_path))
      
      // Parse ini file.
      let sections = IniParse(ini_file.lines())

      // Flatten ini file into single map.
      for section in sections.keys() do
        for key in sections(section).keys() do
          _config.insert(key, sections(section)(key))
        end
      end
    end
    
   fun apply(key: String): String =>
     try
       _config(key)
     else
       ""
     end
