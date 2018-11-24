//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import PlaygroundSupport

//XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
PlaygroundPage.current.needsIndefiniteExecution = true


import RxSwift

//public func exampleOf(description: String, action: () -> Void) {
//    print("\n--- Example of:", description, "---")
//    action()
//}

exampleOf(description: "just") {
    let observable = Observable.just("Hello, World!!")
    
    observable.subscribe { (event: Event<String> ) in
        print(event)
    }
    
    observable.subscribe { (event: Event<String> ) in
        print(event)
    }
}


exampleOf(description: "of" ) {
    let observable = Observable.of(1,2,3)

    observable.subscribe {
        print($0)
    }

    observable.subscribe {
        print($0)
    }
}

exampleOf(description: "toObservable") {
    let disposeBag = DisposeBag()

    let observable = Observable.of(1, 2, 3)

    let subscription: Disposable = observable.subscribe(onNext: {
        print($0)
    }, onError: nil, onCompleted: nil, onDisposed: nil)

    subscription.disposed(by: disposeBag)

}

exampleOf(description: "toObservable") {
    let disposeBag = DisposeBag()

    let observable = Observable.of(1, 2, 3)

    observable.subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

//    subscription.disposed(by: disposeBag)
    let observable2 = Observable.of(4, 5, 6)

    observable.subscribe(onCompleted: {
        print("Complete")
    }).disposed(by: disposeBag)
//    subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposeBag)
}


exampleOf(description: "error") {
    enum error: Error {
        case Test
    }

    Observable<Int>.error(error.Test).subscribe {
        print($0)
    }
}
