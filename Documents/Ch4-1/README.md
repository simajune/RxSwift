# Obsevable & Subject 연습

- 지금까지 배운 것을 토대로 연습을 해볼 것이다. 왜냐하면 이론은 공부를 했지만 이것을 어떻게 실전에 적용할지가 중요하기 때문이다.
- 어떤것을 만들 것이냐면 Rx를 이용해서 사진 콜라주를 만들것이다.
- 미리 만들어진 프로젝트를 보면 메인 storyboard가 이렇게 구성되어 있을 것이다.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch4-1/1.png?raw=true" width="800px"/>

* 첫번째 화면은 UIImageView 하나와 두개의 버튼 그리고 네비게이션 바에 Add버튼으로 구성되어 있다.
* UIImageView에는 현재 사진을 보여주고 clear 버튼은 현재의 사진을 초기화하는 것이고 save버튼은 포토 라이브러리에 현재의 사진을 저장하는 것이다.
* 그리고 +버튼을 누르면 다른 ViewController로 넘어가며 이곳에서는 카메라 Roll에 있는 사진을 보고 유저가 tumbnail 사진을 탭하여 사진을 추가할 수 있다.
* 왠만한 코드는 미리 작성되어 있다. 이번에 할 것은 Rx에 대한 부분만 작성하면 된다.

#### ViewController에서 Variable 사용하기

* 우선 controller 클래스에 Variabel<UIImage>를 추가하자. 이것은 선택된 사진의 값을 저장할 것이다. 수동적으로 원할 때 값에 대한 property를 바꿀 수 있다. 

```swift
private let bag = DisposeBag()
private let images = Variable<[UIImage]>([])
```

* 다른 클래스에서는 사용할 수 없게 private로 만들었다.
* disposeBag은 ViewController에 소유되었기 때문에 ViewController가 해제되면 이 ViewController에 있는 모든 Observables는 dispose된다.

<img src="https://github.com/simajune/RxSwift/blob/master/Documents/Ch4-1/2.png?raw=true" width ="800px"/>

* 위의 그림과 같이 하면 Rx 구독 메모리 관리가 매우 쉬워진다. 간단히 bag에 던져 놓다가 ViewController가 폐기되면 bag에 던져 놓았던 모든 것이 dispose될 것이다.
* 하지만 root ViewController이고 앱이 종료되기 전에 릴리즈가 해제된 특정 ViewController에서는 발생하지 않는다. 그때는 분명한 폐기 매커니증을 통해 dispose해야 하고 이건 이번 장에선 배우지 않는다.
* 첫째로, 앱은 항상 같은 사진 기반으로 콜라쥬를 만들 것이다. 

