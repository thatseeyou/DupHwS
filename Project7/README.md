## 학습내용

### UISplitViewController
* Master view controller가 navigation view controller가 아니라 tab bar controller인 경우에 문제가 발생할 수 있다.
- showDetailViewController:sender: 가 의도한 대로 동작하기 위해서는 UISplitViewControllerDelegate의 splitViewController:showDetailViewController:sender: 메소드를 이용해야 한다.
* expanded vs. collapsed vs. expanding

### UITabBarController
* UITabBarItem에 tag를 지정해서 현재 tab을 찾는데 이용할 수 있다.

### NSJSONSerialization.JSONObjectWithData
* NSData 형식의 JSON 문자열을 JSON Object(Dictionary, Array)로 변환한다.
* AnyObject를 리턴하기 때문에 optional chaining 활용을 해서 원하는 요소에 접근해야 한다.

### NSData(contentsOfURL: options:)
* URL을 지정하면 HTTP 통신을 수행해서 응답을 리턴한다.

### UITextView
* WKWebView로 텍스트를 렌더링하면 속도가 느리기 때문에 UITextView로 텍스트를 표시하도록 한다.