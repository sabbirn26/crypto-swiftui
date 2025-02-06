# SwyptoTracker 📈
[![Swift](https://img.shields.io/badge/Swift-5.5-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-green.svg)](https://developer.apple.com/xcode/swiftui/)

SwyptoTracker is a modern iOS cryptocurrency tracking application built with SwiftUI. It allows users to monitor real-time cryptocurrency prices, manage their portfolio, and view detailed analytics for different coins.

Screenshots 📱
<table>
  <tr>
    <td align="center">
      <img src="/screenshots/launch.png" width="250" alt="Launch Screen"/><br/>
      <em>Launch Screen</em>
    </td>
    <td align="center">
      <img src="/screenshots/home.png" width="250" alt="Home Screen"/><br/>
      <em>Home Screen</em>
    </td>
    <td align="center">
      <img src="/screenshots/details.png" width="250" alt="Details Screen"/><br/>
      <em>Details Screen</em>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="/screenshots/portfolio.png" width="250" alt="Portfolio Screen"/><br/>
      <em>Portfolio Screen</em>
    </td>
    <td align="center">
      <img src="/screenshots/addcoin.png" width="250" alt="Add Coin Screen"/><br/>
      <em>Add Coin Screen</em>
    </td>
    <td align="center">
      <img src="/screenshots/settings.png" width="250" alt="Settings Screen"/><br/>
      <em>Settings Screen</em>
    </td>
  </tr>
</table>
## Features 🚀

- **Real-time Cryptocurrency Tracking**
  - Live price updates
  - Price change percentages
  - Market cap rankings
  - 7-day price charts with animations

- **Portfolio Management**
  - Add coins to your portfolio
  - Track holdings value
  - Calculate profit/loss
  - Sort by different metrics
  - Persistent storage using Core Data

- **Detailed Analytics**
  - Interactive price charts
  - Market statistics
  - Coin information and description
  - External links to websites and communities

- **Advanced Features**
  - Custom search functionality
  - Multiple sorting options
  - Local data persistence using CoreData
  - Responsive UI with dark mode support
  - Smooth animations and transitions

## App Demo 🎥

| Feature               | Demo |
|----------------------|------|
| **Portfolio Management** <br> - Add/remove coins from portfolio <br> - Real-time value calculations <br> - Persistent storage using Core Data | <img src="/demos/portfolio-demo.gif" width="250"> |
| **Price Tracking** <br> - Live price updates <br> - Interactive charts <br> - Market statistics | <img src="/demos/price-tracking.gif" width="250"> |
| **Search and Sort** <br> - Dynamic search functionality <br> - Multiple sorting options <br> - Smooth animations | <img src="/demos/search-demo.gif" width="250"> |
| **App Settings** <br> - App information and credits <br> - Developer profile <br> - CoinGecko attribution <br> - Dark/Light mode support | <img src="/demos/settings-demo.gif" width="250"> |


## Technology Stack 💻

- **Framework:** SwiftUI
- **Architecture:** MVVM
- **Data Persistence:** CoreData
- **Networking:** Combine
- **API:** CoinGecko
- **Minimum iOS Version:** iOS 14.0

## Core Data Implementation 💾

The app uses Core Data for persistent storage of portfolio data:

- **Entity:** PortfolioEntity
  - coinID: String
  - amount: Double
  
- **Features:**
  - Automatic persistence of portfolio holdings
  - Efficient data fetching and updates
  - Thread-safe operations
  - CRUD operations for portfolio management

## Installation 🔧

1. Clone the repository
```bash
git clone https://github.com/sabbirn26/SwyptoTracker.git
```

2. Open the project in Xcode
```bash
cd SwyptoTracker
open SwyptoTracker.xcodeproj
```

3. Install dependencies (if any)

4. Build and run the project


## Architecture 🏗

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models:** `CoinModel`, `StatisticModel`, `MarketDataModel`, `CoinDetailsModel`
- **Views:** `HomeView`, `PortfolioView`, `DetailView`, `SettingsView`, `LaunchView`,`CoinRowView`, `CoinImageView`
- **ViewModels:** `HomeViewModel`, `PortfolioViewModel`, `DetailsViewModel`
- **Services:** `CoinDataService`, `PortfolioDataService`, `MarketDataService`, `CoinDetailsDataService`, `CoinImageService`
- **Extension:** `Color`, `PreviewProvider`, `Double`, `UIApplication`, `Date` , `String`
- **Utilities:** `NetworkingManager`, `LocalFileManager`, `HapticManager`
- **Components:** `SearchBarView`, `StatisticView`, `XmarkButton`

## Data Flow 🔄

1. Data is fetched from CoinGecko API using Combine
2. ViewModels process and transform the data
3. Views react to @Published properties in ViewModels
4. CoreData manages portfolio persistence with following flow:
   - Read: CoreData → PortfolioDataService → ViewModel → View
   - Write: View → ViewModel → PortfolioDataService → CoreData

## Contributions 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📝

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments 👏

- [CoinGecko API](https://www.coingecko.com/en/api) for cryptocurrency data
- [SwiftfulThinking](https://www.youtube.com/@SwiftfulThinking) for SwiftUI tutorials and inspiration

## Contact 📫

Sabbir Nasir
- LinkedIn: [Sabbir Nasir](https://www.linkedin.com/in/sabbirn26/)
- GitHub: [@sabbirn26](https://github.com/sabbirn26)

