# 🎫 EventEase Mobile – Event Booking Platform

## 📋 Table of Contents
1. [Project Overview](#project-overview)
2. [Objectives](#objectives)
3. [User Roles & Stories](#user-roles--stories)
4. [Core Features](#core-features)
5. [Bonus Features](#bonus-features)
6. [Tech Stack](#tech-stack)
7. [System Architecture](#system-architecture)
8. [Frontend (Flutter)](#frontend-flutter)
9. [Backend (API)](#backend-api)
10. [Database Schema](#database-schema)
11. [Authentication Flow](#authentication-flow)
12. [State Management](#state-management)
13. [Installation & Setup](#installation--setup)
    - [Frontend Setup](#frontend-setup)
    - [Backend Setup](#backend-setup)
14. [Run Commands](#run-commands)
15. [API Endpoints](#api-endpoints)
16. [Booking ID Generation Logic](#booking-id-generation-logic)
17. [Folder Structure](#folder-structure)
18. [Deployment (Optional)](#deployment-optional)
19. [Evaluation Criteria](#evaluation-criteria)
20. [License](#license)

---

## 🧩 Project Overview
**EventEase Mobile** is a cross-platform **event booking application** built using **Flutter & Dart**.  
The app allows users to explore events, book tickets, and manage their bookings.  
It is powered by a **REST/GraphQL backend** with a **PostgreSQL database**, ensuring scalability and data integrity.

---

## 🎯 Objectives
- Build a functional and responsive event booking mobile app using Flutter.  
- Integrate with a secure backend API for event data, authentication, and booking logic.  
- Implement role-based access (User/Admin).  
- Ensure proper booking validation and status tracking.  
- Maintain clean architecture and readable code.  

---

## 👥 User Roles & Stories

### Public User
- View home screen introducing EventEase.
- Browse available events (title, date, location).
- Register or log in.

### Logged-in User
- Book **1 seat per event**.
- View and cancel bookings (if event hasn’t started).
- View booking confirmation and status.

### Admin (Backend Only)
- Manage events (Create, Update, Delete).
- Set event capacity.
- Monitor bookings via API.

---

## 🚀 Core Features
- **Event Listings:** Display title, date, location, and description.
- **Booking Logic:** Restrict 1 booking per user per event; prevent overbooking.
- **Event Status:** Automatically calculated as *Upcoming*, *Ongoing*, or *Completed*.
- **Authentication:** Secure JWT-based login & registration.
- **Role-based Access:** Separate logic for admin and user.
- **Logging Middleware:** Track every booking with timestamp & user ID.

---

## Features
- Event search & filter (by date/location/category).
- Remaining seat availability display.
- Booking calendar view.
- Booking confirmation via mock email or PDF.
- CI/CD with GitHub Actions.
- Dockerized backend deployment (Render, Railway, or Heroku).
- Flutter widget/unit tests.

---

## 🛠 Tech Stack

### Frontend:
- **Framework:** Flutter  
- **Language:** Dart  
- **State Management:** Provider
- **UI Design:** Material Design 3  

### Backend:
- **Language:** Node.js (Express)
- **Database:** PostgreSQL  
- **ORM:** Sequelize / Prisma / SQLAlchemy
- **Authentication:** JWT (JSON Web Token)  
- **API Type:** REST
- **Deployment:** Render / Railway / Heroku  

---

## 🏗 System Architecture
Mobile App (Flutter)
|
v
Backend API (Node.js/Django/FastAPI)
|
v
PostgreSQL Database



---

## 📱 Frontend (Flutter)
- Displays event list and details fetched from backend.
- Implements JWT authentication.
- Responsive UI for both Android & iOS.
- Booking confirmation & status screens.

---

## ⚙️ Backend (API)
The backend provides a secure REST/GraphQL API for:
- Authentication (`/api/auth/register`, `/api/auth/login`)
- Events (`/api/events`)
- Bookings (`/api/bookings`)

It validates booking limits, checks event capacity, and updates event status dynamically.

---

## 🗃 Database Schema

### Table: `users`
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| name | String | User’s name |
| email | String | Unique user email |
| password | String (hashed) | Password |
| role | String | `user` or `admin` |

### Table: `events`
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| title | String | Event title |
| description | Text | Event description |
| date | Date | Event date |
| location | String | Event venue |
| capacity | Int | Max seats |
| created_at | Timestamp | Creation date |

### Table: `bookings`
| Column | Type | Description |
|--------|------|-------------|
| id | UUID | Primary key |
| booking_id | String | Auto-generated booking code |
| user_id | UUID | FK to users |
| event_id | UUID | FK to events |
| status | String | `active` / `cancelled` |
| created_at | Timestamp | Booking date |

---

## 🔐 Authentication Flow
1. User registers or logs in.
2. Backend issues JWT token.
3. Flutter stores token locally (SecureStorage).
4. All protected API routes require `Authorization: Bearer <token>`.

---

## 🧠 State Management
- **Provider** (recommended): For managing app-wide states (auth, events, bookings).
- **ChangeNotifier**: To update UI reactively.
- **SharedPreferences/SecureStorage**: To persist JWT tokens.

Alternative (optional): **Riverpod**, **Bloc**, or **GetX** can also be used.

---

## 🧩 Installation & Setup

### 🔹 Frontend Setup
```bash
# Clone the repository
git clone https://github.com/Gouravlamba/EventEase-Event-Booking-App.git

# Navigate to frontend folder
cd EventEaseMobile

# Get dependencies
flutter pub get

# Run the app
flutter run

🔹 Backend Setup (Example: Node.js + Express)
# Navigate to backend folder
cd backend

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env

# Update .env file
DATABASE_URL=postgresql://user:password@localhost:5432/eventease
JWT_SECRET=your_jwt_secret

# Run database migrations (if using Sequelize/Prisma)
npx prisma migrate dev

# Start the server
npm start


🧾 Run Commands
flutter pub get
flutter run
flutter build apk --release

Backend
npm run dev       # For development
npm start         # For production



API Endpoints
Authentication
Method	Endpoint	Description
POST	/api/auth/register	Register new user
POST	/api/auth/login	Login & receive JWT
Events
Method	Endpoint	Description
GET	/api/events	Get all events
GET	/api/events/:id	Get event details
POST	/api/events	Create event (Admin)
PUT	/api/events/:id	Update event (Admin)
DELETE	/api/events/:id	Delete event (Admin)
Bookings
Method	Endpoint	Description
POST	/api/bookings	Create booking
GET	/api/bookings	Get user bookings
DELETE	/api/bookings/:id	Cancel booking
🔢 Booking ID Generation Logic

Format:

BKG-[MMM][YYYY]-[Random3]
Example: BKG-SEP2025-K7X


Generated in backend upon booking creation.

📂 Folder Structure
EventEase/
│
├── frontend/               # Flutter app
├── backend/                # Node.js / Django / FastAPI backend
├── README.md
└── postman_collection.json

📱 Flutter Folder Structure (frontend/)
frontend/
│
├── lib/
│   ├── main.dart
│   │
│   ├── config/
│   │   ├── app_colors.dart
│   │   ├── app_constants.dart
│   │   ├── api_endpoints.dart
│   │   └── theme.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   │   ├── event_model.dart
│   │   │   ├── booking_model.dart
│   │   │   └── user_model.dart
│   │   ├── services/
│   │   │   ├── api_service.dart
│   │   │   ├── auth_service.dart
│   │   │   ├── event_service.dart
│   │   │   └── booking_service.dart
│   │   └── repository/
│   │       ├── event_repository.dart
│   │       └── booking_repository.dart
│   │
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── auth/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── register_screen.dart
│   │   │   ├── home/
│   │   │   │   ├── home_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── events/
│   │   │   │   ├── events_screen.dart
│   │   │   │   ├── event_detail_screen.dart
│   │   │   │   └── widgets/
│   │   │   ├── bookings/
│   │   │   │   ├── bookings_screen.dart
│   │   │   │   ├── booking_detail_screen.dart
│   │   │   │   └── calendar_view.dart
│   │   │   └── profile/
│   │   │       └── profile_screen.dart
│   │   ├── widgets/
│   │   │   ├── bottom_navbar.dart
│   │   │   ├── event_card.dart
│   │   │   ├── booking_card.dart
│   │   │   └── custom_button.dart
│   │   └── styles/
│   │       ├── text_styles.dart
│   │       └── spacing.dart
│   │
│   ├── state_management/
│   │   ├── providers/
│   │   │   ├── auth_provider.dart
│   │   │   ├── event_provider.dart
│   │   │   └── booking_provider.dart
│   │   └── blocs/ (optional, if using BLoC instead of Provider)
│   │
│   ├── utils/
│   │   ├── helpers.dart
│   │   ├── formatters.dart
│   │   └── pdf_generator.dart
│   │
│   ├── test/
│   │   ├── widget_tests/
│   │   │   ├── event_card_test.dart
│   │   │   └── booking_widget_test.dart
│   │   └── unit_tests/
│   │       ├── api_service_test.dart
│   │       └── booking_logic_test.dart
│   │
│   └── main_app.dart
│
└── pubspec.yaml
⚙️ Backend Folder Structure (backend/)
backend/
│
├── src/
│   ├── index.js
│   ├── config/
│   │   ├── db.js
│   │   ├── jwt_config.js
│   │   └── settings.js
│   ├── models/
│   │   ├── user_model.js
│   │   ├── event_model.js
│   │   └── booking_model.js
│   ├── routes/
│   │   ├── auth_routes.js
│   │   ├── event_routes.js
│   │   ├── booking_routes.js
│   │   └── admin_routes.js
│   ├── services/
│   │   ├── booking_service.js
│   │   ├── event_service.js
│   │   └── pdf_service.js
│   ├── middleware/
│   │   ├── auth_middleware.js
│   │   └── logger_middleware.js
│   └── utils/
│       ├── booking_id_generator.js
│       └── date_utils.js
│
├── package.json
└── README.md


---

Would you like me to generate a **sample `.gitignore` file** next (specifically for Flutter + Node.js projects) so your repo stays clean when you push it to GitHub?

