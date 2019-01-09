//: Please build the scheme 'RxSwiftPlayground' first
import RxSwift

// 1
enum MyError: Error {
  case anError
}
// 3
example(of: "BehaviorSubject") {
  // 4
  let subject = BehaviorSubject(value: "initial Event")
  let disposeBag = DisposeBag()

  let initialSubscription = subject.subscribe(onNext: {
    print("Line number is \(#line) and value is", $0)
  })
  
  
  
  subject.onNext("second Event")
  
  let secondSubscription  = subject.subscribe(onNext: {
    print("Line number is \(#line) and value is", $0)
  })
  
  subject.onCompleted()
  
  subject.subscribe({ event in
    print("Line number is \(#line) and value is", event)
  })
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
