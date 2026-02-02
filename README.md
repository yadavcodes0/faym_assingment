# Collections Screen - Flutter Assignment

A Flutter app with accordion-style expandable product collections, intelligent dynamic badges, and fully responsive design.

## Features

- ✅ Accordion behavior (one collection open at a time) 
- ✅ Horizontally scrollable product images 
- ✅ Smart +N badge (updates dynamically as you scroll) 
- ✅ Fully responsive (MediaQuery-based scaling) 
- ✅ Smooth animations (300ms) 

## Project Structure

```
lib/
├── main.dart                    # Entry point
├── models/collection.dart       # Data model
├── screens/collections_screen.dart  # Main screen
└── widgets/collection_card.dart     # Expandable card widget
```

## How It Works

### Intelligent Badge System

- Calculates visible images based on viewport width
- Updates badge count in real-time during scroll
- Positioned outside scrollable area for constant visibility

### Responsive Design

All dimensions scale with screen width using MediaQuery:

- Images: 17% of screen width
- Padding: 4% of screen width
- Fonts: 3.9% (title), 2.9% (badge)

## Approach

### 1. Data Model

Created a simple `Collection` class with 10 sample collections (3-9 images each) to demonstrate badge functionality.

### 2. Component Architecture

- **CollectionCard**: StatefulWidget managing scroll state and badge calculation
- **CollectionsScreen**: Manages accordion state (`_expandedCollectionId`)
- Clean separation of concerns for maintainability

### 3. Responsive Strategy

Used MediaQuery percentages instead of fixed pixels:

```dart
final imageSide = screenWidth * 0.17;  // Scales with any screen
```

This ensures zero overflow on any device (320px - 600px+).

### 4. Smart Badge Logic

Badge calculation accounts for:

- Viewport width (available space)
- Item width (image + spacing)
- Current scroll offset
- Partial visibility threshold

Updates in real-time via `ScrollController.addListener()`.

### 5. Animation

`AnimatedCrossFade` provides smooth 300ms transitions without custom controllers, keeping code simple and performant.

## Installation & Run

```bash
git clone https://github.com/yadavcodes0/faym_assingment.git
cd faym_assingment
flutter pub get
flutter run
```

## Assignment Compliance

✅ Scrollable collection cards
✅ Expandable/collapsible with accordion behavior
✅ Horizontal product images
✅ Dynamic +N badge
✅ Rounded corners & elevation
✅ Smooth animations
✅ Builds & runs successfully
**Bonus:** Fully responsive + scroll-aware badge system

## Technical Stack

- Flutter 3.6.2+
- Material Design 3
- StatefulWidget with setState
- AnimatedCrossFade for transitions
- MediaQuery for responsiveness

## Key Implementation Details

**Dynamic Badge Calculation:**

```dart
// Calculates visible images based on viewport & scroll position
int _getVisibleImageCount() {
  viewport width / (image width + spacing) + scroll offset
}
```

**Responsive Sizing:**

```dart
final imageSide = screenWidth * 0.17;
final padding = screenWidth * 0.04;
```

---


