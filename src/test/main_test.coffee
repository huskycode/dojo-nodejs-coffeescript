expect = require("chai").expect

main = require("../main/main").main

describe "main", () ->    
  it "should return hello world", () -> 
    writer = (text) ->   
    result = main(writer).hello()
    expect(result).to.equal("Hello World!")
  it "should print hello", () ->
    writer = (text) -> expect(text).to.equal("Hello World!")
    main(writer).printHello()