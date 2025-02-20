export function environment(env, logger) {
  const port = env.PORT ? parseInt(env.PORT, 10) : 3000;

  if (!env.DATABASE_URL) {
    logger.error('DATABASE_URL is missing');
    return null;
  }

  return {
    port,
    connectionString: env.DATABASE_URL,
  };
}
