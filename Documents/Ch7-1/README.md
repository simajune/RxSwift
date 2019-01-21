# Transforming Operator

### Transforming Operator

* Transforming Operator를 사용하면 Observable에서 제공하는 데이터를 가입자가 사용할 수 있다.
* Observable은 개별적인 요소를 방출한다. 하지만 대부분은 Observable을 바인딩할 때는 대부분 테이블 뷰나 콜렉션 뷰에 사용한다. 

#### 1. ToArray

* 아래의 표를 한번 봐보자

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch7-1/1.png?raw=true" width="800px"/>

* toArray는 Observable의 모든 요소를 배열로 만들어준다. 모든 요소를 배열로 변환하고 그 배열을 포함하는 next이벤트를 구독자에게 보낸다.
* 코드를 통해 알아보자

```swift
exampleOf(description: "toArray") {
    let disposeBag = DisposeBag()
    // 1
    Observable.of("A", "B", "C")
      // 2
      .toArray()
      .subscribe(onNext: {
        print($0)
      })
      .addDisposableTo(disposeBag)
}
-----------------------------------------
--- Example of: toArray ---
["A", "B", "C"]
```

* 위의 코드를 보면 Observable은 총 3개의 String의 타입을 가지는 요소가 있다. 이 observable을 toArray를 통해 구독을 하면 3개의 요소가 배열로 묶여 ["A", "B", "C"]가 방출되게 된다.

#### 2. Map

* 아래 마블 다이어그램을 보자.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch7-1/2.png?raw=true" width="800px"/>

* 위의 그림을 보면 클로저를 통해 Observable의 요소에 2를 곱한 후 이벤트를 발생시킨다.
* 코드를 통해 알아보자.

```swift
exampleOf(description: "map") {
  let disposeBag = DisposeBag()
  // 1
  let formatter = NumberFormatter()
  formatter.numberStyle = .spellOut
  // 2
  Observable<NSNumber>.of(123, 4, 56, 10.4, 013)
    // 3
    .map {
      formatter.string(from: $0) ?? ""
    }
    .subscribe(onNext: {
      print($0)
    })
    .addDisposableTo(disposeBag)
}
-----------------------------------------
--- Example of: map ---
one hundred twenty-three
four
fifty-six
ten point four
thirteen
```

* 위에 코드를 보면 Observable에서 요소로 NSNumer 타입을 받고 총 5개의 요소를 받고 map에서 해당 값에 대해 formatter를 통해 요소를 스펠링으로 변환하여 방출하게 했다.

### 3. MapWithIndex

* 이번에 배울 것은 5장에서 배웠던 index와 filter를 통해 연산했던 skipWhileWithIndex와 takeWhileWithIndex와 비슷한 것이다. map과 index를 통해 연산을 하는 것을 배울 것이다.
* 그림과 코드를 살펴 보자

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch7-1/3.png?raw=true" width="800px"/>

* 위의 다이어그램을 보면 요소와 인덱스에 조건을 통해 요소를 변환시켜 방출한다. 조건은 인덱스가 1보다 크면 그때 인덱스를 가지는 요소에 2를 곱하고 아니면 원래의 요소를 방출하는 연산자이다. 인덱스는 0부터 시작하기 때문에 0일때의 요소 1과 인덱스가 1일 때의 요소 2는 그대로 방출 되고 인덱스가 2인 요소 3은 조건에 만족하기 때문에 2를 곱하여 6이란 요소를 방출한다.
* 코드로 확인해보자

```swift
exampleOf(description: "mapWithIndex") {
  let disposeBag = DisposeBag() 
	// 1 
	Observable.of(1, 2, 3, 4, 5, 6) 
	// 2 
    .mapWithIndex { integer, index in 
      index > 2 ? integer * 2 : integer 
    } 
    .subscribe(onNext: { 
		print($0) 
    }) 
    .addDisposableTo(disposeBag)
}
-----------------------------------------
--- Example of: mapWithIndex ---
1
2
3
8
10
12
```

* 위에 코드를 보면 mapWithIndex의 조건을 보면 index가 2보다 커야하는 조건이 들어갔고 그 조건을 충족시키면 그 때의 요소에 2를 곱하고 아니면 운래의 요소를 방출하는 연산자이다. 인덱스가 2보다 큰 조건이기 때문에 4번째 요소부터 조건에 만족하므로 1, 2, 3은 그대로 1, 2, 3이 그대로 방출되고 4, 5, 6은 2를 곱한 8, 10, 12를 방출한다.