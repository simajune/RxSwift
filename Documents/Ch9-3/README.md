# Combining elements

* CombineLatest의 계열은 RxSwift의 필수적인 연산자 그룹이다.



#### 1. CombineLatest

* 마블을 보면서 알아보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-3/1.png?raw=true" width="800px"/>

* 위에 그림을 코드로 구현해 보자.

```swift
exampleOf(description: "CombineLatest") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    let observable = Observable.combineLatest(left, right, resultSelector: { lastLeft , lastRight in
        "\(lastLeft) \(lastRight)"
    })
    
    let disposable = observable
        .subscribe(onNext: { value in
            print(value)
        })
    
    print("> Sending a value to left")
    left.onNext("Hello")
    print("> Sending a value to right")
    right.onNext("world")
    print("> Sending another value to right")
    right.onNext("RxSwift")
    print("> Sending another value to left")
    left.onNext("Have a good day,")
    
    disposable.dispose()
}
-----------------------------------------
--- Example of: CombineLatest ---
> Sending a value to left
> Sending a value to right
Hello world
> Sending another value to right
Hello RxSwift
> Sending another value to left
Have a good day, RxSwift
```

* 위의 코드는 combineLatest 연산자가 어떤지 알아보았다. 그림에서 보는 듯이 combineLatest가 동작을 하려면 처음에 무조건 두개의 요소가 발생해야 combineLatest 연산자가 발생한다.
* 처음에 left의 이벤트가 발생했지만 그 이벤트에 대한 CombineLatest의 연산자가 동작하진 않고 그 다음 right의 이벤트가 발생하자 "Hello wolrd"라는 문자열이 출력 됐다.
* 그리고 그 다음 이벤트에 대해서는 둘다 값을 가지고 있기 때문에 combineLatest의 연산자의 이벤트가 발생한다.

* 이것은 대개 filter 연산자와 같이 많이 사용된다.
* 

```swift
exampleOf(description: "Merge1") {
™    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    var disposeBag = DisposeBag()
    
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]
 
    Observable.merge(left.asObservable(), right.asObservable())
        .subscribe(onNext: { value in
        print(value)
        })
        .disposed(by: disposeBag)
    repeat {
        if(arc4random_uniform(2) == 0){
            if(!leftValues.isEmpty){
                left.onNext("Left: " + leftValues.removeFirst())
            }
        }else{
            if(!rightValues.isEmpty){
                right.onNext("Right: " + rightValues.removeFirst())
            }
        }
    }while (!leftValues.isEmpty || rightValues.isEmpty)
}
-----------------------------------------
--- Example of: Merge1 ---
Right: Madrid
Right: Barcelona
Right: Valencia
Left: Berlin
Left: Munich
Left: Frankfurt
```

* 막상 고쳐봤는데 크게 라인이 줄진 않았다. 최대한 변수의 생성을 줄여서 고쳐보았다.
* 이것을 보면 우리가 배운 queue의 개념을 생각하면 될 것같다. 먼저 이벤트 발생한 것이 실행된다.

#### 2. Zip

* 바로 마블을 보기로 하자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-3/2.png?raw=true" width="800px"/>

```swift

```

