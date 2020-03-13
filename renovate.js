module.exports = {
  baseBranches: process.env.BASE_BRANCHES ? process.env.BASE_BRANCHES.split(',') : [],
  binarySource: process.env.BINARY_SOURCE,
  logFileLevel: process.env.LOG_LEVEL,
  logLevel: process.env.LOG_LEVEL,
  onboardingConfig: require(process.env.ONBOARDING_CONFIG_PATH),
  platform: process.env.PLATFORM,
  repositories: process.env.REPOSITORIES.split(','),
  token: process.env.TOKEN,
  trustLevel: process.env.TRUST_LEVEL,
};
