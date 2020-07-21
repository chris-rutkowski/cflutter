enum ExitType { warning, disabled, x, arrow }
enum ViewType { loading, normal, offline, error }
enum OperationStatus { working, offline, error, complete }

extension OperationStatusViewType on OperationStatus {
  ViewType viewType({
    ViewType working = ViewType.loading,
    ViewType complete = ViewType.normal,
  }) {
    switch (this) {
      case OperationStatus.working:
        return working;
      case OperationStatus.offline:
        return ViewType.offline;
      case OperationStatus.error:
        return ViewType.error;
      case OperationStatus.complete:
        return complete;
      default:
        return null;
    }
  }
}
