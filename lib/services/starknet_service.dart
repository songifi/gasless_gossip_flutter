import 'package:starknet/starknet.dart';
import 'package:starknet_provider/starknet_provider.dart';

class StarknetService {
  static const String strkTokenAddress = "0x04718f5a0fc34cc1af16a1cdee98ffb20c31f5cd61d6ab07201858f4287c938d";
  static const String rpcUrl = "https://starknet-sepolia.public.blastapi.io/rpc/v0_7";
  
  late final JsonRpcProvider _provider;
  late final Account _account;
  
  StarknetService() {
    _provider = JsonRpcProvider(nodeUri: Uri.parse(rpcUrl));
  }
  
  // Initialize account with private key (for demo purposes)
  Future<void> initializeAccount({
    required String privateKey,
    required String accountAddress,
  }) async {
    final signer = Signer(privateKey: Felt.fromHexString(privateKey));
    _account = Account(
      provider: _provider,
      signer: signer,
      accountAddress: Felt.fromHexString(accountAddress),
      chainId: Felt.fromHexString("0x534e5f5345504f4c4941"), // SN_SEPOLIA chain ID
    );
  }
  
  // Get STRK balance
  Future<String> getStrkBalance(String address) async {
    try {
      final request = FunctionCall(
        contractAddress: Felt.fromHexString(strkTokenAddress),
        entryPointSelector: getSelectorByName("balanceOf"),
        calldata: [Felt.fromHexString(address)],
      );
      
      final response = await _provider.call(
        request: request,
        blockId: BlockId.latest,
      );
      
      // Handle the response based on its type
      return response.when(
        result: (result) {
          // Convert from wei to STRK (18 decimals)
          final balanceInWei = result[0]; // result is List<Felt>
          final balanceInStrk = balanceInWei.toBigInt() / BigInt.from(10).pow(18);
          return balanceInStrk.toStringAsFixed(2);
        },
        error: (error) {
          print('Error getting balance: ${error.message}');
          return "0.00";
        },
      );
    } catch (e) {
      print('Error getting balance: $e');
      return "0.00";
    }
  }
  
  // Send STRK tokens
  Future<TransactionResult> sendStrk({
    required String recipientAddress,
    required String amount,
  }) async {
    try {
      // Convert amount to wei (18 decimals)
      final amountInWei = (double.parse(amount) * (1e18)).toInt();
      
      final functionCall = FunctionCall(
        contractAddress: Felt.fromHexString(strkTokenAddress),
        entryPointSelector: getSelectorByName("transfer"),
        calldata: [
          Felt.fromHexString(recipientAddress),
          Felt.fromInt(amountInWei),
          Felt.fromInt(0), // high part for u256
        ],
      );
      
      final response = await _account.execute(
        functionCalls: [functionCall],
        max_fee: Felt.fromInt(16000000000001), // Demo fee
      );
      
      // Handle the response based on its type
      return response.when(
        result: (result) {
          return TransactionResult(
            success: true,
            transactionHash: result.transaction_hash,
            message: "Transaction sent successfully",
          );
        },
        error: (error) {
          return TransactionResult(
            success: false,
            transactionHash: null,
            message: "Failed to send transaction: ${error.message}",
          );
        },
      );
    } catch (e) {
      return TransactionResult(
        success: false,
        transactionHash: null,
        message: "Failed to send transaction: $e",
      );
    }
  }
  
  // Check transaction status
  Future<String> getTransactionStatus(String txHash) async {
    try {
      // For demo purposes, return a mock status
      // In a real implementation, you would properly handle the receipt structure
      return "SUCCEEDED";
    } catch (e) {
      return "UNKNOWN";
    }
  }
  
  // Check if account is deployed and get nonce
  Future<bool> isAccountDeployed(String address) async {
    try {
      final nonce = await _provider.getNonce(
        contractAddress: Felt.fromHexString(address),
        blockId: BlockId.latest,
      );
      
      nonce.when(
        result: (result) {
          print('✅ Account deployed. Nonce: $result');
          return true;
        },
        error: (error) {
          print('❌ Account not deployed: ${error.message}');
          return false;
        },
      );
      return true;
    } catch (e) {
      print('❌ Account not deployed or other error: $e');
      return false;
    }
  }
  
  // Check ETH balance for gas fees
  Future<void> checkBalances(String address) async {
    try {
      // Check STRK balance
      final strkBalance = await getStrkBalance(address);
      print('💰 STRK Balance: $strkBalance');
      
      // Check ETH balance (for gas)
      const ethTokenAddress = "0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7";
      final ethRequest = FunctionCall(
        contractAddress: Felt.fromHexString(ethTokenAddress),
        entryPointSelector: getSelectorByName("balanceOf"),
        calldata: [Felt.fromHexString(address)],
      );
      
      final ethResponse = await _provider.call(
        request: ethRequest,
        blockId: BlockId.latest,
      );
      
      ethResponse.when(
        result: (result) {
          final ethBalanceInWei = result[0];
          final ethBalance = ethBalanceInWei.toBigInt() / BigInt.from(10).pow(18);
          print('⚡ ETH Balance: ${ethBalance.toStringAsFixed(6)} ETH');
        },
        error: (error) {
          print('❌ Error getting ETH balance: ${error.message}');
        },
      );
    } catch (e) {
      print('❌ Error checking balances: $e');
    }
  }
}

class TransactionResult {
  final bool success;
  final String? transactionHash;
  final String message;
  
  TransactionResult({
    required this.success,
    required this.transactionHash,
    required this.message,
  });
}

// Demo data for the presentation
class DemoStarknetService {
  static const Map<String, String> demoUsers = {
    'theXaxxo Outlook': '0x07394cbe418daa16e42b87ba67372d4ab4a5df0b05c6e554d158458ce245bc10',
    'Anna': '0x05f7cd1fd465baff2ba9d2d1501ad0a2eb5337d9a885be319366b5205a414fdd',
    'Ralph': '0x03ee9e18edc71a6df30ac3aca2e0b02a198fbce19b7480a63a0d71cbd76652e0',
  };
  
  // Simulate sending transaction for demo
  static Future<TransactionResult> sendStrkDemo({
    required String recipientName,
    required String amount,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Generate a mock transaction hash
    final txHash = "0x${DateTime.now().millisecondsSinceEpoch.toRadixString(16)}";
    
    return TransactionResult(
      success: true,
      transactionHash: txHash,
      message: "Sent $amount STRK to $recipientName",
    );
  }
} 