# SnapchatClone iOS App

SnapchatClone is a Snapchat clone app for iOS devices. It allows users to sign up and sign in, capture images from their device's library, publish them to a feed, and view published images. The app is built using Swift and utilizes Firebase for backend services.

## Features

- **User Authentication:** Users can sign up for a new account or sign in to an existing account securely.
  
- **Image Capture:** Users can select images from their device's photo library or reach to camera to publish to the app's feed.

- **Automatic Deletion:** Images published to the feed are automatically deleted after 24 hours.

- **Feed Viewing:** Users can view images published by themselves and other users on the app's feed.

## Technologies Used

- **Swift:** The app is primarily developed using the Swift programming language for iOS development.

- **Firebase:** Firebase is used for user authentication, database storage, and other backend services.

## Installation

To run SnapClone on your iOS device or simulator, follow these steps:

1. Clone this repository to your local machine.
   
2. Install CocoaPods dependencies by running the following command in the project directory:
   ```
   pod install
   ```
   
3. Open the `SnapchatClone.xcworkspace` file in Xcode.
   
4. Configure Firebase by adding your Firebase project configuration files (`GoogleService-Info.plist`) to the project.
   
5. Build and run the app on your iOS device or simulator.

## Usage

1. Launch the app on your device.
   
2. Sign up for a new account or sign in with an existing account.
   
3. Navigate to the image capture screen and select an image from your device's photo library or reach to camera.
   
4. Add any desired filters or captions to the image.
   
5. Publish the image to the app's feed.
   
6. View published images on the feed.
   
7. Images will automatically be deleted after 24 hours.
