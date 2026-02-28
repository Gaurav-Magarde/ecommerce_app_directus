# Flutter E-Commerce App with Directus CMS

This repository contains a Flutter e-commerce application integrated with a locally hosted Directus CMS. The app features dynamic products and categories, server-side search, and a complete JWT-based authentication flow.

## 1. Directus Setup & Database Configuration

To run the backend locally, follow these steps:

1. Make sure you have Node.js installed on your machine.
2. Initialize a new Directus project via terminal:
   `npx directus init my-project`
3. **Database Configuration:** When prompted for the database, select **SQL (PostgreSQL or MySQL)**. Do not select MongoDB or SQLite. Enter your local SQL database credentials (username, password, database name).
4. Start the Directus server:
   `npx directus start`
5. The local server will be running at `http://localhost:8055` (or `http://127.0.0.1:8055`).
6. Go to the Directus Admin Panel -> Settings -> Access Policies -> Public, and give "Read" access to `directus_files` so images can load in the app.

## 2. Collection Schema

The following collections and fields were created in the Directus database:

**users (Extended System Collection)**
- `first_login_at` (Type: Datetime)
- `last_login_at` (Type: Datetime)

**categories (Custom Collection)**
- `id` (Auto-generated UUID)
- `name` (String)
- `description` (Text)
- `image` (Image/File)
- `is_active` (Boolean)

**products (Custom Collection)**
- `id` (Auto-generated UUID)
- `name` (String)
- `description` (Text)
- `price` (Decimal/Float)
- `discount_price` (Decimal/Float)
- `category` (Many-to-One Relationship with categories collection)
- `images` (Image/File)
- `stock` (Integer)
- `rating` (Float)
- `is_active` (Boolean)

## 3. API Endpoints Used

The Flutter app interacts with the following Directus REST API endpoints:

- `POST /auth/login` : To authenticate users and retrieve JWT tokens.
- `POST /auth/logout` : To invalidate the current session.
- `POST /users` : To sign up a new user.
- `GET /users/me` : To fetch current user data and verify the token.
- `PATCH /users/me` : To update `first_login_at` and `last_login_at` timestamps.
- `GET /items/categories` : To fetch the list of dynamic categories.
- `GET /items/products` : To fetch products. Used with `?fields=*.*` to expand relationships and custom JSON `filter` queries for the search functionality.

## 4. JWT Authentication Flow Explanation

The app handles authentication securely using JSON Web Tokens (JWT) provided by Directus:

1. **Login:** When a user enters their credentials, the app calls `/auth/login`.
2. **Storage:** Directus returns an `access_token` and a `refresh_token`. Both tokens are securely saved on the device using the `flutter_secure_storage` package.
3. **Protected Requests:** For any protected API call (like fetching user profile or updating login dates), the `access_token` is passed in the header: `Authorization: Bearer <token>`.
4. **Auto-Login:** When the app launches, it checks local storage for the JWT token. If it exists, it verifies it via `/users/me` and automatically logs the user in without requiring them to re-enter credentials.
5. **Logout:** The app sends the `refresh_token` to `/auth/logout` to end the session on the server, and then clears the local secure storage.