/* eslint-env node */

import pg from 'pg';
import { environment } from './environment.js';
import { logger as loggerSingleton } from './logger.js';

/**
 * Database class.
 */
export class Database {
  constructor(connectionString, logger) {
    this.connectionString = connectionString;
    this.logger = logger;
    this.pool = null;
  }

  /**
   * Open a database connection.
   */
  open() {
    if (!this.pool) {
      this.pool = new pg.Pool({ connectionString: this.connectionString });
      this.pool.on('error', (err) => {
        this.logger.error('Error in database pool', err);
        this.close();
      });
    }
  }

  /**
   * Close the database connection.
   * @returns {Promise<boolean>}
   */
  async close() {
    if (!this.pool) {
      this.logger.error('Database connection not open');
      return false;
    }
    try {
      await this.pool.end();
      return true;
    } catch (e) {
      this.logger.error('Error closing database', e);
      return false;
    } finally {
      this.pool = null;
    }
  }

  /**
   * Run a query on the database.
   * @param {string} sql SQL query.
   * @param {Array<any>} values Parameters for the query.
   * @returns {Promise<pg.QueryResult | null>} Query result.
   */
  async query(sql, values = []) {
    if (!this.pool) {
      this.logger.error('Query attempted on a closed database');
      return null;
    }
    try {
      const result = await this.pool.query(sql, values);
      return result;
    } catch (e) {
      this.logger.error('Database query error', e);
      return null;
    }
  }
}

/** @type {Database | null} */
let db = null;

/**
 * Return a singleton database instance.
 * @returns {Database | null}
 */
export function getDatabase() {
  if (!db) {
    const env = environment(process.env, loggerSingleton);
    if (!env || !env.connectionString) {
      console.error('DATABASE_URL must be defined as a string');
      return null;
    }
    db = new Database(env.connectionString, loggerSingleton);
    db.open();
  }
  return db;
}

/**
 * Helper function to run queries.
 * @param {string} sql SQL query.
 * @param {Array<any>} values Parameters for the query.
 * @returns {Promise<pg.QueryResult | null>} Query result.
 */
export const query = async (sql, values = []) => {
  const database = getDatabase();
  if (!database) {
    return null;
  }
  return database.query(sql, values);
};
