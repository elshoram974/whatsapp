# WhatsApp-Style Flutter App (No codegen, plain go_router)

Clean Architecture, `flutter_bloc`, plain `go_router` (no typed routes), `easy_localization`, local JSON mocks, and tests.

## Run
1. `flutter pub get`
2. `flutter run`

## Lint and tests
- `flutter analyze`
- `flutter test`

## Routes
- `/` (Home)
- `/chat/:chatId` (Chat)
- `/stories` (Stories)
- `/stories/:storyId` (Story Viewer)

Deep links:
- Android intent-filter and iOS URL scheme `myapp`.

## Localization
- `easy_localization` JSON files in `assets/translations/{en,ar}.json`