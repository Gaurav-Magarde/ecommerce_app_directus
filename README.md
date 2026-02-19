# E-Commerce App

A Flutter e-commerce application with authentication, product browsing, and detailed product views.

## Features

### 🔐 Authentication
- **Login Screen** with email and password validation
- Animated UI with gradient background
- Loading indicators during authentication
- Toast notifications for user feedback
- Form validation with error messages

### 🏠 Home Screen
- **Address Selector** at the top with multiple delivery addresses
- **Search Bar** for filtering products by name or category
- **Product Grid** displaying:
  - Product image
  - Product name
  - Price
  - Rating with stars
  - Favorite icon (toggle functionality)
- **Logout Button** in the app bar
- **View All** button to see complete product list

### 📱 Product Detail Screen
- Large product image with hero animation
- Category badge
- Product name and description
- Star rating with review count
- Price display
- Quantity selector
- Feature list with checkmarks
- Add to Cart button with total price calculation
- Share and favorite functionality

### 📋 View All Products Screen
- Complete product catalog
- Sort functionality:
  - Name (A-Z)
  - Price (Low to High)
  - Price (High to Low)
  - Rating (High to Low)
- Product count display
- Grid layout with favorite toggle

## Demo Credentials

Use these credentials to login:
- **Email**: test@example.com
- **Password**: password123

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── product.dart                   # Product model with sample data
│   └── user.dart                      # User model
└── screens/
    ├── login_screen.dart              # Authentication screen
    ├── home_screen.dart               # Main product browsing screen
    ├── product_detail_screen.dart     # Detailed product view
    └── view_all_screen.dart           # Complete product catalog
```

## Dependencies

- `flutter`: SDK
- `cupertino_icons`: iOS style icons
- `fluttertoast`: Toast notifications

## Getting Started

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Login with demo credentials:**
   - Email: test@example.com
   - Password: password123

## Key Highlights

- ✅ Material Design with custom theming
- ✅ Smooth animations and transitions
- ✅ Form validation
- ✅ Toast notifications for user feedback
- ✅ Navigation using Material Navigator
- ✅ State management for favorites
- ✅ Loading indicators
- ✅ Search functionality
- ✅ Sort functionality
- ✅ Responsive UI design
- ✅ Error handling for images
- ✅ Hero animations between screens

## Notes for Recruitment Task

This app demonstrates:
- Clean code structure and organization
- Proper use of Flutter widgets and navigation
- State management implementation
- User interaction handling
- Form validation and authentication flow
- Responsive and animated UI/UX
- Material Design principles

All features are fully functional with mock data for demonstration purposes.
