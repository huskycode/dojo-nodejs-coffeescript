Notes
====

TDD
--- 
Fisrst, think about spec, get one test case from spec. (Think: what are the example input and output?)
    
    Spec: 
    [ square(x) ]
    
    Test Case:
    [ square(2) -> 4 ] #Test 1
    [ square(-1) -> 1 ] #Test 2
    
1. Write test name 
2. Put in a comment, describe test case (Given, When, Then)
3. Write code just enough for test to fail
4. Implement Code
5. Run test to pass


* Make sure your test can fail for the right reason

Mocking
---

    [App]  ----- [X] -----> [Console.log()]        (Prod.)
    Int.          |            Ext.
                  |
                  --------> [Mock]
                               Collect & test      (Unit Test.)
                               
    main() -> console.log("hello world")
    
    main(writer) -> writer.log("hello world")
    
    writer #1 -> console.log
    writer #2 -> collect, assert
