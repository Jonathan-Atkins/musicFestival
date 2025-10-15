# Happy Feet 🌟

Welcome to **Happy Feet**, a toe-tappin' full-stack music festival planner! Built to help users preview festivals, explore artist lineups, and save their must-see shows to a personalized schedule. Now featuring **real-time weather forecasts** for each festival ☄️

🚧 This project is still in development! Future features will include:

* Secure login with session persistence
* Festival and show **search** functionality
* Add and follow **friends** to track their schedules
* Improved **UI/UX** for a smoother experience
* And more exciting updates to come...

This README includes a full breakdown of setup, technologies used, API documentation, and all routes. Whether you're a curious developer, an API consumer, or just want to dance your way through some JSON — this one's for you.

---

## TL;DR

**Happy Feet** is a full-stack app where users:

* Explore festivals and artist lineups
* Add shows to their personal schedule
* Check the **weather forecast** at each festival location ☀️🌧️

---

## 🚀 Tech Stack

### Backend

* Ruby 3.2.3
* Rails 7.1.5.1
* PostgreSQL
* ActiveRecord
* JSONAPI::Serializer
* RSpec
* FactoryBot / Faker (for testing/seeds)

### Frontend

* React (via Vite)
* React Router DOM
* Context API (UserContext)
* Cypress (E2E testing)

---

## 📚 Getting Started

### Clone and Setup

- git clone https://github.com/your-username/happy-feet

- cd happy-feet
- bundle install
- rails db:{drop,create,migrate,seed}
```

To start the server:
```
  - rails s
```

Frontend repo setup (in /client or wherever it lives):

```
- npm install
- npm run dev
```
```

## 🏋️ Seeded Data

Happy Feet ships with:

* 3 pre-loaded **Festivals** (each with a ZIP code for weather data)
* 9 **Stages** (3 per festival)
* 27 **Shows** (each stage has 3 shows)
* 45 unique **Users**, each with a Schedule
* Every Show has exactly 5 attendees

---

## 🔎 API Overview

### Base URL

```
http://localhost:3000/api/v1
```

### Users

| Verb | Endpoint           | Description          |
| ---- | ------------------ | -------------------- |
| GET  | /users             | List all users       |
| POST | /users             | Create a user        |
| GET  | /users/find?email= | Find a user by email |
| GET  | /users/\:id        | Show a single user   |

### Schedules (nested under users)

| Verb | Endpoint                         | Description                       |
| ---- | -------------------------------- | --------------------------------- |
| GET  | /users/\:user\_id/schedules      | List user's schedules             |
| GET  | /users/\:user\_id/schedules/\:id | Show one schedule (and its shows) |
| POST | /users/\:user\_id/schedules      | Create a new schedule             |

### Shows (nested under schedules or festivals)

| Verb   | Endpoint                                              | Description                 |
| ------ | ----------------------------------------------------- | --------------------------- |
| GET    | /festivals/\:festival\_id/shows                       | Get shows by festival       |
| GET    | /users/\:user\_id/schedules/\:schedule\_id/shows      | Get shows saved to schedule |
| POST   | /users/\:user\_id/schedules/\:schedule\_id/shows      | Add show to user's schedule |
| DELETE | /users/\:user\_id/schedules/\:schedule\_id/shows/\:id | Remove show from schedule   |

### Festivals

| Verb | Endpoint        | Description                                  |
| ---- | --------------- | -------------------------------------------- |
| GET  | /festivals      | Get all festivals (with weather info)        |
| GET  | /festivals/\:id | Show one festival (with artists and weather) |

---

## 🎓 Notable Models & Relationships

* **User** has\_one \:schedule, has\_many \:shows through schedule
* **Schedule** belongs\_to \:user, has\_many \:schedule\_shows, has\_many \:shows through schedule\_shows
* **Show** belongs\_to \:stage, has\_many \:schedules through schedule\_shows
* **Stage** belongs\_to \:festival
* **Festival** has\_many \:stages

---

## 🔖 Key Gems Used

| Gem                  | Use                            |
| -------------------- | ------------------------------ |
| `jsonapi-serializer` | Fast, flexible serialization   |
| `faker`              | Random, realistic seed data    |
| `factory_bot_rails`  | Clean test data factories      |
| `rspec-rails`        | Primary testing framework      |
| `faraday`            | HTTP client for weather API    |
| `dotenv-rails`       | Securely store weather API key |

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

### Get All Festivals (with Weather)

```http
GET /api/v1/festivals
```

Sample response:

```json
{
  "id": "1",
  "name": "GrooveFest 2025",
  "zip_code": "78704",
  "attendee_count": 125,
  "artists": ["Run the Jewels", "Sylvan Esso"],
  "weather": {
    "day_outlook": "Partly Cloudy",
    "temperature_low": "68°F 🥶",
    "temperature_high": "91°F🥵"
  }
}
```

---

## 🍺 Fun Features

* Live attendee counts per festival
* Show cards with hover effects and actionable + / - buttons
* Friendly alerts for invalid or duplicate actions
* Global UserContext to persist login without localStorage
* Dynamic routes to nested resources
* ☄️ **Weather Forecasts** included for each festival based on ZIP code

---

## ☀️ Weather Integration (OpenWeatherMap)

Each festival includes a live forecast pulled from OpenWeatherMap’s current weather API. This lets users plan their outfits, gear, or mood accordingly.

* Powered by [OpenWeatherMap](https://openweathermap.org/current)
* Weather is cached to minimize API calls
* If the weather fetch fails, users see a light-hearted fallback message like:
  `"Something went wrong — maybe look outside yourself"`

---

## 📊 Test Coverage

* RSpec: Model and request specs (including weather serialization)
* Cypress: Full E2E coverage for login, signup, navigation, add/remove shows

---

## 📘 Author

Made with rhythm by **Jonathan Atkins**
2025 Turing School Module 3 Solo Project

---

> “Feet, don’t fail me now…” — *Happy Feet*
### Sessions

| Verb | Endpoint | Description                     |
| ---- | -------- | ------------------------------- |
| POST | /login   | Start a session for a user      |
| GET  | /me      | Return the currently logged-in user |
| DELETE | /logout | End the current session         |

