# VTV ID SDK for iOS & tvOS

VTV ID authentication SDK for iOS and tvOS applications, supporting OAuth 2.0 with PKCE and QR code login for tvOS.

## Requirements

- iOS 15.0+ / tvOS 15.0+
- Swift 5.9+
- Xcode 15+

## Project Structure

```
VTV-ID-SDK-IOS/
├── Package.swift                    # Swift Package Manager config
├── Sources/
│   └── VtvIdSdk/
│       ├── Public/                  # Public API
│       │   ├── VtvIdSdk.swift       # Entry point - SDK initialization & configuration
│       │   ├── Client/
│       │   │   ├── VtvAuthClient.swift      # Authentication protocol (login, logout, refresh token)
│       │   │   ├── VtvProfileClient.swift   # User profile management protocol
│       │   │   └── VtvQrClient.swift        # QR code login protocol (tvOS)
│       │   └── Models/
│       │       ├── Environment.swift        # Environment configuration (local, dev, staging, production)
│       │       ├── IdentityProvider.swift    # Identity providers (VTV ID, Google, Facebook, Apple, VNEID)
│       │       ├── LogLevel.swift           # Log level configuration
│       │       ├── QrLoginState.swift       # QR login state machine
│       │       ├── QrSession.swift          # QR session model
│       │       ├── VtvAuthState.swift       # Authentication state
│       │       ├── VtvError.swift           # Error definitions
│       │       ├── VtvResult.swift          # Result type
│       │       └── VtvUser.swift            # User model
│       └── Internal/                # Internal implementation
│           ├── Client/
│           │   ├── VtvAuthClientImpl.swift       # VtvAuthClient implementation
│           │   ├── VtvProfileClientImpl.swift    # VtvProfileClient implementation
│           │   └── VtvQrClientImpl.swift         # VtvQrClient implementation
│           ├── Data/
│           │   ├── Local/
│           │   │   ├── KeychainHelper.swift      # Keychain access
│           │   │   ├── SecureStorage.swift        # Secure storage
│           │   │   └── TokenManager.swift         # Access/refresh token management
│           │   ├── Remote/
│           │   │   ├── NetworkClient.swift        # HTTP client
│           │   │   └── DTO/
│           │   │       ├── QrSessionDto.swift     # QR session DTO
│           │   │       ├── TokenResponseDto.swift # Token response DTO
│           │   │       └── UserInfoDto.swift      # User info DTO
│           │   └── Repository/
│           │       ├── AuthRepositoryImpl.swift    # AuthRepository implementation
│           │       └── ProfileRepositoryImpl.swift # ProfileRepository implementation
│           ├── Domain/
│           │   ├── Repository/
│           │   │   ├── AuthRepository.swift        # Authentication repository interface
│           │   │   └── ProfileRepository.swift     # Profile repository interface
│           │   └── UseCase/
│           │       ├── Auth/
│           │       │   ├── LoginUseCase.swift
│           │       │   ├── LogoutUseCase.swift
│           │       │   └── RefreshTokenUseCase.swift
│           │       └── Profile/
│           │           ├── GetProfileUseCase.swift
│           │           └── UpdateProfileUseCase.swift
│           ├── OAuth/
│           │   ├── OAuthManager.swift     # OAuth 2.0 flow manager
│           │   └── PkceGenerator.swift    # PKCE code challenge generator
│           ├── Qr/
│           │   ├── QrCodeGenerator.swift   # QR code image generation
│           │   ├── QrWebSocketHandler.swift # WebSocket handler for QR login state
│           │   └── VtvGoAppChecker.swift    # VTV Go app detection
│           └── Util/
│               ├── Logger.swift           # Logging utility
│               └── PlatformDetector.swift # iOS/tvOS platform detection
├── Tests/
│   └── VtvIdSdkTests/
│       └── TokenManagerTests.swift
├── Sample/                              # Sample iOS application
│   ├── Podfile
│   ├── VTV-ID-IOS.xcworkspace/
│   └── VTV-ID-IOS/
│       ├── App/VTVIDApp.swift           # App entry point
│       ├── Views/
│       │   ├── HomeView.swift           # Home screen (login/user info)
│       │   └── ProfileView.swift        # User profile & linked accounts
│       ├── Services/
│       │   ├── AuthManager.swift        # Auth state management
│       │   └── APIService.swift         # API client for backend
│       ├── Models/
│       │   ├── APIResponse.swift        # API response & error models
│       │   └── AuthProvider.swift       # Auth provider enum
│       └── Extensions/
│           └── VtvUser+Convenience.swift  # VtvUser display helpers
└── Sample-tvOS/                         # Sample tvOS application
    ├── Podfile
    ├── VTV-ID-tvOS.xcworkspace/
    └── VTV-ID-tvOS/
        ├── App/VTVIDTvApp.swift         # App entry point
        └── Views/
            ├── ContentView.swift        # Root view
            ├── QrLoginView.swift        # QR code login screen
            └── HomeView.swift           # User profile display
```

## Sample Apps

### iOS Sample

1. Install CocoaPods dependencies:
   ```bash
   cd Sample
   pod install
   ```

