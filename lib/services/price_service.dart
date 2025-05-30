import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';
  static const String _starknetId = 'starknet';
  
  static double? _cachedStrkPrice;
  static DateTime? _lastFetchTime;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  static Future<double> getStrkPrice() async {
    // Return cached price if still valid
    if (_cachedStrkPrice != null && 
        _lastFetchTime != null && 
        DateTime.now().difference(_lastFetchTime!) < _cacheValidDuration) {
      return _cachedStrkPrice!;
    }

    try {
      print('🔄 Fetching real-time STRK price...');
      
      final response = await http.get(
        Uri.parse('$_baseUrl/simple/price?ids=$_starknetId&vs_currencies=usd'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final price = data[_starknetId]?['usd']?.toDouble();
        
        if (price != null && price > 0) {
          _cachedStrkPrice = price;
          _lastFetchTime = DateTime.now();
          print('✅ STRK price fetched: \$${price.toStringAsFixed(4)}');
          return price;
        } else {
          throw Exception('Invalid price data received');
        }
      } else {
        throw Exception('Failed to fetch price: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error fetching STRK price: $e');
      // Return fallback price of 1.0 if API fails
      print('📊 Using fallback price: \$1.00');
      return 1.0;
    }
  }

  static String formatUsdAmount(double strkAmount, double strkPrice) {
    final usdValue = strkAmount * strkPrice;
    return '\$${usdValue.toStringAsFixed(2)}';
  }

  static void clearCache() {
    _cachedStrkPrice = null;
    _lastFetchTime = null;
  }
} 