# Observable만들기

- 이제부터 Observable을 만들어볼것이다. 이것은 playground를 통해 작업을 할 것이다.

```swift
example(of: "just, of, from") { 
	// 1 
	let one = 1 
	let two = 2 
    let three = 3 
    // 2 
    let observable: Observable<Int> = Observable<Int>.just(one) 
}
```

- 위에 예제 코드가 있다. 
  - 상수 **one**, **two**, **three** Int 타입으로 정의되어 있다.
  - just라는 메소드에 Integer **one**이란 변수를 사용하는 int 타입의 Observable을 만들었다.
- just는 타입 메소드이다. 하지만 Rx에서는 타입메소드는 **operator**로 쓰인다. 
- 다음에 위에 코드에 아래에 코드를 추가해보자

```swift
let observable2 = Observable.of(one, two, three) 
```

- 위에서는 타입을 명시하진 않았다. 여러개의 정수가 있기 때문에 정수 배열로 생각할 수 있지만 배열이 아닌 정수의 Observable이다.
- 정수 배열의 Observable은 아래와 같다.

```swift
let observable3 = Observable.of([one, two, three])
```

- 여기서 알수 있는 것은 배열은 단일 요소라는 것. 

```swift
let observable4 = Observable.from([one, two, three])
```

- from연산자는 배열에만 사용가능.
- from 연산자는 배열 안에 있는 요소들을 가져온다.

