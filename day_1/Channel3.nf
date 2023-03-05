#!/usr/bin/env nextflow


// Channel value

ch1 = Channel.value( 'Hello there' )  
ch2 = Channel.value( [1,2,3,4,5] )
valueChannel = Channel.value(42)

ch1.view()
ch2.view()
valueChannel.view()

// Channel of 

ch = Channel.of( 1, 3, 5, 7 ) 
ch.view{ "value: $it" }
ch.view("value: $it") This notation is incorrect.


/// Channel fromList

list = ['hello', 'world'] 
Channel 
  .fromList(list) 
  .view()

Channel 
    .fromList( ['a', 'b', 'c', 'd'] ) 
    .view { "value: $it" }


