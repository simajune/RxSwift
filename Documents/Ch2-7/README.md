# Challenges

### 1. do

- do 연산자는 각각의 이벤트에 대해 컨트롤할 수 있는 연산자이다.
- 만약 never와 같은 것을 볼 때는 구독을 하게 되면 어떠한 이벤트도 발생하지 않지만 **do**연산자를 통해 구독을 할때의 컨트롤을 할 수있게된다.

```swift
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
-------------------------------
--- Example of: never ---
on Subscribe
on Subscribed
on Dispose
```

- 위에 코드를 통해 **do**연산자를 통해 구독을 할 때 구독되었을 때 그리고 dispose했을 때 각각 상태를 출력하게 해놨다. never는 어떠한 이벤트도 발생하지 않지만 이것을 통해 구독을 할 때 그리고 dispose할 때의 콘트롤을 할 수 있다.

### 2. Debug

- **debug**연산자는 말그대로 debug를 하는 것이다. 이벤트가 발생할 때의 정보를 보여준다.

```swift
example(of: "debug") {
  let observable = Observable<Any>.never()
  let disposeBag = DisposeBag()
  
  observable
    .debug("debug 확인")
    .subscribe()
    .disposed(by: disposeBag)
}
--------------------------------------------------------------
--- Example of: debug ---
2019-01-05 18:45:20.712: debug 확인 -> subscribed
2019-01-05 18:45:20.713: debug 확인 -> isDisposed
```

