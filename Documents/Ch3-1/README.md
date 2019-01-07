# Subjects란

- 지금까지 Observable이 무엇인지 어떻게 만들고 어떻게 구독하고 어떻게 그것이 끝나는지에 대해 배웠다. 지금까지 배운것은 Rxswift의 기본적인 부분을 공부했다.
- 우리는 앱을 개발할 때 실시간으로 Observable의 값을 확인하고 그것을 구독자에게 보내는 것인데 진짜 필요한 것은 observable과 관찰자 둘다 행동할 수 있는 무언가가 필요한데 그게 이제 배울 Subjects이다.



### 1. 시작하기

```swift
example(of: "PublishSubject") { 
    //1
	let subject = PublishSubject<String>() 
    //2
    subject.onNext("Is anyone listening?") 
    //3
    let subscriptionOne = subject 
  						  .subscribe(onNext: { string in 
                                              print(string) 
											  })
    //4
    subject.on(.next("1"))
    //5
    subject.onNext("2")
}
-----------------------------------------------
--- Example of: PublishSubject --- 
1 
2 
```

- 위에 코드는 PublisherSubject를 만든것이다. 이것은 뉴스 게시와 같은 기능을 하기때문에 이름이 정해졌고 이것은 정보를 받고 그 후에 구독자에게 정보를 주기 때문에 가능하면 먼저 정보를 수정해주어야 한다.
- String타입으로 문자열만 받고 바로 게시할수 있다. 

- 그 후에 subject에 새로운 String(2번)을 주었지만 이것은 아직 출력되지 않는다. 왜냐하면 관찰자가 없기 때문에!!!
- 그래서 아래에 코드(3번)를 추가해준것이다. 이렇게 subject를 구독하면 전에 배웠듯이 .next이벤트가 발생하지만 여전히 문자열이 출력되지는 않는다. 왜냐하면 구독하기 전에 subject의 이벤트가 먼저 발생했기 때문이다.
- 여기서 일어난 것은 구독자에게만 방출된 것이다.  그렇게 때문에 구독전에 발생한 모든 것은 이벤트로 얻질 못 한다.
- 그 이후에 만약 다음코드(4번)이 추가 되면 이미 subject는 구독이 되었기 때문에 이제부터 발생하는 모든 이벤트에 대해서는 방출되게 된다.
- 그 다음에 코드(5번)를 또 추가해도 위와 동일하게 이벤트가 방출되고 해당하는 문자열이 출력된다.

### 2. Subject란 무엇인가?

- Subject는 observable과 observer의 역할을 둘다 하는 것이다.
- 즉, 어떻게 이벤트를 받고 구독할지에 대해 쉽게 보여준다.
- .next 이벤트가 방출되더라도 구독 상태가 아니면 이 이벤트는 무시된다.
- 4개의 Subject 타입
  - PublisherSubject: 비어있는 상태로 시작하여 단 하나의 새로운 요소만 구독자에게 방출
  - BehavoirSubject: 초기값으로 시작하여 새 요소 또는 최신 요소를 새 구독자에게 방출
  - ReplaySubject: 버퍼 사이즈로 시작하여 그 사이즈에 버퍼 사이즈까지의 요소의 버퍼를 유지해서 그것을 구독자에게 방출
  - 

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

