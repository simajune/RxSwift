# Transforming inner observables

### Transforming inner observable

```swift
struct Student {
    var score: Variable<Int>
}
```

* 위에 코드를 보면 Student라는 구조체 하나를 만들었다. 그 구조체 안에는 Variable<Int>의 score를 가지는다. 
* RxSwift는 flatMap 계열의 연산자를 일부 포함한다.
* 이 연산자를 사용하면 observable에 도달할 수 있고, 이것은 observable의 프로퍼티를 사용한다.
* 일단 이번 챕터는 매우 복잡하다고 한다. 하지만 필수적인듯 하니 열심히 배워보도록 하자

#### 1. flatMap

* 아래의 표를 한번 보면 이번에 보던 다이어그램에 비해 복잡하다.ㅜㅜ

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch7-2/1.png?raw=true" width="800px"/>

* 우선 그림을 보면 맨 위에 O1, O2, O3을 가진 Int를 가지는 Observable이 있다. 
* O1을 시작으로 flatMap은 객체를 받아 값에 접근한다. 그리고 그 속성에 10을 곱한다음 그 값을 새로운 observable에 투영한다.
* 그리고 구독자에게 요소를 10을 곱한 값을 전달한다.
* 나중에 O1의 값 속성은 4가 된다. 표에서 표현하지 않은 이유는 표현하면 매우 복잡하기 때문이다.
* 그 다음 O2의 다음 값은 flatMap을 통해 수신되고 20으로 새로운 observable을 만들어 투영하고 그 값을 구독자에게 방출한다.
* 마지막 O3도 flatMap에 의해 수신되고 초기 값이 3에 10을 곱한 요소가 새로운 observable과 구독자에게 방출 된다.
* 코드를 통해 알아보자

```swift
exampleOf(description: "flatMap") {
  let disposeBag = DisposeBag()

  let ryan = Student(score: Variable(80))
  let charlotte = Student(score: Variable(90))

  let student = PublishSubject<Student>()
  
  student.asObserver()
    .flatMap {
      $0.score.asObservable()
    }
    .subscribe(onNext: {
      print($0)
    })
    .addDisposableTo(disposeBag)
  
  student.onNext(ryan)
  charlotte.score.value = 88
  student.onNext(charlotte)
  ryan.score.value = 95
}
-----------------------------------------
--- Example of: flatMap ---
80
88
95
```

* 위에 코드를 보면 위에 다이어그램을 좀 더 이해할 수 있지만 여전히 어렵다.
* 우선 구조체를 통해 Student를 상속 받는 ryan과 charlotte를 생성하면서 초기값을 지정한다.
* 그리고 student를 가지는 PublishSubject를 생성하여 이것에 flatMap에 student의 프로퍼티인 score를 관찰하고 그것에 대해 구독하기로 정했다. 
* 설정 후 처음에 ryan에 대해 next를 이벤트를 주었고 이 이벤트로 인해 ryan이란 구조체에서 score를 반환하는데 score는 처음에 지정한 초기값이 출력된다.
* 그리고 charlotte에 score 값을 변환 해주었는데 이것에 대한 이벤트는 발생하지 않았다. 이유는 우선 구독을 통한 next 이벤트를 발생하지 않아서 인것 같다. 그 이후 charlotte에 대한 next이벤트를 발생 시키니 초기 값이 아닌 그 전에 지정한 88이란 score를 출력했다.
* 그리고 마지막으로 ryan에 score값을 바꾸었을 때는 95에 대한 값이 출력되었다.
* 요약하자면 각각의 observable의 변경사항을 감시하는 것이다.

#### 2. flatMapLatest

* flatMapLatest는 실제로 두 연산자인 map과 switchLatest를 조합한 연산자이다.
* flatMapLatest는 observable의 각 요소를 새로운 objservable에 투용하고 observable의 observable을 observable로 변환하여 가장 최근의 observable의 값을 생성하는 것이다.
* 아래 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch7-2/2.png?raw=true" width="800px"/>

* 간단하게 설명하면 지나간 관찰자는 더 이상 보지 않는 다는 얘기 같다. 1, 2, 3을 관찰한다고 하면 1번을 관찰하고 는 계속 1번 관찰하지만 1번 후에 다른 것, 즉 2번이나 3번을 관찰하기 시작하면 1번은 더이상 관찰할 수 없는 것이다.
* 코드를 통해 알아보자.

```swift
exampleOf(description: "flatMapLatest") {
  let disposeBag = DisposeBag()
  let ryan = Student(score: Variable(80))
  let charlotte = Student(score: Variable(90))
  let student = PublishSubject<Student>()
  
  student.asObservable()
    .flatMapLatest{
      $0.score.asObservable()
    }.subscribe(onNext: {
      print($0)
    }).addDisposableTo(disposeBag)
  
  student.onNext(ryan)
  ryan.score.value = 85
  student.onNext(charlotte)
  charlotte.score.value = 80
  ryan.score.value = 40
  student.onNext(ryan)
}
-----------------------------------------
--- Example of: flatMapLatest ---
80
85
90
80
40
```

* 위에 코드를 보면 우선 위에 flatMap과는 같은 설정을 한다. 그 다음에 차이점을 알 수 있다.
* 우선 첫번째로 ryan을 관찰하기 시작하면 ryan에 초기 값에 대해 새로운 observable에 투영하고 관찰자에게 초기 점수를 출력한다.
* 그 다음 ryan의 score를 바꾸면 faltMap과 같이 변한 값에 대해 관찰하다가 새로 변경된 값을 출력한다.
* 그리고 charlotte에 대해 next 이벤트를 발생하면서 그 때의 값에 대해 새로운 observable을 그 값을 투영하고 관찰자에게 해당 값을 출력한다. 그리고 charlotte의 score를 바꾸면 새로 변경된 값이 출력된다.
* 차이점은 이제부터이다. 그 다음에 ryan의 score의 값을 변겨해 주었는데 flatMap 같으면 바뀐 값에 대해 그 값을 출력하지만 이번에는 그 값을 출력하지 않는다. 그리고 다시 ryan에 대해 next이벤트를 발생시키면 새로운 observable이 만들어지고 그전에 설정한 40이라는 값이 출력된다. 
