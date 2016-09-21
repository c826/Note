//: Playground - noun: a place where people can play

import UIKit

//: ##Sequence

//先定义一个实现了GeneratorType Protocol的类型
//GeneratorType 需要制定一个 typealias Element
//以及提供一个返回Element?的方法 next()

class ReverseGenerator<T>:GeneratorType{
    typealias Element = T
    
    var array : [Element]
    var currentIndex = 0
    
    init(array : [Element]){
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0{
            return nil
        }else{
            let  element = array[currentIndex]
            currentIndex -= 1
            return element
        }
        
    }
    
}

//然后我们来定义SequenceType
//和GeneratorType很类似，不过换成指定一个 typealias Generator
//以及提供一个返回Generator？的方法 generate()

struct ReverseSequence<T>:SequenceType {
    var array : [T]
    
    init(array : [T]){
        self.array = array
    }
   
    
    typealias Generate = ReverseGenerator<T>
    
    func generate() -> Generate{
        return ReverseGenerator(array: self.array)
    }
}


let arr = [0,1,2,3,4]
let reverse = ReverseSequence(array : arr)

for i in reverse{
    print(i)
}


// forin 内部实现：

let g = reverse.generate()

while let obj = g.next(){
    /**
     *
     */
    print(obj)
}
