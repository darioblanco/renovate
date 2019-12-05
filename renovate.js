module.exports = {
  endpoint: process.env.ENDPOINT,
  token: process.env.TOKEN,
  platform: process.env.PLATFORM,
  logFileLevel: process.env.LOG_LEVEL,
  logLevel: process.env.LOG_LEVEL,
  binarySource: process.env.BINARY_SOURCE,
  repositories: process.env.REPOSITORIES.split(','),
  onboardingConfig: require(process.env.ONBOARDING_CONFIG_PATH),
};
