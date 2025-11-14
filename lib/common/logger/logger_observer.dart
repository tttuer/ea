import 'package:flutter_riverpod/flutter_riverpod.dart';

final class LoggerObserver extends ProviderObserver {
  void log(String message) {
    print(message);
  }
}
