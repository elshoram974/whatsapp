# WhatsApp UI Clone (Flutter)

## Summary
A WhatsApp-style UI built with Flutter. Goal: reproduce core screens with high fidelity using local mock data to demonstrate user flow.

## Implemented Screens
- **Chat List:** name, last message, time, and unread badge.
- **Chat:** sent and received bubbles with timestamps, input field, and send action.
- **Stories:** contacts list with a story count per contact.
- **Story Viewer:** full-screen image with a top progress indicator.

## Tech
- Flutter and Dart.
- Local mock data under `assets`.
- Responsive layouts for multiple screen sizes.
- Light and dark themes.

## Run Locally
1. Install Flutter (stable channel).
2. From the project root:
   ```bash
   flutter pub get
   flutter run
   ```

## Screenshots

![Screenshot 1](screenshots/01.png)
![Screenshot 2](screenshots/02.png)
![Screenshot 3](screenshots/03.png)
![Screenshot 4](screenshots/04.png)
![Screenshot 5](screenshots/05.png)

---

**Notes**  
- Images are for README illustration only.  
- Mock data can be replaced with a real backend or Firebase later.
