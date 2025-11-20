# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter-based electronic approval (전자 결재) mobile application that handles document drafting, approval workflows, and user authentication. The app follows a feature-first architecture with Riverpod for state management and uses Retrofit with Dio for API communication.

## Development Commands

# ⚠️ Claude AI의 역할 및 행동 지침

## 역할

당신은 **사용자의 코딩 조언자 및 선생님** 역할을 수행합니다.

## 행동 규칙

1.  **코드를 직접 수정하지 않습니다.**
2.  사용자가 코드를 직접 수정하도록 **구체적인 설명과 함께 제안**합니다.
3.  **오류 해결, 코드 개선, 새로운 기능 추가** 등에 대한 방법을 **단계별로 설명**합니다.
4.  실행해야 하는 **명령어나 명령어 시퀀스**를 명확하게 제시합니다.
5.  **힌트**를 제공해서 사용자가 생각하고 직접 수정할 수 있게 도움을 줍니다.

### Setup

```bash
flutter pub get
```

### Code Generation

Run code generation for JSON serialization, Retrofit API clients, and Freezed models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Watch mode for continuous code generation during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running the App

```bash
flutter run
```

### Testing

```bash
flutter test
```

### Linting

```bash
flutter analyze
```

## Architecture

### Feature-First Structure

The codebase is organized by features (user, drafts, etc.) with each feature containing:

- `model/` - Data models with JSON serialization (using `json_annotation` and code generation)
- `provider/` - Riverpod providers and notifiers for state management
- `repository/` - Retrofit API repositories
- `view/` - UI screens and widgets

### Common Infrastructure (`lib/common/`)

