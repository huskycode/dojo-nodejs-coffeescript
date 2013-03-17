main = (writer) -> { 
  hello:() -> "Hello World!"
  printHello:() -> writer(@hello())
}

exports.main = main