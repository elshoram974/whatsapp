# DESIGN_DECISIONS

**Project:** WhatsApp Clone (Flutter)  
**Platforms:** Android + iOS  
**Repo:** https://github.com/elshoram974/whatsapp

---

## 1) Scope
- Chats list, chat screen, status/stories, and basic calls tab UI.
- WhatsApp-like back behavior: from Stories back to Chats, not app exit.
- Local mocked data only (no backend). Media, notifications, and real-time sync are out of scope.

## 2) Targets and toolchain
- Flutter: 3.32.8 (stable)
- Dart: 3.8.1
- Android: minSdkVersion 21+, targetSdkVersion 35
- iOS: deployment target 13.0+

## 3) Architecture
**Pattern:** Feature-first + Clean layering
- `core/` shared code: theme, router, localization, constants, utils.
- `features/<feature>/`
  - `data/` DTOs, local sources, repositories impl.
  - `domain/` entities + repositories contracts + use-cases (if needed).
  - `presentation/` pages, widgets, blocs/cubits.

**Benefits:** Clear boundaries, testable units, minimal coupling, easier scaling.

## 4) State management
- **Bloc/Cubit** per feature screen for predictable state and time-travel debugging.
- `BlocProvider` at feature entry. `BlocBuilder`/`BlocSelector` to minimize rebuilds.
- Simple Cubits for ephemeral UI states (tab index, story controller), full Blocs for chat flows.

## 5) Navigation
- **go_router** with typed routes and nested stacks.
- Structure:
  - `ShellRoute` for main tabs (Chats, Status, Calls) if tabs are used.
  - Nested routes for chat details: `/chat/:id`.
  - Stories route: `/status/:userId` with page transitions and swipe gestures.
- Deep links supported by path params. Back button handling mirrors WhatsApp: if in Stories, `pop()` returns to Chats.

## 6) Data layer
- Local JSON under `assets/mock/`: `chats.json`, `messages_chat_*.json`, `stories.json`.
- Repository pattern wraps sources and exposes domain models: `ChatSummary`, `Message`, `Story`, `UserStories`.
- Date parsing and formatting via `intl` in `core/utils/date_utils.dart`.

## 7) Stories (Status) UX
- **PageView** for story items per user with horizontal swipe between users.
- Top progress bars reflect current item time with `AnimationController + TickerProvider`.
- Tap right = next item, tap left = previous item. Long-press = pause.
- Auto-advance within a user then auto-continue to the next user.
- Preload next/previous media via `precacheImage` to avoid flicker.
- Preserve viewed state when exiting and re-entering.
- Back from stories returns to Chats screen, not app close.

## 8) UI fidelity and motion
- Visuals inspired by WhatsApp colors, spacing, and micro-interactions.
- **Hero** animations for avatar transitions where applicable.
- **Implicit animations** for small state changes; **explicit** for story timers.
- List virtualization by `ListView.builder`, stable `ValueKey`s.

## 9) Theming
- Centralized theme in `core/theme/app_theme.dart`.
- Light/Dark support. Colors, typography, and icon sizes defined once.
- Semantic color tokens in `core/constants/colors.dart`.

## 10) Internationalization (i18n)
- **easy_localization** with `assets/translations/en.json` and `ar.json`.
- RTL support via `Directionality` and localized text alignment.
- Date/number formatting via `intl`.

## 11) Performance
- `const` constructors, `const` widgets where possible.
- Avoid rebuilds using `BlocSelector`, `ValueListenableBuilder`, and keys.
- Image performance: sizing with `BoxFit.cover`, `precacheImage`, cache-friendly URLs.
- Deferred work using microtasks and `SchedulerBinding` where beneficial.

## 12) Accessibility
- Scales with system text size. Touch targets ≥ 44×44.
- Semantics labels on key controls (play/pause story, next/prev).
- Sufficient contrast in both themes.

## 13) Testing & quality
- **Lints:** enabled via `analysis_options.yaml` with strict rules.
- **Unit tests:** date utils, repositories mapping.
- **Widget tests:** story progress, back navigation, chat tile rendering.
- **Golden tests:** core UI states where stable.

## 14) Tooling & CI (optional)
- Git hooks or CI to run `flutter format`, `flutter analyze`, and `flutter test` on PRs.
- Version pinning in `pubspec.yaml` for reproducible builds.

## 15) Known trade-offs
- No backend or persistence. Stories and chats reset from local JSON.
- Media viewer simplified. No stickers, reactions, or voice notes.
- Notifications and background fetch are not implemented.

## 16) How to run (summary)
- Ensure Flutter 3.x and Dart 3.x.
- `flutter pub get`
- `flutter run -d <device>` (Android or iOS simulator)
- See `README.md` for platform-specific notes.

## 17) Future work
- Connect to a backend (Firebase/REST) for real data.
- Message sending, typing indicators, and read receipts.
- Offline persistence with Hive or SQLite.
- Media caching and download manager.
- Notifications and deep links from push.

—
**Date:** 2025-08-18

