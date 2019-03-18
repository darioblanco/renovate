module.exports = {
  endpoint: process.env.GITLAB_API,
  token: process.env.GITLAB_API_TOKEN,
  platform: 'gitlab',
  logFileLevel: process.env.LOG_LEVEL,
  logLevel: process.env.LOG_LEVEL,
  repositories: process.env.REPOSITORIES.split(','),
  onboardingConfig: require('./default_config.json'),
};
