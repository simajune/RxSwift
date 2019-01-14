//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf(description: "PublishSubject") {
  let disposeBag = DisposeBag()
  
  let dealtHand = PublishSubject<[(String, Int)]>()
  
  func deal(_ cardCount: UInt) {
    var deck = cards
    var cardsRemaining: UInt32 = 52
    var hand = [(String, Int)]()
    
    for _ in 0..<cardCount {
      let randomIndex = Int(arc4random_uniform(cardsRemaining))
      hand.append(deck[randomIndex])
      deck.remove(at: randomIndex)
      cardsRemaining -= 1
    }
    // Add code to update dealtHand here
    if(points(for: hand) <= 21){
      dealtHand.onNext(hand)
    }else{
      dealtHand.onError(HandError.busted)
    }
  }
  
  // Add subscription to dealtHand here
  dealtHand.subscribe(onNext: { element in
    print(element)
  }, onError: { error in
    print(error)
  }).disposed(by: disposeBag)
  
  deal(3)
}

//
//exampleOf(description: "PublishSubject") {
//  let subject = PublishSubject<String>()
//
//  let subscriptionOne = subject.subscribe( onNext: { string in
//    print(string)
//  })
//  subject.onNext("1")
//  let subscriptionTwo = subject.subscribe{ event in
//    print("2)", event.element ?? event)
//  }
//  subject.onNext("3")
//  subscriptionOne.dispose()
//  subject.onNext("4")
//  subject.onCompleted()
//  subject.onNext("5")
//  subscriptionTwo.dispose()
//  let disposeBag = DisposeBag()
//
//  subject.subscribe{ event in
//    print("3)", event.element ?? event)
//  }.disposed(by: disposeBag)
//
//  subject.onNext("?")
//}
//
//// 1
//enum MyError: Error {
//  case anError
//}
//// 2
//func SubjectPrint<T: CustomStringConvertible>(label: String, event: Event<T>) {
////  print(label, event.element ?? event.error ?? event)
//}
//// 3
//exampleOf(description: "BehaviorSubject") {
//  // 4
//  let subject = BehaviorSubject(value: "Initial value")
//  let disposeBag = DisposeBag()
//
//  subject
//    .subscribe {
//
//    }
//    .addDisposableTo(disposeBag)
//}

//exampleOf(description: "BehaviorSubject") {
//    let subject = BehaviorSubject(value: "a")
//
//    let firstSubscription = subject.subscribe {
//        print(#line, $0)
//    }
//
//    subject.onNext("b")
//
//    let secondSubscription = subject.subscribe {
//        print(#line, $0)
//    }
//}

//exampleOf(description: "ReplaySubject") {
//    let subject = ReplaySubject<Int>.create(bufferSize: 2)
//
//    subject.onNext(1)
//    subject.onNext(2)
//    subject.onNext(3)
//    subject.onNext(4)
//
//    subject.subscribe(onNext: {
//      print($0)
//    })
//}
//
//exampleOf(description: "Variable") {
//    let disposeBag = DisposeBag()
//    let variable = Variable("A")
//
//    variable.asObservable().subscribe(onNext: { print($0) }).addDisposableTo(disposeBag)
//
//    variable.value = "B"
//}
