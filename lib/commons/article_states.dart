enum ArticleState { created, scheduled, processing, completed, failed }

const articleStateMap = {
  ArticleState.created: "Created",
  ArticleState.scheduled: "Scheduled",
  ArticleState.processing: "Processing",
  ArticleState.completed: "Completed",
  ArticleState.failed: "Failed",
};
