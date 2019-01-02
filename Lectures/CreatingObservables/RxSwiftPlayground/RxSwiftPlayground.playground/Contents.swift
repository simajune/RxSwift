//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

example(of: "creating observables") {
  let mostPopular: Observable<String> = Observable<String>.just(episodeV)
  let originalTrilogy = Observable.of(episodeIV, episodeV, episodeVI)
//  let prequelTrilogy = Observable.of([episodeI, episodeII, episodeIII])
//  let sequelTrilogy = Observable.from([episodeVII, episodeVIII, episodeIX])
}

example(of: "subscribe") {
  // 1
  let one = 1
  let two = 2
  let three = 3
  
  //2
//  let observable:Observable<Int> = Observable<Int>.just(one)
  let observable = Observable<Int>.of(one, two, three)
  
  observable.subscribe( onNext: { event in
    print(event)
  })
}

example(of: "empty") {
  let observable = Observable<Void>.empty()
  
  observable
    .subscribe(
      onNext: { event in
      print(event)
    },
      onCompleted: {
      print("completed")
    }
  )
}

example(of: "range") {
  // 1
  let observable = Observable<Int>.range(start: 1, count: 10)
  observable
    .subscribe(onNext: { i in
      // 2
      print(i)
      let n = Double(i)
      let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
        2.23606).rounded())
      print(fibonacci)
    }
  )
}

example(of: "never") {
  let observable = Observable<Any>.never()
  observable
    .subscribe(
      onNext: { element in
        print(element)
    },
      onCompleted: {
        print("Completed")
    }
  )
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
