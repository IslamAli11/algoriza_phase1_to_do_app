 abstract class AppStates{}
 class InitialAppState extends AppStates{}

 class DatabaseInitialized extends AppStates{}
 class DatabaseOpened extends AppStates{}
 class TaskStatusUpdated extends AppStates{}
class TaskDataDeleted extends AppStates{}
 class GetTasksLoadingState extends AppStates{}
 class ErrorInsertedTaskState extends AppStates{}
 class SuccessInsertedTaskState extends AppStates{}
 class SuccessGetTaskState extends AppStates{}
 class TaskedAdded extends AppStates{}
 class TaskBecomeCompleted extends AppStates{}
 class TaskBecomeFavorite extends AppStates{}
 class TaskBecomeUncompleted extends AppStates{}



class DateChanged extends AppStates{}
 class ChangeColorState extends AppStates{}
 class RemindChangeState extends AppStates{}
 class RepeatChangeState extends AppStates{}