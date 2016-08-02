use "logger"

class Game
  let _logger: Logger[String]
  
  new create(env: Env) =>
    _logger = StringLogger(Fine, env.out)

  fun init() =>
    _logger(Fine) and _logger.log("Initializing game.")
