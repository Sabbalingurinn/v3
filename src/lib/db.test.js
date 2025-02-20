import { test, describe, beforeEach } from 'node:test';
import assert from 'node:assert/strict';
import { environment } from './environment.js';
import { Logger } from './logger.js';

describe('Environment', () => {
  let logger;

  beforeEach(() => {
    logger = new Logger(true);
  });

  test('should return environment with provided port and database url', () => {
    const envVars = { PORT: '5000', DATABASE_URL: 'postgres://user:pass@localhost:5432/db' };
    const result = environment(envVars, logger);

    assert.deepStrictEqual(result, { port: 5000, connectionString: 'postgres://user:pass@localhost:5432/db' });
  });

  test('should use default port if PORT is not provided', () => {
    const envVars = { DATABASE_URL: 'postgres://user:pass@localhost:5432/db' };
    const result = environment(envVars, logger);

    assert.deepStrictEqual(result, { port: 3000, connectionString: 'postgres://user:pass@localhost:5432/db' });
  });

  test('should return null if DATABASE_URL is missing', () => {
    const envVars = { PORT: '5000' };
    const result = environment(envVars, logger);

    assert.strictEqual(result, null);
  });
});
