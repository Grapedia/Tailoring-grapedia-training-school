//1 - Output Stdout
process sayHello {
    
    output:
    stdout

    """
    echo Grapedia Training School
    """
}

workflow {
    sayHello | view { "Welcome to the ... $it" }
}

