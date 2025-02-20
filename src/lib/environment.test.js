import { test, describe, beforeEach, afterEach, mock } from 'node:test';
import assert from 'node:assert/strict';
import { Logger } from './logger.js';

describe('Logger', () => {
  let logger, consoleInfoSpy, consoleWarnSpy, consoleErrorSpy;

  beforeEach(() => {
    logger = new Logger();
    consoleInfoSpy = mock.method(console, 'info');
    consoleWarnSpy = mock.method(console, 'warn');
    consoleErrorSpy = mock.method(console, 'error');
  });

  afterEach(() => {
    mock.restoreAll();
  });

  test('should log info messages when not silent', () => {
    logger.info('Test message');
    assert.strictEqual(consoleInfoSpy.mock.calls.length, 1);
  });

  test('should log warning messages when not silent', () => {
    logger.warn('Warning message');
    assert.strictEqual(consoleWarnSpy.mock.calls.length, 1);
  });

  test('should log error messages when not silent', () => {
    logger.error('Error message');
    assert.strictEqual(consoleErrorSpy.mock.calls.length, 1);
  });

  test('should not log anything when silent mode is enabled', () => {
    logger = new Logger(true);
    logger.info('Test message');
    logger.warn('Warning message');
    logger.error('Error message');

    assert.strictEqual(consoleInfoSpy.mock.calls.length, 0);
    assert.strictEqual(consoleWarnSpy.mock.calls.length, 0);
    assert.strictEqual(consoleErrorSpy.mock.calls.length, 0);
  });
});
