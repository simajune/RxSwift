# Taking Operator

### Taking Operator

* Taking Operator는 이전에 배운 skip operator와 반대라고 보면 된다. 

#### 1. Take

* 아래의 표를 한번 봐보자

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch5-3/1.png?raw=true" width="800px"/>

* 표를 보면 take에 써진 매개변수까지 값을 받는다는 뜻인거 같다.
* 코드를 통해 알아보자

```swift
exampleOf(description: "Take") {
  let disposeBag = DisposeBag()
  // 1
  Observable.of(1, 2, 3, 4, 5, 6)
    // 2
    .take(3)
    .subscribe(onNext: {
      print($0)
    })
    .addDisposableTo(disposeBag)
}
-----------------------------------------
--- Example of: Take ---
1
2
3
```

* 위의 코드를 보면 Observable은 총 6개의 이벤트를 가지고 있다.하지만 take라는 operator를 이용한 것이다. take에 사용된 매개변수를 통해 처음의 이벤트에서 매개변수에 적힌 수만큼 이벤트를 받는다.

#### 2. takeWhilWithIndex

* takeWhileWithindex는 방출할 때 이벤트의 요소뿐만 아니라 요소의 index값을 참조하고 싶을 때 사용하는 것이다.
* 아래 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch5-3/2.png?raw=true" width="800px"/>

* 위의 그림을 보면 클로저를 통해 두가지를 받을 수 있다. 하나는 이벤트이고 나머지는 이 이벤트에 대한 index 값을 받는 것이다. 이것을 이용해 조건을 만들고 그 조건에 들어야만 이벤트를 받을 수 있다.
* 코드를 통해 알아보자.
