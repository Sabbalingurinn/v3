import { test, describe, beforeEach, mock } from 'node:test';
import assert from 'node:assert/strict';
import pg from 'pg';
import { query } from './db.client.js';

// Mock fyrir PostgreSQL Pool
class MockPool {
  async connect() {
    return {
      query: async () => ({ rowCount: 1, rows: [{ id: 1, name: 'Test' }] }),
      release: async () => {},
    };
  }
  async query() {
    return { rowCount: 1, rows: [{ id: 1, name: 'Test' }] };
  }
  async end() {}
  on() {}
}

// Nota `mock.method` til að tryggja að `pg.Pool` mockið virki rétt
mock.method(pg, 'Pool', () => new MockPool());

describe('Database client', () => {
  beforeEach(() => {
    mock.restoreAll();
  });

  test('should execute query and return result', async () => {
    const result = await query('SELECT * FROM test');
    assert.deepStrictEqual(result, { rowCount: 1, rows: [{ id: 1, name: 'Test' }] });
  });

  test('should return null if query fails', async () => {
    mock.method(MockPool.prototype, 'query', async () => {
      throw new Error('Query failed');
    });

    const result = await query('SELECT * FROM test');
    assert.strictEqual(result, null);
  });
});
