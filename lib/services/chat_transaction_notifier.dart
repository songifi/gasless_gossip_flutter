class ChatTransactionData {
  final String amount;
  final String txHash;
  final DateTime timestamp;

  ChatTransactionData({
    required this.amount,
    required this.txHash,
    required this.timestamp,
  });
}

class ChatTransactionNotifier {
  static ChatTransactionData? _lastTransaction;
  static List<Function(ChatTransactionData)> _listeners = [];

  static void setLastTransaction({
    required String amount,
    required String txHash,
    required DateTime timestamp,
  }) {
    _lastTransaction = ChatTransactionData(
      amount: amount,
      txHash: txHash,
      timestamp: timestamp,
    );
    
    // Notify all listeners
    for (final listener in _listeners) {
      listener(_lastTransaction!);
    }
  }

  static ChatTransactionData? getLastTransaction() {
    return _lastTransaction;
  }

  static void clearLastTransaction() {
    _lastTransaction = null;
  }

  static void addListener(Function(ChatTransactionData) listener) {
    _listeners.add(listener);
  }

  static void removeListener(Function(ChatTransactionData) listener) {
    _listeners.remove(listener);
  }

  static void clearListeners() {
    _listeners.clear();
  }
} 