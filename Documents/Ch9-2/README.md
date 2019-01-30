# Merge

* combine 시퀀스 중에 가장 쉽게 사용할 수 있는 것이 바로 merge이다. 
* 마블을 보면서 알아보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-2/1.png?raw=true" width="800px"/>

* 위에 그림을 코드로 구현해 보자.

```swift
exampleOf(description: "merge") {
    let left = PublishSubject<String>()
    let right = PublishSubject<String>()
    
    let source = Observable.of(left.asObservable(), right.asObservable())
    
    let observable = source.merge()
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    var rightValues = ["Madrid", "Barcelona", "Valencia"]
    repeat {
        if arc4random_uniform(2) == 0 {
            if (!leftValues.isEmpty){
                left.onNext("left: " + leftValues.removeFirst())
            }
        }else if(!rightValues.isEmpty){
            right.onNext("right: " + rightValues.removeFirst())
        }
    }while !leftValues.isEmpty || !rightValues.isEmpty
    disposable.dispose()
}
-----------------------------------------
--- Example of: merge ---
left: Berlin
right: Madrid
left: Munich
right: Barcelona
left: Frankfurt
right: Valencia
```

* 위의 코드는 merge 연산자를 통해 두개의 Observable을 합치는 걸 연습해 보았다. 두개의 Observable은 next 이벤트가 발생할 때마다 그 요소를 출력하는 것이고 left와 right를 merge한 것이다. 그래서 그냥 간단히 일어나는 쪽의 Observable의 이벤트를 발생한다는 것이다. 
* 여기서 주의 할 점은 두 개이 이상의 Observable의 타입은 같아야 한다. 여기에서는 요소를 String으로 가졌기 때문에 다른 Observable의 요소도 String을 가져야한다는 것이다.
* 그리고 dispose되는 것은 두개의 Observable이 completed되야 merge된 Observable도 completed된다.
* 이것을 하면서 그냥 좀 더 짧게 할 방법이 없을까하다가 내 나름대로 코드를 줄여보았다.

```swift
exampleOf(description: "Merge1") {
    let left = PublishSubject<String>()
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
