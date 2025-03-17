import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simu_bank_app/feature/transaction_list/domain/app_trasaction_item.dart';

part 'app_transaction_item_list_view_model.freezed.dart';

extension AppTransactionListViewModelAddExtensions on AppTransactionListViewModel {

  AppTransactionListViewModel addTransactions({
    required List<AppTransactionItem> newTransactions,
    required int? currentPage,
    required bool hasMore,
  }) {
    return when(
      data: (transactions, _, __, ___, ____) => AppTransactionListViewModel.data(
        transactions: [...transactions, ...newTransactions],
        currentPage: currentPage,
        hasMore: hasMore,
        additionalLoading: false,
      ),
      initialLoading: () => AppTransactionListViewModel.data(
        transactions: newTransactions,
        currentPage: currentPage,
        hasMore: hasMore,
        additionalLoading: false,
      ),
    );
  }

  AppTransactionListViewModel handleError(String errorMessage) {
    return map(initialLoading: (_) {
      return AppTransactionListViewModel.data(
        transactions: [],
        hasMore: false,
        errorMessage: errorMessage,
      );
    }, data: (data) {
      return data.copyWith(
        additionalLoading: false,
        hasMore: false,
        errorMessage: errorMessage,
      );
    });
  }

  int? getNextPage({required bool loadMore}) {
    return map(
      initialLoading: (_) {
        // start from page 1 when paginating
        // otherwise we don't care because everything is fetched in one go
        return loadMore ? 1 : null;
      },
      data: (data) {
        int? currentPage = data.currentPage;
        if (loadMore) {
          if (currentPage == null) {
            // first paginated fetch
            currentPage = 1;
          } else {
            // increase the page AFTER first fetch
            currentPage++;
          }
        }
        return currentPage;
      },
    );
  }
}

@freezed
class AppTransactionListViewModel with _$AppTransactionListViewModel {
  const factory AppTransactionListViewModel.initialLoading() = _AppTransactionListViewModelInitialLoading;

  /// Represents a full-fetch/paginated list of transactions.
  ///
  /// @param transactions The list of loaded transactions.
  /// @param currentPage The last successfully loaded page. Defaults to null to indicate full fetch.
  /// @param additionalLoading - for effective pagination
  /// @param hasMore - for effective pagination
  const factory AppTransactionListViewModel.data({
    @Default([]) List<AppTransactionItem> transactions,
    int? currentPage,
    String? errorMessage,
    @Default(false) bool additionalLoading,
    @Default(true) bool hasMore,
  }) = _AppTransactionListViewModelData;
}
