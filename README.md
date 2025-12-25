# E-Commerce FYP - Flutter Project

This is a comprehensive e-commerce application built with Flutter, integrated with Firebase for authentication and data management. It features a complete testing suite covering unit, UI, and performance tests.

## 🚀 Key Features

### 1. Firebase Integration
-   **Authentication**: Login and Signup with email/password.
-   **Firestore Database**:
    -   **Users**: Stores user profiles.
    -   **Products**: Dynamic product listing with categories (T-Shirts, Jeans, Shoes, etc.).
    -   **Orders**: Real-time order placement and tracking.
-   **Automatic Seeding**: The app detects if the database is empty and automatically seeds it with mock product data for testing.

### 2. State Management
-   **GetX**: Used for reactive state management, dependency injection, and route management (`AuthController`, `CartController`, `HomeTabController`).

---

## 🧪 Testing Suite

This project includes a robust 3-layer testing strategy:

### 1. White Box Testing (Unit Tests)
Verified the internal logic of services and controllers using `mockito` and `fake_cloud_firestore`.

-   **AuthService**: Tested Signup, Login, and Logout functionality.
-   **FirestoreService**: Tested product fetching and order creation.
-   **CartController**: Tested cart operations (add, remove, update quantity, total calculation).

**Run Unit Tests:**
```bash
flutter test test/unit
```

### 2. Black Box Testing (UI Integration Tests)
Verified the user interface and navigation flows.

-   **Auth UI**: Verified Login/Signup form validation and navigation.
-   **Shopping UI**: Verified Home screen layout, category switching, and search bar.

**Run UI Tests:**
```bash
flutter test test/widget
```

### 3. Performance Testing (Backend Simulation)
A custom Python simulation script (`perf_simulation.py`) was used to stress-test the storage and backend logic.

**Latest Results:**
| Test Type | Scenario | Metrics (Avg / P95) | Status |
| :--- | :--- | :--- | :--- |
| **Load Test** | 20 Concurrent Users | 0.289s / 0.487s | ✅ PASS |
| **Stress Test** | 100 Concurrent Users | 0.417s / 0.675s | ✅ PASS |
| **Spike Test** | Sudden Traffic Surge | 0.437s / 0.668s | ✅ PASS |
| **Volume Test** | 1000 Products Fetch | 0.469s / 0.875s | ✅ PASS |
| **Capacity Test** | 50 Simultaneous Checkouts | 0.479s / 0.697s | ✅ PASS |

**Run Performance Simulation:**
```bash
python test/performance/perf_simulation.py
```

---

## 📂 Project Structure

-   `lib/data/services`: Firebase interaction layers (`AuthService`, `FirestoreService`).
-   `lib/screens`: UI screens grouped by feature (Auth, Home, Cart).
-   `lib/screens/*/controller`: GetX controllers for business logic.
-   `test/unit`: Unit tests for services and controllers.
-   `test/widget`: UI/Widget tests.
-   `test/performance`: Python scripts for backend load testing.

## 🛠️ Setup & Installation

1.  **Clone the repository**.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Run the app**:
    ```bash
    flutter run
    ```
    *Note: Ensure your emulator or device has internet access for Firebase connectivity.*
