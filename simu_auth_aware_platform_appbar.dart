import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simu_bank_app/core/auth/state/auth_provider.dart';
import 'package:simu_bank_app/core/shared/presentation/simu_appbar_mobile.dart'
    if (dart.library.html) 'package:simu_bank_app/core/shared/presentation/simu_appbar_web.dart';

import 'package:flutter/material.dart';
import 'package:simu_bank_app/feature/transaction_list/state/app_transaction_list_provider.dart';

class AuthAwarePlatformAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AuthAwarePlatformAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authProvider).map(unAuthenticated: (_) {
      return Container(
        height: kToolbarHeight,
        color: Colors.transparent,
      );
    }, authenticated: (_) {
      return SimuAppbar(onLogout: () {
        ref.read(authProvider.notifier).logout();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // its seems logical to me to call the method on exit AS WELL
          ref.invalidate(appTransactionListProvider);
        });
      });
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
