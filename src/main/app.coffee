main = require("../main/main").main

consoleWriter = (text) -> console.log(text)

main(consoleWriter).printHello()