2. Open `Sample/VTV-ID-IOS.xcworkspace` in Xcode (use `.xcworkspace`, not `.xcodeproj`)

3. Update SDK configuration in `Sample/VTV-ID-IOS/App/VTVIDApp.swift`:
   ```swift
   VtvIdSdk.initialize(config: VtvIdSdk.Config(
       clientId: "your-client-id",
       redirectUri: "vtvid://callback",
       environment: .development,
       logLevel: .debug
   ))
   ```

4. Select a simulator or device, then **Cmd+R** to build and run

### tvOS Sample

1. Install CocoaPods dependencies:
   ```bash
   cd Sample-tvOS
   pod install
   ```

2. Open `Sample-tvOS/VTV-ID-tvOS.xcworkspace` in Xcode

3. Update SDK configuration in `Sample-tvOS/VTV-ID-tvOS/App/VTVIDTvApp.swift`

4. Select an Apple TV simulator, then **Cmd+R** to build and run

The tvOS sample uses QR code login — scan the QR code with the VTV Go app on your phone to authenticate.

## Setup

### 1. Add SDK to your project

#### Swift Package Manager (Recommended)

In Xcode, go to **File > Add Package Dependencies...**, enter the URL:

```
https://github.com/TrungLQ-AIP-HN/vtv-id-sdk-ios-package
```

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/TrungLQ-AIP-HN/vtv-id-sdk-ios-package", from: "1.0.0")
]
```

Then import in your code:

```swift
import VtvIdSdk
```

### 2. Configure URL Scheme (iOS only)

Add the `vtvid` URL scheme to your `Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>vtvid</string>
        </array>
    </dict>
</array>
```

### 3. Initialize the SDK

Initialize the SDK in `AppDelegate` or `App.init`:

```swift
import VtvIdSdk

@main
struct MyApp: App {
    init() {
        VtvIdSdk.initialize(config: VtvIdSdk.Config(
            clientId: "your-client-id",
            redirectUri: "vtvid://callback",
            environment: .production
        ))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

Configuration parameters:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `clientId` | `String` | *required* | OAuth 2.0 client ID provided by VTV |
| `redirectUri` | `String` | *required* | OAuth callback URI (must use `vtvid://` scheme) |
| `environment` | `Environment` | `.production` | `.local`, `.development`, `.staging`, `.production` |
| `logLevel` | `LogLevel` | `.none` | `.none`, `.error`, `.warning`, `.info`, `.debug` |
| `scopes` | `[String]` | `["openid", "profile", "email"]` | OAuth scopes |

## Usage

### Login (iOS)

```swift
let sdk = VtvIdSdk.shared

let result = await sdk.auth.login(provider: .vtvId)
switch result {
case .success(let user):
    print("Hello, \(user.fullName ?? user.id)")
case .error(let error):
    print("Error: \(error.localizedDescription)")
}
```

Supported identity providers: `.vtvId`, `.google`, `.facebook`, `.apple`, `.vneid`

### QR Login (tvOS)

```swift
import Combine

// Start QR login
await VtvIdSdk.shared.qr.startLogin()

// Observe QR login state
VtvIdSdk.shared.qr.loginStatePublisher
    .receive(on: DispatchQueue.main)
    .sink { state in
        switch state {
        case .idle:
            print("Ready to login")
        case .qrGenerated(_, _, let qrImage, _, let remaining):
            // Display qrImage (CGImage) on screen
            print("QR generated, expires in \(remaining)s")
        case .scanning:
            print("QR scanned, waiting for confirmation")
        case .confirming:
            print("Confirming login...")
        case .success(let user):
            print("Logged in: \(user.fullName ?? user.id)")
        case .timeout:
            print("QR expired")
        case .error(let error):
            print("Error: \(error)")
        default:
            break
        }
    }
    .store(in: &cancellables)

// Cancel QR login
VtvIdSdk.shared.qr.cancelLogin()
```

### Logout

```swift
let result = await sdk.auth.logout()
```

### Get user profile

```swift
let result = await sdk.profile.getProfile()
switch result {
case .success(let user):
    print("Email: \(user.email ?? "N/A")")
case .error(let error):
    print("Error: \(error.localizedDescription)")
}
```

### Update profile

```swift
let result = await sdk.profile.updateProfile {
    $0.firstName("Nguyen")
      .lastName("Van A")
      .phone("+84123456789")
}
```

### Observe authentication state

```swift
import Combine

sdk.auth.authStatePublisher
    .sink { state in
        switch state {
        case .unauthenticated:
            print("Not logged in")
        case .loading:
            print("Loading...")
        case .authenticated(let user, _, _):
            print("Logged in: \(user.id)")
        case .error(let error):
            print("Error: \(error)")
        }
    }
    .store(in: &cancellables)
```

### Check authentication status & get token

```swift
if sdk.auth.isAuthenticated() {
    let token = sdk.auth.getAccessToken()
    let user = sdk.auth.getCurrentUser()
}
```

### Refresh token

```swift
let result = await sdk.auth.refreshToken()
switch result {
case .success(let newToken):
    print("New token: \(newToken)")
case .error(let error):
    print("Refresh error: \(error)")
}
```
