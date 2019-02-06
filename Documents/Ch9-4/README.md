# Trigger

* 앱에서는 다수로 들어오는 input에 대해 관리하고 나눌 필요가 있다. 종종 한번에 몇개의 Observable에서 input에 접근할 때가 있다. 그 때 사용하는 것이 바로 Trigger연산자이다.

#### 1. WithLatestFrom

* 마블을 보면서 알아보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-4/1.png?raw=true" width="800px"/>

* 위의 그림을 보면 텍스트 필드에서 사용하는 경우이다. 가입이나 로그인 화면에서 텍스트필드에서 텍스트를 입력을 하고 확인 버튼을 누르는 경우로 보면 될거 같다. 버튼은 withLatestFrom이란 연산자를 통해 버튼이 눌렸을 때 최종적으로 텍스트 필드에 입력된 값을 방출한다고 보면 될거 같다.

* 위에 그림을 코드로 구현해 보자.

```swift
exampleOf(description: "withLatestFrom") {
    //1
    let button = PublishSubject<Void>()
//    let textField = BehaviorSubject<String>(value: "아이디를 입력해주세요.")
    let textField = PublishSubject<String>()
    
    //2
    let observable = button.withLatestFrom(textField)
    let _ = observable.subscribe(onNext: { value in
        print(value)
    })
    
    //3
    button.onNext(())
    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")
    button.onNext(())
    button.onNext(())
}
-----------------------------------------
--- Example of: withLatestFrom ---
Paris
Paris
```

* 위의 코드는 withLatestFrom 연산자를 사용한 예이다. 이 예를 보면 일단 textField에 값이 없는 경우는 아무리 button에 이벤트가 발생하더라도 withLatestFrom 연산자에 이벤트에서 값을 주지 않는다. 그래서 보통의 경우 로그인이나 검색같은 경우 버튼을 통해 값을 얻고자 할 때 이 연산자를 쓰면 될거 같다. 근데 굳이 이걸 쓰지 않아도 될거 같다는 생각이 든다.



#### 2. Sample

* 우선 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch9-5/2.png?raw=true" width="800px"/>

* sample 연산자는 말 그대로 샘플을 얻기 위한 연산자로 보인다.
* 이 다이어그램은 위의 withLatestFrom 연산자와 비슷해보이지만 다른 점이 있다.
  * 우선, button의 이벤트에 대해 최초 1회만 이벤트가 발생하고 다음에는 발생하지 않는다.
  * 두번째, withLatestFrom 연산자는 button이 주체(앞에 쓰임)였다면 sample 연산자의 주체는 textField이다.
* 코드를 통해 알아보자.

```swift
exampleOf(description: "sample") {
    //1
    let button = PublishSubject<Void>()
    let textField = BehaviorSubject<String>(value: "아이디를 입력해주세요.")
//    let textField = PublishSubject<String>()
    
    //2
//    let observable = button.withLatestFrom(textField)
    let observable = textField.sample(button)
    let _ = observable.subscribe(onNext: { value in
        print(value)
    })
    
    //3
    button.onNext(())
    button.onNext(())
    textField.onNext("Par")
    button.onNext(())
    textField.onNext("Pari")
    button.onNext(())
    textField.onNext("Paris")
    button.onNext(())
    button.onNext(())
}
-----------------------------------------
--- Example of: sample ---
아이디를 입력해주세요.
Par
Pari
Paris
```

* 다이어그램을 봤을때 이해되지 않던 것이 코드를 통해 더 이해하기 쉬워졌다. 우선 방법은 withLatestFrom 연산자와 같다. 차이점은 observale 만들 때 주체가 button에서 textField로 바뀐 것 뿐. 
* 출력되는 것을 보면 우선 sample이란 연산자는 textField에 변동된 것이 있으면 버튼의 대한 이벤트를 기다린다. 그리고 버튼이 입력이 되면 현재의 textField의 값에 대한 이벤트를 발생하고 그 다음부터는 textField가 변동되지 않는한 더 이상 버튼에 대한 이벤트를 받지 않는다.
* 만약 textField의 값이 바뀌면 다시 버튼의 대한 이벤트를 기다라는 식의 연산자이다.
