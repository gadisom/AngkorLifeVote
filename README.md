# AngkorLifeVote

## 구조 개요

### App
- AngkorLifeVoteApp: SwiftUI 진입점, UserSession과 AppCoordinator를 전역 주입
- UserSession: ID 관리 (단순 ID 입력)
  
### Coordinators
- AppCoordinator, LoginCoordinator, MainCoordinator: 화면 전환 흐름 제어

### Scenes

- Login: 단순 ID/비번 입력(또는 토큰 기반 로그인)
- Main: 전체 메인 컨텐츠 (스크롤)
- CandidateList: 후보 목록, 정렬 Picker, 투표 로직

### Models
CandidateItem, CandidateResponse 등 데이터 모델

### Services
- CandidateService: 네트워크 요청 (투표, 후보 목록)
- VoteAPI: URLRequest 생성 로직 (enum)
  
### Utils
- Extensions (Font, Color)
- CustomAlertView

--- 

## 주요 고민 & 해결 과정

### 화면 전환 
문제: SwiftUI에서 화면 전환(로그인 → 메인 → 디테일)이 복잡해질수록 NavigationLink만으로는 관리가 어려움, iOS 15 타겟이라 NavigationStack 을 사용할 수 없는 문제

해결: MVVM-C(Coordinator) 패턴 도입
- LoginCoordinator / MainCoordinator / AppCoordinator
- 각각의 start()에서 View를 반환
- 로그인 성공 시 LoginCoordinator → 메인 화면, 로그아웃 시 MainCoordinator → AppCoordinator로 흐름 제어

### MVVM 구조 & Service 분리 
- 네트워크 로직을 CandidateService 등 Service 계층으로 분리
- MVVM을 유지하되, 공통 API 로직을 한 곳에서 관리하도록 설계
- 투표, 리스트 조회, 정렬 등 공통 로직이 많아 Service와 ViewModel이 겹칠 가능성을 줄이고자 함

### 투표 시스템 & 최신 데이터 유지
- 네트워크 비용을 줄이기 위해 특정 셀만 갱신하는 방안도 고민
- 그러나 투표 시스템 특성상 최신 데이터(다른 사용자도 투표) 반영이 중요하다고 판단
- 결론: 전체 후보 리스트를 다시 페치하여 확실하게 최신 상태를 유지

### SortType & 확장성
- 정렬 옵션을 Picker로 제공 (SortType enum)
- 현재는 name, voteCntDesc, candidateNumber 정도지만, 추가 정렬 기준(날짜, 번호 오름차순/내림차순 등) 확장 가능
- Service 로직도 SortType을 인자로 받아 정렬 쿼리/로직을 처리

--- 

## 개선사항 
### 민감 정보 관리 개선

- 현재 상황: 사용자 ID와 같은 민감 정보를 `UserSession`을 통해 관리하고 있으나, 보안 측면에서 추가적인 강화가 필요함.
- 향후 계획:
  - Keychain 연동: 민감한 정보(예: 토큰, 사용자 ID)를 안전하게 저장하고 복원하기 위해 Keychain을 도입.
  - 데이터 암호화: 저장되는 민감 데이터를 암호화하여 보안성을 높임.
  - 접근 제어: 민감 정보에 대한 접근 권한을 엄격히 관리하고, 불필요한 노출을 방지.
---
