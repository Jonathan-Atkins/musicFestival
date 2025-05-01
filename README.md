# Happy Feet 🌟

Welcome to **Happy Feet**, a toe-tappin' full-stack music festival planner! Built to help users preview festivals, explore artist lineups, and save their must-see shows to a personalized schedule.

This README includes a full breakdown of setup, technologies used, API documentation, and all routes. Whether you're a curious developer, an API consumer, or just want to dance your way through some JSON — this one's for you.

---

## 🚀 Tech Stack

### Backend
- Ruby 3.2.3
- Rails 7.1.5.1
- PostgreSQL
- ActiveRecord
- JSONAPI::Serializer
- RSpec
- FactoryBot / Faker (for testing/seeds)

### Frontend
- React (via Vite)
- React Router DOM
- Context API (UserContext)
- Cypress (E2E testing)

---

## 📚 Getting Started

### Clone and Setup
```bash
git clone https://github.com/your-username/happy-feet
cd happy-feet
bundle install
rails db:{drop,create,migrate,seed}
```

To start the server:
```bash
rails s
```

Frontend repo setup (in /client or wherever it lives):
```bash
npm install
npm run dev
```

---

## 🛋️ Seeded Data
Happy Feet ships with:
- 3 pre-loaded **Festivals**
- 9 **Stages** (3 per festival)
- 27 **Shows** (each stage has 3 shows)
- 45 unique **Users**, each with a Schedule
- Every Show has exactly 5 attendees

---

## 🔎 API Overview

### Base URL
```
http://localhost:3000/api/v1
```

### Users
| Verb | Endpoint | Description |
|------|----------|-------------|
| GET | /users | List all users |
| POST | /users | Create a user |
| GET | /users/find?email= | Find a user by email |
| GET | /users/:id | Show a single user |

### Schedules (nested under users)
| Verb | Endpoint | Description |
|------|----------|-------------|
| GET | /users/:user_id/schedules | List user's schedules |
| GET | /users/:user_id/schedules/:id | Show one schedule (and its shows) |
| POST | /users/:user_id/schedules | Create a new schedule |

### Shows (nested under schedules or festivals)
| Verb | Endpoint | Description |
|------|----------|-------------|
| GET | /festivals/:festival_id/shows | Get shows by festival |
| GET | /users/:user_id/schedules/:schedule_id/shows | Get shows saved to schedule |
| POST | /users/:user_id/schedules/:schedule_id/shows | Add show to user's schedule |
| DELETE | /users/:user_id/schedules/:schedule_id/shows/:id | Remove show from schedule |

### Festivals
| Verb | Endpoint | Description |
|------|----------|-------------|
| GET | /festivals | Get all festivals |
| GET | /festivals/:id | Show one festival |

---

## 🎓 Notable Models & Relationships

- **User** has_one :schedule, has_many :shows through schedule
- **Schedule** belongs_to :user, has_many :schedule_shows, has_many :shows through schedule_shows
- **Show** belongs_to :stage, has_many :schedules through schedule_shows
- **Stage** belongs_to :festival
- **Festival** has_many :stages

---

## 🔖 Key Gems Used

| Gem | Use |
|-----|-----|
| `jsonapi-serializer` | Fast, flexible serialization |
| `faker` | Random, realistic seed data |
| `factory_bot_rails` | Clean test data factories |
| `rspec-rails` | Primary testing framework |

---

## 📖 Example API Calls

### Create a User
```http
POST /api/v1/users
Content-Type: application/json

{
  "user": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "john@example.com",
    "username": "johndoe123",
    "birthday": "1990-01-01"
  }
}
```

### Add Show to Schedule
```http
POST /api/v1/users/1/schedules/1/shows
Content-Type: application/json

{
  "show_id": 7
}
```

### Remove Show from Schedule
```http
DELETE /api/v1/users/1/schedules/1/shows/7
```

---

## 🍺 Fun Features

- Live attendee counts per festival
- Show cards with hover effects and actionable + / - buttons
- Friendly alerts for invalid or duplicate actions
- Global UserContext to persist login without localStorage
- Dynamic routes to nested resources

---

## 📊 Test Coverage

- RSpec: Model and request specs
- Cypress: Full E2E coverage for login, signup, navigation, and add/remove features

---

## 📘 Author

Made with rhythm by Jonathan Atkins — 2025 Turing School Module 3 Project

---

> “Feet, don’t fail me now…” — Happy Feet

