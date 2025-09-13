# Ping API SDK

A TypeScript/JavaScript SDK and CLI tool for interacting with the Ping API.

## Installation

1. Install the SDK globally:
   ```bash
   npm install -g .
   ```

   Or use it directly with npx:
   ```bash
   npx .
   ```

## Usage

### CLI Commands

```bash
# Send a ping to the server
ping-cli ping

# Get the current ping count
ping-cli count

# Show help
ping-cli --help
```

### Programmatic Usage

```typescript
import { PingApi } from './client';

const api = new PingApi({
  baseURL: 'http://localhost:3000/api',
  withCredentials: false,
});

// Send a ping
const pingResponse = await api.ping();
console.log(pingResponse.data);

// Get ping count
const countResponse = await api.pingCount();
console.log(`Total pings: ${countResponse.data.count}`);
```

## Development

1. Install dependencies:
   ```bash
   npm install
   ```

2. Generate TypeScript client from OpenAPI spec:
   ```bash
   npm run generate-client
   ```

3. Build the project:
   ```bash
   npm run build
   ```

4. Run in development mode:
   ```bash
   npm run dev
   ```

## License

MIT
