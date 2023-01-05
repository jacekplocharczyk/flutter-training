enum ArticleState {
  created,
  scheduled,
  processing,
  completed,
  uploadFailed,
  processingFailed
}

const articleStateMap = {
  ArticleState.created: "Created",
  ArticleState.scheduled: "Scheduled",
  ArticleState.processing: "Processing",
  ArticleState.completed: "Completed",
  ArticleState.uploadFailed: "Upload failed",
  ArticleState.processingFailed: "Processing failed",
};
