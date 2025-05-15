# auto-swap-runner

## Prerequisites
- Node.js and pnpm installed

A lightweight, resource-efficient background auto-swap-runner in TypeScript that queries an asset prediction API and, upon an affirmative signal, executes a swap action using starknet-auto-swap-runner-kit.

## Features
- Runs as a background process, waking up only at the configured interval (default: 1 hour).
- Prints all operations and errors to the terminal for transparency.
- All configuration is via `.env`.
- No container required: just Node.js and yarn.

## Usage

1. Install dependencies:
   ```sh
   yarn install
   ```
2. Configure `.env` with your API URL, keys, and parameters.
3. Start the auto-swap-runner:
   ```sh
   yarn start
   ```

🔧 Configuration
Copy the example environment file:

```sh
cp .env.example .env
```
Open .env and update the required variables with your actual configuration and secrets.
⚠️ Important: Never commit the .env file to version control. It contains sensitive credentials used to run the swap process.

## Notes
- The auto-swap-runner is optimized to use minimal resources (no busy-waiting, sleeps between polls).
- All logs and errors are printed to the terminal.
- The auto-swap-runner can be run locally or on any server with Node.js.
