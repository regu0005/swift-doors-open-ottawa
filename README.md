# Doors Open Ottawa - iOS App

Welcome to the official repository for the **Doors Open Ottawa** iOS app, an application designed to provide users with an immersive experience during the annual Doors Open Ottawa event. 

## About the Project

**Doors Open Ottawa** is an esteemed annual event that offers an exclusive glimpse into Ottawa’s most intriguing and historically significant buildings. The event celebrates the city's vibrant history by granting access to a diverse array of buildings, many of which are not typically open to the public.

### App Overview

The **Doors Open Ottawa iOS App** enhances the event experience by offering offline access to detailed information about participating locations, event schedules, and interactive maps. 

## Key Features

### 1. Multilingual Support
- **Dynamic Content Delivery:** The app dynamically serves content based on the user's language preferences, with English as the default. This ensures a broader reach and inclusivity for both local and international users.
- **Internationalization:** Leveraged Swift’s localization features to seamlessly support multiple languages.

### 2. Building Categories
- **Organized Content:** Buildings are categorized by type, making it easy for users to find and explore locations of interest. The app's data structure ensures accurate classification and efficient retrieval of information.
- **Category Management:** Implemented in the back-end API, ensuring that new categories can be added or modified without disrupting the user experience.

### 3. Schedule Information
- **Detailed Schedules:** Users can review planned schedules and open hours for each location, from Monday to Friday. This feature helps users plan their visits efficiently.
- **Time Management Integration:** Schedule data is fetched and displayed in a user-friendly format, with considerations for local time zones.

### 4. Amenities Customization
- **Customizable Icons:** The app features flexible customization of amenities, where each building can display unique icons and descriptions. This visual aid enhances user understanding of available facilities.
- **Scalable Design:** Designed to allow easy updates or additions of new amenities without requiring a complete app update.

## Future Enhancements

### 1. User Authentication
- **User Registration & Login:** Planned integration for user authentication, enabling features such as building reviews, ratings, and the ability to upload pictures of visits.
- **Secure Authentication:** Considering OAuth2 and JWT for secure user management and data protection.
- **User-Generated Content:** Will allow users to contribute to the app by sharing their experiences, thus creating a community-driven resource.

### 2. Expanded Offline Capabilities
- **Enhanced Data Caching:** Improving offline data management to ensure that users can access the most up-to-date information, even when not connected to the internet.

## Technologies Used

- **Swift:** The primary programming language used for the app, ensuring performance and reliability.
- **Xcode:** The development environment where the project is coded, debugged, and tested.
- **Core Data:** Used for managing the app's data model, particularly for offline storage of building information and schedules.
- **MapKit:** To integrate maps and location-based services, providing users with interactive maps of event locations.
- **RESTful API:** The app communicates with a custom-built API to fetch building data, schedules, and amenities dynamically.

## Installation

To run this project locally:

1. Clone this repository:
    ```sh
    git clone https://github.com/yourusername/doors-open-ottawa-ios-app.git
    ```
2. Open the project in Xcode.
3. Build and run the app on your iOS simulator or device.

## Contributing

Contributions to this project are welcome. Feel free to fork the repository, make your improvements, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.txt) file for details.

## Contact

If you have any questions or would like to connect, feel free to reach out:

- LinkedIn: [https://www.linkedin.com/in/gustavo-reguerin](https://www.linkedin.com/in/gustavo-reguerin)
- Email: [reguerin@gmail.com](mailto:reguerin@gmail.com)
