//: Please build the scheme 'RxSwiftPlayground' first
import XCPlayground
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true


exampleOf(description: "distinctUntilChanged") {
  let disposeBag = DisposeBag()
  // 1
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  // 2
  Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
    // 3
    .distinctUntilChanged { a, b in
      // 4
      guard let aWords = formatter.string(from: a)?.components(separatedBy: " "),
        let bWords = formatter.string(from: b)?.components(separatedBy: " ")
          else {
          return false
      }
      var containsMatch = false
      // 5
      
//      print(aWords)
//      print(bWords)
      for aWord in aWords {
        for bWord in bWords {
          if aWord == bWord {
            containsMatch = true
            break
          }
        }
      }
      return containsMatch
    }
    // 4
    .subscribe(onNext: {
      print($0)
    })
    .addDisposableTo(disposeBag)
      
}


//example(of: "toArray") {
//  let disposeBag = DisposeBag()
//  // 1
//  Observable.of("A", "B", "C")
//    // 2
//    .toArray()
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//}

//exampleOf(description: "TakeUntil") {
//  let disposeBag = DisposeBag()
//  // 1
//  let subject = PublishSubject<String>()
//  let trigger = PublishSubject<String>()
//  // 2
//  subject
//    .takeUntil(trigger)
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//  // 3
//  subject.onNext("1")
//  subject.onNext("2")
//}

//exampleOf(description: "") {
//  let disposeBag = DisposeBag()
//  // 1
//  let subject = PublishSubject<String>()
//  let trigger = PublishSubject<String>()
//  // 2
//  subject
//    .skipUntil(trigger)
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//
//  subject.onNext("1")
//  subject.onNext("2")
//  subject.onNext("3")
//  subject.onNext("4")
//
//  trigger.onNext("trigger")
//
//  subject.onNext("5")
//}

//exampleOf(description: "IgnoreElements") {
//  // 1
//  let strikes = PublishSubject<String>()
//  let disposeBag = DisposeBag()
//  // 2
//  strikes
//    .ignoreElements()
//    .subscribe { _ in
//      print("You're out!")
//    }
//    .addDisposableTo(disposeBag)
//
//  strikes.onCompleted()
//}


//exampleOf(description: "elementAt") {
//  // 1
//  let strikes = PublishSubject<String>()
//  let disposeBag = DisposeBag()
//  //  2
//  strikes
//    .elementAt(2)
//    .subscribe(onNext: { element in
//      print(element)
//      print("You're out!")
//    })
//    .addDisposableTo(disposeBag)
//
//  strikes.onNext("1")
//  strikes.onNext("2")
//  strikes.onNext("3")
//  strikes.onNext("4")
//  strikes.onNext("5")
//}

//example(of: "filter") {

//exampleOf(description: "filter") {
//  let disposeBag = DisposeBag()
//  // 1
//  Observable.of(1, 2, 3, 4, 5, 6)
//    // 2
//    .filter { int in
//      int % 2 == 0 && int % 3 == 0
//    }
//    // 3
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//}

//exampleOf(description: "skip") {
//  let disposeBag = DisposeBag()
//  // 1
//  Observable.of("A", "B", "C", "D", "E", "F")
//    // 2
//    .skip(3)
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//}

//exampleOf(description: "skipWhile") {
//
//  let disposeBag = DisposeBag()
//  // 1
//  Observable.of(2, 2, 3, 4, 5, 6, 4, 34, 5, 8, 11, 17)
//    // 2
//    .skipWhile { integer in
//      integer % 2 == 0 || integer % 3 == 0
//    }
//    .subscribe(onNext: {
//      print($0)
//    })
//    .addDisposableTo(disposeBag)
//}

//exampleOf(description: "PublishSubject") {
//  let disposeBag = DisposeBag()
//
//  let dealtHand = PublishSubject<[(String, Int)]>()
//
//  func deal(_ cardCount: UInt) {
//    var deck = cards
//    var cardsRemaining: UInt32 = 52
//    var hand = [(String, Int)]()
//
//    for _ in 0..<cardCount {
//      let randomIndex = Int(arc4random_uniform(cardsRemaining))
//      hand.append(deck[randomIndex])
//      deck.remove(at: randomIndex)
//      cardsRemaining -= 1
//    }
//    // Add code to update dealtHand here
//    if(points(for: hand) <= 21){
//      dealtHand.onNext(hand)
//    }else{
//      dealtHand.onError(HandError.busted)
//    }
//  }
//
//  // Add subscription to dealtHand here
//  dealtHand.subscribe(onNext: { element in
//    print(element)
//  }, onError: { error in
//    print(error)
//  }).disposed(by: disposeBag)
//
//  deal(3)
//}

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
