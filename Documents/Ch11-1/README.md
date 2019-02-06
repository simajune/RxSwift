# Time based Operators

* 시간은 매우 중요하다. Rx 프로그래밍에서의 핵심은 시간이 지남에 따라 비동기 데이터 흐름을 모델링하는 것이다. 
* RxSwift는 시간이 경과하면서 시퀀스가 반응하고 변형되는 방식을 처리할 수 있는 다양한 연산자를 제공한다.

#### 1. reduce

* 마블을 보면서 알아보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-6/1.png?raw=true" width="800px"/>

* 위의 그림을 보면 reduce 연산자는 시퀀스가 completed되야 그때 이벤트가 발생하는 것을 볼 수 있다. 그 내용은 이벤트가 발생했던 값들을 모두 더하는 연산을 한다.

* 코드로 구현해 보자.

```swift
exampleOf(description: "reduce") {
    //1
    let source1 = Observable.of(1, 3, 5, 7, 9)
    let observable1 = source1.reduce(0, accumulator: +)
    let disposable1 = observable1.subscribe(onNext : { value in
        print(value)
    })
    //2
    let one = PublishSubject<Int>()
    let observable2 = one.reduce(0, accumulator: +)
    let disposable2 = observable2.subscribe(onNext: { value in
        print(value)
    })
    one.onNext(2)
    one.onNext(4)
    one.onNext(6)
    one.onNext(8)
    one.onCompleted()
    
    //3
    let source3 = Observable.of(1, 3, 5, 7, 9)
    let observable3 = source3.reduce(0, accumulator: { summary, newValue in
        print("summary: \(summary)")
        print("newValue: \(newValue)")
        return summary + newValue
    })
    let disposable3 = observable3.subscribe(onNext : { value in
        print(value)
    })
}
-----------------------------------------
--- Example of: reduce ---
25
20
summary: 0
newValue: 1
summary: 1
newValue: 3
summary: 4
newValue: 5
summary: 9
newValue: 7
summary: 16
newValue: 9
25
```

* 위의 코드는 reduce 연산자에 대해 알아보았다. 우선 제일 중요한 것 하나는 무조건 구독하고있는 Observable이 completed되어 한다는 것이다. 이 조건이 충족되지 않으면 절대로 값이 방출되지 않는다. 그래서 1, 2, 3번의 경우로 알아보았다.
* 우선 1번의 경우는 예제를 가져다 썼다 1, 3, 5, 7, 9를 가지는 observable이 있고 이 observable은 9까지 값을 방출하고 onCompleted된다. 이것을 reduce 연산자를 통해 observale이 가지고 있는 요소 모두를 더한 값을 방출했다. 
* 2번의 경우는 아무것도 가지고 있지 않은 상태에서 이벤트를 발생시킨 다음 마무리 onCompleted이벤트를 해야만 값이 출력이 되고 onCompleted가 안되면 값은 출력되지 않았다.
* 3번의 경우는 연산 내의 과정을 알아보기 위한 것으로 summary는 이벤트 발생전에 가지고 있던 요소이고 newValue는 현재 발생한 이벤트에 대한 요소이다.



#### 2. scan

* scan 연산자는 switchLatest 연산자와 같지만 이것은 이벤트가 발생할 때마다 이벤트가 발생한다 따라서 이 연산자는 구독되어지는 observable이 onCompleted 되지 않아도 이벤트가 발생할 것이다.

* 우선 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-6/2.png?raw=true" width="800px"/>

* 코드를 통해 알아보자.

```swift
exampleOf(description: "scan") {
    //1
    let source1 = Observable.of(1, 3, 5, 7, 9)
    let observable1 = source1.scan(0, accumulator: +)
    let disposable1 = observable1.subscribe(onNext : { value in
        print(value)
    })
    //2
    let one = PublishSubject<Int>()
    let observable2 = one.scan(0, accumulator: +)
    let disposable2 = observable2.subscribe(onNext: { value in
        print(value)
    })
    one.onNext(2)
    one.onNext(4)
    one.onNext(6)
    one.onNext(8)
}
-----------------------------------------
--- Example of: scan ---
1
4
9
16
25
2
6
12
20
```

* 코드를 통해 출력된 값을 보면 scan 연산자에 대해 알 수 있다. 이벤트가 발생할 때마다 값이 출력되고 이것은 switLatest 연산자는 onCompleted가 되어야만 연산자가 동작했는데 scan 연산자는 onCompleted없어도 연산자가 동작하게 된다.
