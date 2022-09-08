버튼 네모 전체가 터치 영역

회원가입 시 정체성 중복으로 추가됨

회원가입 후 메인탭에 첫번째로 안가고 두번째로감..! 왜 !!!

pull torefresh 안사라짐 ?! ![image-20210807115255976](/Users/seominju/Library/Application Support/typora-user-images/image-20210807115255976.png)

![image-20210807112617336](/Users/seominju/Library/Application Support/typora-user-images/image-20210807112617336.png)



기다려야 할 때 로딩인디케이터 

트래커에 표시 좀 더 티나게..





~~다크모드에서  검은색 글자 흰색으로 나오는 문제~~

~~정체성 detailview에서 color 하단 border width가 굵게나옴~~

~~정의 입력해주세요 placeholder 안보임~~

=> 셋 다 다크모드 문제. plist -> Appearance -> Light로 해결



tableview 제일 상단 스크롤시 뚝뚝 끊기는 현상

tableview 선택시 어두워지지않게







tracker calendar랑 tableview 사이 spacing minus로된거 줄여

Tracker 선택한 table section 제일 위로가게 scroll top

다른 section 선택시 뚝뚝 끊김

graph dataset 라벨 제거

graph 최소 높이 높이는 방법

graphview (tableviewcell) 높이 좀 낮춰서 한 눈에 들어오게





habit check api -> disappear할 때 한번에 보내기? 



identity 확인 했을때만 habit delete, add, update 반영

습관 생성, 업데이트에 문제있음



​    habitTableView.layer.addBorder([.top, .bottom]) -> 이거를 IdentityVC의 table에 적용, 

Habit의 Do, Don't 라벨 감싸고 있는 뷰에 [.right]만 적용



- 리프래쉬 시 체크한 것 사라짐(아이폰 12 pro, IOS 14.6)

  https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e09280c5-8ce0-4ff4-9ce7-cc929171f5b9/iOS_이미지.mp4

- 초기에 되고 싶은 사람 설정하고, 그 밑에 습관 추가하기를 한 순간 앱이 튕겼어여(아이폰 12 pro, IOS 14.6)

  → 직접입력누르고 키보드에 있는 전송(send) 누르면 튕김

  +직접입력 후 시작하기 누르면 반영됨

  +선택 , 직접입력 같이 한경우 선택만 반영

- 색깔 적용 안돼요.(아이폰 12, IOS 14.6)

- 습관 체크, 체크해제시 바로 트래커에 반영이 안돼요 (아이폰12, IOS 14.6)

- 회원가입 유효성검증멘트가 너무 길어서 짤려요

  ![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b20ff9e9-27f6-417c-acd9-bc6f0f80566d/0058BFE9-C0D5-4B8D-A40C-F12512081AF6.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b20ff9e9-27f6-417c-acd9-bc6f0f80566d/0058BFE9-C0D5-4B8D-A40C-F12512081AF6.png)

→ 두줄로 처리하는 방법도 있긴한데 제가(릴리) 짧게 수정해도 될 것 같습니다

- 설정부분이 없어서 회원탈퇴를 못해요 + 자기소개 페이지도
- **정체성에서 Do, Don't를 하나씩밖에 못만들어요!** 3개로 늘려주셨으면 좋겠어요(정적으로)



짜트마리, 산타 애니메이션

산타 스토리보드없이 Snapkit으로 풀코딩 ..!

먼데이샐리

짜트마리 - 네비게이션바랑 캘린더 ..! 

