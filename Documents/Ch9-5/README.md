# Switches

* 지금부터 Switching 연산자들에 대해 알아보자. amb 연산자 swichLatest연산자에 대해 알아보자. 

#### 1. Amb

* 마블을 보면서 알아보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-5/1.png?raw=true" width="800px"/>

* 위의 그림을 보면 두개의 시퀀스가 존재한다. 그리고 두개의 시퀀스 중에 먼저 이벤트가 발생한 시퀀스의 이벤트만 받고 나머지 시퀀스는 무시한다.

* 코드로 구현해 보자.

```swift
exampleOf(description: "amb") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    let observable = left.amb(right)
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })

//    right.onNext("right Copenhagen")
    left.onNext("left Lisbon")
    right.onNext("right Copenhagen")
    left.onNext("left London")
    left.onNext("left Madrid")
    right.onNext("right Vienna")
    
    disposable.dispose()
}
-----------------------------------------
--- Example of: amb ---
left Lisbon
left London
left Madrid
```

* 위의 코드는 amb 연산자를 사용한 예제이다. 이벤트는 left에서 먼저 발생을 했다. 그 이후로는 right에서 발생한 이벤트에 대해선 받지 않는다. 그리고 만약 위의 주석을 풀어 right에서 먼저 이벤트가 발생을 하면 right에서 발생하는 이벤트만 받게 된다. 그렇다는 것은 위에 observable을 설정할 때 **left.amb(right)**라고 설정을 했는데 **right.amb(left)**라고 설정해도 같은 의미로 볼 수 있다.



#### 2. switchLatest

* 우리는 종종 중복된 서버에 연결하고 먼저 응답하는 것에 반응을 할 때가 있다. 이때 사용하는 것이 바로 switchLatest 연산자이다.

* 우선 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-5/2.png?raw=true" width="800px"/>

* 다이어그램에 이전에 볼 수 없었던 source라는 Observable 시퀀스가 있다. 이것은 스위치와 같은 개념으로 보면 될거 같다 source를 통해 어떤 시퀀스의 것을 받을지 결정을 하는 연산자이다.
* 코드를 통해 알아보자.

```swift
exampleOf(description: "SwitchLatest") {
    let one = PublishSubject<String>()
    let two = PublishSubject<String>()
    let three = PublishSubject<String>()
    
    let source = PublishSubject<Observable<String>>()
    
    let observable = source.switchLatest()
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    one.onNext("ONE : First Event")
    
    source.onNext(two)
    
    two.onNext("TWO : First Event")
    one.onNext("ONE : Second Event")
    
    source.onNext(three)
    
    three.onNext("THREE First Event")
}
-----------------------------------------
--- Example of: SwitchLatest ---
TWO : First Event
THREE First Event
```

* 코드를 통해 보면 source가 Observale<String>을 가지는 Observable이다. 그래서 source를 통해 어떤 Observable의 이벤틑 받을지 결정을 하고 결정되면 무조건 그 Observable의 이벤트만 받게 되고 또 source가 다른 Observable의 이벤트를 발생하면 그때부터 그 Observable의 이벤트만 받게 된다.
