import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var apikey=dotenv.env['POSTHOG_API_KEY'];
  var host= dotenv.env['POSTHOG_HOST'];

  final config = PostHogConfig(
    '$apikey',
  );
  config.host = '$host';
  config.optOut = false;
  config.flushAt = 1;
  // Initialize PostHog with the API Key from .env
  await Posthog().setup(
    config,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PostHog Flutter Example',
      home: Scaffold(
        appBar: AppBar(title: Text('PostHog Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Example event tracking
              Posthog().capture(
                eventName: 'Button Clicked',
                properties: {'button': 'Test Button'},
              );
              Posthog().screen(
                screenName: 'Home Screen',
                properties: {'button': 'Test Button'},
              );
             
            },
            child: Text('Track Event'),
          ),
        ),
      ),
    );
  }
}
