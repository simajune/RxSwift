import XCPlayground
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf(description: "PublishSubject") {
    let subject = PublishSubject<String>()
    
    subject.subscribe{
        print($0)
    }
    
    enum error: Error {
        case Test
    }
    
    subject.on(.next("Hello"))
//    subject.onError(error.Test)
    subject.onNext("World")
    
//    let newSubscription = subject.subscribe {
//        print("New subscription: ", $0)
//    }
    
    let newSubscription = subject.subscribe(onNext: {
        print("New subscription: \($0)")
    })

    subject.onNext("What's up?")
    
    newSubscription.dispose()
    subject.onNext("Still there?")
}


exampleOf(description: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "a")
    
    let firstSubscription = subject.subscribe {
        print(#line, $0)
    }
    
    subject.onNext("b")
    
    let secondSubscription = subject.subscribe {
        print(#line, $0)
    }
}

exampleOf(description: "ReplaySubject") {
    let subject = ReplaySubject<Int>.create(bufferSize: 2)
    
    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)
    
    subject.subscribe(onNext: {
      print($0)
    })
}

exampleOf(description: "Variable") {
    let disposeBag = DisposeBag()
    let variable = Variable("A")
    
    variable.asObservable().subscribe(onNext: { print($0) }).addDisposableTo(disposeBag)
    
    variable.value = "B"
}
