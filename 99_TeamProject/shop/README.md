# 🛍️ Lala Boutique (Premium Shopping Mall)

>프로젝트 실행 전 아래 **[개발자 가이드]**를 꼭 읽어주세요.

---

## ⚡ 개발자를 위한 가이드 (Developer Guide) - ★ 필독

### 1. 🔑 "자동 로그인" 치트키 (개발용)
`application.properties` 파일에서 아래 설정을 변경하면 서버 구동시 **"개발자"**로 로그인됩니다.

```properties
# src/main/resources/application.properties

# [기능 개발중일때] true: 접속 시 자동 로그인됨 (인터셉터 회피용)
# [테스트 및 프로젝트 제출 시] false: 실제 로그인 창 뜸 (발표 시 변경)
shop.dev-login=true

---

## 🚀 현재 구현 현황 (Status)

### 1. 회원 (Member) - ✅ 완료
* **회원가입:**
    * 아이디/비밀번호/이름/전화번호 등 필수 정보 입력
    * **카카오 주소 API** 연동 (우편번호 검색 기능)
    * 프리미엄 디자인 적용 (Simple Header)
* **로그인/로그아웃:**
    * `HttpSession` 기반의 로그인 세션 관리
    * 로그인 상태에 따른 Header UI 변경 (Login ↔ Logout)
* **개발 편의 기능:**
    * 자동 로그인 인터셉터 (Interceptor) 구현

### 2. UI / Layout - 🚧 진행 중
* **구조 분리:** `Header`, `Footer` 분리 완료 (`include` 방식)
* **헤더 이원화:** `header_join_only.jsp` (가입 전용), `header.jsp` (일반용) 이원화
* **메인 페이지:** 상품 목록 더미 데이터 연동 준비 중

---