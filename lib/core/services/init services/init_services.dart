import 'package:ecommerce_private_app/core/services/storage%20services/store_step_service.dart';

class InitServices {
  Future<void> init() async {
    await StoreStepService().initSharedPreference();
    // StoreStepService().setStep('1');
  }
}
