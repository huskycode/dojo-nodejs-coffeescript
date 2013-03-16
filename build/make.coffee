require 'shelljs/make'
fs = require 'fs'

# Config
config = {
      srcDir: "src"
    , mainDir: "src/main"
    , testDir: "src/test"
    , buildDir: "build"
    , globalReqs: ["supervisor", "mocha", "docco"]
}

# Helpers
isRootInUbuntu = -> exec("whoami", {silent:true}).output == 'root'
needsSudo = -> (process.platform == 'linux')
isEnoughPriv =  -> ( !needsSudo() || isRootInUbuntu() ) 

globalPkgInstallCommand = (pkg, withSudo) -> (if(withSudo) then "sudo " else "") + "npm install #{pkg} -g"

req = (cmd) ->
  w = which cmd
  if not w
    echo "\"#{cmd}\" is required. Please make sure that it is properly installed."
  return w != null

# Targets
target.ensureGlobalReqs = ->
  notInstalled = config.globalReqs.filter( (item) -> not which(item) )
  if(notInstalled.length > 0)
    if(!isEnoughPriv())
      echo("Does not have enough priviledge to install global packages")
      echo("Please run 'sudo ./run ensureGlobalReqs' to install needed global pkgs")
      exit(1)
    notInstalled.forEach( (item) ->
      exec(globalPkgInstallCommand(item, needsSudo()))
    )

target.npmInstall = ->
  exec("npm install")

target.ensureReqs = ->
  target.ensureGlobalReqs()
  target.npmInstall()

target.autotest = ->
  scripts = "
require('shelljs/global');\n 
\n
console.log('\\033[2J\\033[0f'); //Clear Screen\n
console.log('Restarting autotest...');\n
\n
exec('mocha --reporter min --compilers coffee:coffee-script --colors #{config.testDir}/*_test.coffee');\n
  "
  fs.writeFileSync("#{config.buildDir}/autotest.js", scripts)

  exec("nodemon --watch #{config.srcDir} -e js,coffee #{config.buildDir}/autotest.js")

target.test = ->
  exec("mocha --reporter spec --compilers coffee:coffee-script --colors #{config.testDir}/*_test.coffee")

target.all = ->
  target.dev()

target.dev = ->
  target.ensureReqs()
  exec("supervisor -w src -e 'js|coffee' app")
