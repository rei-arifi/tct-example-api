#!/usr/bin/env node
import { program } from 'commander';
import { DefaultApi, Configuration } from './client';

// Default base path
const DEFAULT_BASE_PATH = 'http://localhost:3000/api';

// Initialize program
program
  .name('ping-cli')
  .description('CLI tool to interact with the Ping API')
  .version('1.0.0')
  .option('--base-path <path>', `Base URL of the API (default: ${DEFAULT_BASE_PATH})`, DEFAULT_BASE_PATH);

// Create API client instance with configuration
function createApiClient(basePath: string) {
  const config = new Configuration({ basePath });
  return new DefaultApi(config);
}

// Parse command line arguments
program.parse(process.argv);
const options = program.opts();
const api = createApiClient(options.basePath);

// Show help if no command is provided
if (!process.argv.slice(2).length) {
  program.outputHelp();
  process.exit(0);
}

// Program initialization moved to the top with base-path option

// Ping command
program
  .command('ping')
  .description('Send a ping to the server')
  .action(async () => {
    try {
      const response = await api.ping();
      console.log('Ping successful!');
      console.log('Response:', response.data);
    } catch (error) {
      if (error instanceof Error) {
        console.error('Error pinging server:', error.message);
      } else {
        console.error('An unknown error occurred while pinging the server');
      }
      process.exit(1);
    }
  });

// Count command
program
  .command('count')
  .description('Get the current ping count')
  .action(async () => {
    try {
      const response = await api.getPingCount();
      console.log(`Total pings: ${response.data.count}`);
      console.log('Last updated:', new Date(response.data.timestamp).toLocaleString());
    } catch (error) {
      if (error instanceof Error) {
        console.error('Error getting ping count:', error.message);
      } else {
        console.error('An unknown error occurred while getting ping count');
      }
      process.exit(1);
    }
  });

// Parse command line arguments
program.parse(process.argv);
