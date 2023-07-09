class TaskFilterModel {
  bool showPendentsTasks;
  bool showFinishedTasks;
  bool onlyMyTasks;

  TaskFilterModel(
      {required this.showFinishedTasks,
      required this.showPendentsTasks,
      required this.onlyMyTasks});
}

TaskFilterModel taskFilterActive = TaskFilterModel(
    showFinishedTasks: false, showPendentsTasks: true, onlyMyTasks: true);
