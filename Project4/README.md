## 학습내용

### WKWebView
* IB에서 지원하지 않기 때문에 코드로 추가해야 한다.
* loadView에서 view를 지정하는 방법과 subview로 추가하는 것이 가능하다.
* WKNavigationDelegate를 통해서 이벤트를 처리할 수 있다.

### UIToolBar
* ToolBar에 custom view (UIProgressView)를 추가한다.
* Custom view의 크기를 auto layout으로 조정한다.
* UIBarButtonItem의 width를 지정해서 auto layout으로 인한 문제를 해결한다.

### UIAlertController
* ActionSheet 스타일을 사용한다.

### KVO(Key-Value Observing)
* Web view의 진행 상태를 모니터링 한다.
* .NEW option을 이용해서 실제 변화가 일어난 경우에는 이벤트 처리를 한다.