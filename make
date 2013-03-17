# Checks basic nodejs requirements

command -v node >/dev/null 2>&1 || { echo >&2 "node is required but is not installed.  Aborting..."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo >&2 "npm is required but is not installed.  Aborting..."; exit 1; }

# Install coffee-script, shelljs if not exists

if [ ! -d "node_modules/coffee-script" ];
then
   npm install coffee-script
fi
if [ ! -d "node_modules/shelljs" ];
then
   npm install shelljs
fi

# Now run the make
node build/make_bootstrap.js $@