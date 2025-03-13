# posthogboilerplate

A new Flutter project.

# To add POSTHOG api key and host in a .env in flutter
Add dependency in pubspec.yaml :

```    
dependencies:
    flutter:
        sdk: flutter
    flutter_dotenv: ^5.1.0  # Add dotenv to load the environement variable
```
Execute :
```
flutter pub get
```
Add a file .env in the folder assets/
Create a file in your root named .env and add:

```
POSTHOG_API_KEY=phc_YOUR_SECRET_API_KEY
POSTHOG_HOST=https://eu.i.posthog.com
```
⚠️ Don't push it on GIT  !
Add-it in .gitignore :

```
# Ignore environment files
.env
```
Load the file .env in main.dart


```
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env"); // Load the env variable
  runApp(MyApp());
}
```

# To add the api key in ANDROID

Add API Key in android/gradle.properties
```
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError
android.useAndroidX=true
android.enableJetifier=true
POSTHOG_API_KEY=YOUR_SECRET_API_KEY
POSTHOG_HOST=URI_OF_YOUR_POSTHOG
```
Then, in android/app/build.gradle, add:

```
android {
    defaultConfig {
        buildConfigField "String", "POSTHOG_API_KEY", "\"${POSTHOG_API_KEY}\""
        buildConfigField "String", "POSTHOG_HOST", "\"${POSTHOG_HOST}\""
    }
}
```
# Configure iOS to Use Environment Variables
Modify ios/Runner/Info.plist to dynamically set the PostHog API Key:

```
<key>PosthogApiKey</key>
<string>${POSTHOG_API_KEY}</string>
<key>PosthogHost</key>
<string>${POSTHOG_HOST}</string>
```
Then, in ios/Runner.xcconfig, add:

```
POSTHOG_API_KEY=phc_YOUR_SECRET_API_KEY
POSTHOG_HOST=https://eu.i.posthog.com
```