- **dio/** - Dio HTTP client provider configuration with base URL `http://10.0.2.2:8080/api` (Android emulator localhost)
- **interceptor/** - `CustomInterceptor` handles JWT token injection and automatic token refresh on 401 errors
- **pagination/** - Generic `Pagination<T>` model for paginated API responses
- **router/** - GoRouter configuration with shell routes for authenticated pages
- **logger/** - Riverpod observer for state change logging
- **view/** - Shared UI components (custom buttons, inputs, default layout)

### State Management Pattern

Uses `AsyncNotifier` and `AsyncNotifierProvider` from Riverpod:

- State is wrapped in `AsyncValue` for loading/error/data states
- Providers watch repositories and other dependencies via `ref.watch()`
- Example: `UserNotifier` handles login and token refresh, `DraftsListNotifier` handles paginated draft fetching with `fetchMore()` support

### Authentication Flow

1. User logs in via `UserNotifier.login()` with username/password
2. Tokens stored in secure storage via `Token` class (uses `flutter_secure_storage`)
3. `CustomInterceptor` injects access token on requests with `'access_token': true` header
4. On 401 errors, interceptor automatically refreshes token using refresh token
5. If refresh fails, all tokens are cleared and user must re-login

### API Integration

- Uses Retrofit with Dio for type-safe API clients
- Repositories are abstract classes with `@RestApi()` annotation
- Generated implementation files have `.g.dart` suffix
- Custom headers like `'access_token': true` trigger token injection in interceptor
- Base URL defined in `dioProvider` with timeouts: connect 5s, receive 3s, send 5s

### Pagination Pattern

The `Pagination<T>` model supports infinite scroll:

- Contains `items`, `page`, `pageSize`, `total`, `totalPages`
- `isLoadingMore` flag prevents duplicate fetch requests
- Providers implement `fetchMore()` method that appends new items to existing list
- Pull-to-refresh triggers fresh fetch via provider's main fetch method

## Important Implementation Notes

### Code Generation Dependencies

When adding or modifying models, repositories, or any code using annotations:

- Models with `@JsonSerializable()` require running build_runner
- Retrofit repositories with `@RestApi()` require running build_runner
- Freezed models with `@freezed` annotation require running build_runner
- Always include `part 'filename.g.dart';` directive in files using code generation

### Token Management

- Access token injection is opt-in via `@Headers({'access_token': true})` on repository methods
- Refresh token passed via header: `@Header(REFRESH_TOKEN)`
- Token refresh includes retry prevention via `options.extra['retried']` flag
- Login and refresh endpoints bypass token refresh logic in interceptor

### Routing

- Root route `/` is the login page (unauthenticated)
- Shell routes (e.g., `/drafts`) use `DefaultLayout` with AppBar and Drawer
- Route names used for title lookup: `{'drafts': '기안함'}`
- Navigation uses `context.goNamed()` for type-safe routing

### API Base URL

The base URL `http://10.0.2.2:8080/api` is configured for Android emulator (10.0.2.2 maps to host machine's localhost). For iOS simulator or physical devices, update the base URL in `lib/common/dio/dio.dart`.

---

## 🚧 Current Work In Progress

### Filter Feature Implementation (진행 중)

**목표**: Drafts 화면에 전체 화면 필터 기능 추가

**설계 방향**:
- 전체 화면 모달 방식 (BottomSheet의 90% 높이)
- 재사용 가능한 공통 컴포넌트로 설계 (`lib/common/view/`)
- 필터 버튼은 리스트 위에 배치 (AppBar 아님)
- 필터 버튼은 세로 중간 정렬 (`crossAxisAlignment: CrossAxisAlignment.center`)

**필터 항목**:
- 상태 (DocumentStatus: 전체, 기안, 결재대기, 결재중, 결재완료, 반려, 취소)
- 기간 (시작일 ~ 종료일)
- 정렬 (향후 추가 예정)

### 파일 구조

```
lib/
├── common/view/
│   ├── custom_filter_button.dart      ⭐ 새로 생성 필요
│   └── filter_components.dart          ⭐ 새로 생성 필요
├── drafts/view/
│   ├── drafts.dart                     🔧 수정 필요
│   └── drafts_filter_screen.dart       ⭐ 새로 생성 필요
└── drafts/provider/
    └── drafts_provider.dart            🔧 나중에 수정 (필터 연동)
```

### 할일 체크리스트

#### 1단계: 공통 컴포넌트 생성

**파일**: `lib/common/view/custom_filter_button.dart`
- 역할: 리스트 위에 표시될 필터 버튼 컴포넌트
- 기능: 필터 아이콘, 적용된 필터 Chip 표시, 세로 중간 정렬
- 주요 속성:
  - `onPressed: VoidCallback` - 필터 버튼 클릭 시 실행
  - `activeFilters: List<Widget>` - 적용된 필터 Chip들

**파일**: `lib/common/view/filter_components.dart`
- 포함 컴포넌트:
  - `FilterSectionTitle` - 섹션 제목 위젯
  - `FilterBottomButtons` - 하단 초기화/적용 버튼 (그림자 효과 포함)

#### 2단계: Drafts 전용 필터 화면

**파일**: `lib/drafts/view/drafts_filter_screen.dart`
- 전체 화면 필터 UI (Container height: 90%)
- 구현 기능:
  - 헤더 (제목 "필터" + 닫기 버튼)
  - 상태 필터 (ChoiceChip으로 DocumentStatus 선택)
  - 날짜 범위 필터 (showDatePicker 사용)
  - 하단 버튼 (초기화/적용)
- 적용 버튼 클릭 시 `Navigator.pop(context, {...})` 으로 선택값 반환

#### 3단계: Drafts 화면 연동

**파일**: `lib/drafts/view/drafts.dart` 수정
1. Import 추가:
   ```dart
   import 'package:electronic_approval/common/view/custom_filter_button.dart';
   import 'package:electronic_approval/drafts/view/drafts_filter_screen.dart';
   ```
2. State에 필터 변수 추가:
   ```dart
   DocumentStatus? _filterStatus;
   DateTime? _filterStartDate;
   DateTime? _filterEndDate;
   ```
3. CustomScrollView의 첫 번째 sliver로 필터 버튼 추가:
   ```dart
   SliverToBoxAdapter(
     child: CustomFilterButton(
       onPressed: _showFilterScreen,
       activeFilters: _buildActiveFilterChips(),
     ),
   )
   ```
4. 메서드 추가:
   - `_buildActiveFilterChips()` - 적용된 필터를 Chip으로 변환
   - `_showFilterScreen()` - showModalBottomSheet로 필터 화면 띄우기

#### 4단계: Provider 연동 (향후 작업)

**파일**: `lib/drafts/provider/drafts_provider.dart` 수정
- 필터 상태를 provider에서 관리
- `getDrafts()` 호출 시 필터 파라미터 전달
- Repository의 `status`, `startDate`, `endDate` 파라미터 활용

### 구현 순서

```
1️⃣ custom_filter_button.dart 생성
    ↓
2️⃣ filter_components.dart 생성
    ↓
3️⃣ drafts_filter_screen.dart 생성
    ↓
4️⃣ drafts.dart 수정
    ↓
5️⃣ 테스트 (필터 모달 동작 확인)
    ↓
6️⃣ provider 연동
```

### 주요 구현 포인트

**세로 중간 정렬**:
```dart
Row(
  crossAxisAlignment: CrossAxisAlignment.center, // 🎯
  children: [...],
)
```

**전체 화면 모달**:
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,  // 전체 높이 제어 가능
  backgroundColor: Colors.transparent,
  builder: (context) => Container(
    height: MediaQuery.of(context).size.height * 0.9,
    // ...
  ),
)
```

**필터 값 전달**:
```dart
// DraftsFilterScreen에서 적용 버튼 클릭 시
Navigator.pop(context, {
  'status': _selectedStatus,
  'startDate': _startDate,
  'endDate': _endDate,
});

// drafts.dart에서 받기
.then((result) {
  if (result != null && result is Map<String, dynamic>) {
    setState(() {
      _filterStatus = result['status'];
      // ...
    });
  }
});
```

### 참고사항

- `lib/common/view/custom_filter.dart` 파일은 이전 시도로 생성되었으나, 재사용 불가능한 구조이므로 위 파일 구조로 재작성 권장
- DocumentStatus enum은 `lib/drafts/model/drafts.dart`에 정의되어 있음
- Repository의 `getDrafts()` 메서드는 이미 필터 파라미터를 지원함 (status, startDate, endDate, sort)
