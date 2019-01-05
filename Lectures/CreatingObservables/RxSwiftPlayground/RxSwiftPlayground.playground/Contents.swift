//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

//example(of: "creating observables") {
//  let mostPopular: Observable<String> = Observable<String>.just(episodeV)
//  let originalTrilogy = Observable.of(episodeIV, episodeV, episodeVI)
////  let prequelTrilogy = Observable.of([episodeI, episodeII, episodeIII])
////  let sequelTrilogy = Observable.from([episodeVII, episodeVIII, episodeIX])
//}

example(of: "never") {
  let disposeBag = DisposeBag()

  let observable = Observable<Void>.never()

  observable.do(onSubscribe: { print("on Subscribe")},
                onSubscribed: { print("on Subscribed")},
                onDispose: { print("on Dispose")}
  )
    .subscribe(onNext: { (element) in
      print(element)
    }, onCompleted: {
      print("on Completed")
    })
  .disposed(by: disposeBag)
}

example(of: "never1") {
  let observable = Observable<Any>.never()
  
  // 1. 문제에서 요구한 dispose bag 생성
  let disposeBag = DisposeBag()
  
  // 2. 그냥 뚫고 지나간다는 do의 onSubscribe 에다가 구독했음을 표시하는 문구를 프린트하도록 함
  observable.do(
    onSubscribe: { print("Subscribed")}
    ).subscribe(          // 3. 그리고 subscribe 함
      onNext: { (element) in
        print(element)
    },
      onCompleted: {
        print("Completed")
    }
    )
    .disposed(by: disposeBag)      // 4. 앞서 만든 쓰레기봉지에 버려줌
}

example(of: "debug") {
  let observable = Observable<Any>.never()
  let disposeBag = DisposeBag()
  
  observable
    .debug("debug 확인")
    .subscribe()
    .disposed(by: disposeBag)
}

example(of: "create") {
  let disposeBag = DisposeBag()
  
  enum myError: Error {
    case anError
  }
  
  Observable<String>.create { observer in
    // 1
    observer.onNext("1")
    // 2
    observer.onError(myError.anError)
    observer.onCompleted()
    // 3
    observer.onNext("?")
    // 4
    return Disposables.create()
  }
    .subscribe(
      onNext: { print($0) },
      onError: { print($0) },
      onCompleted: { print("Completed") },
      onDisposed: { print("Disposed") }
    )
    .addDisposableTo(disposeBag)
}

example(of: "deferred") {
  let disposeBag = DisposeBag()
  // 1
  var flip = false
  // 2
  let factory: Observable<Int> = Observable.deferred {
    // 3
    flip = !flip
    // 4
    if flip {
      return Observable.of(1, 2, 3)
    } else {
      return Observable.of(4, 5, 6)
    }
  }
  
  for _ in 0...3 {
    factory.subscribe(onNext: {
      print($0, terminator: "")
    })
      .addDisposableTo(disposeBag)
    print()
  }
  
}



/*:
 Copyright (c) 2014-2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
