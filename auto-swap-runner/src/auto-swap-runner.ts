/**
 * auto-swap-runner-ts: Resource-efficient background auto-swap-runner for asset prediction and swap execution.
 *
 * - Polls the configured API endpoint for predictions every INTERVAL_MINUTES.
 * - If an affirmative prediction is received, executes a swap action using starknet-auto-swap-runner-kit.
 * - All configuration is via .env file.
 * - All logs are printed to the terminal.
 */

import 'dotenv/config';
import axios from 'axios';
import { SwapManager } from './swap-manager';

// Configuration
const API_URL = process.env.API_URL || 'http://localhost:5000/api/v1';
const ASSETS = (process.env.ASSETS || 'ETH,WBTC').split(',');
const AFFIRMATIVE_RESPONSE = Number(process.env.AFFIRMATIVE_RESPONSE || 1);
const INTERVAL_MINUTES = Number(process.env.INTERVAL_MINUTES || 60);

async function callPrediction(asset: string): Promise<any> {
  const url = `${API_URL}/predictions/${asset}`;
  try {
    const response = await axios.get(url, { timeout: 10000 });
    console.log(`[INFO] Prediction for ${asset}:`, response.data);
    return response.data;
  } catch (e: any) {
    // Registrar el error y finalizar la aplicación correctamente
    console.error(`[CRITICAL] API error detected for ${asset} (${url}):`, e.message);
    process.exit(1); // Finaliza la aplicación con código de error
  }
}

async function triggerSwapAction(buyTokenTicker: string) {
  try {
    const swapManager = new SwapManager();
    const result = await swapManager.executeSwapWithBestQuote(buyTokenTicker);
    console.log('[INFO] Transaction confirmed:', result.transactionHash);
    return result;
  } catch (e: any) {
    // Critical errors that should stop the process
    const criticalErrors = [
      'No quotes available',
      'insufficient balance',
      'rejected',
      'Invalid token'
    ];

    const isCriticalError = criticalErrors.some(errorText => 
      e.message.toLowerCase().includes(errorText.toLowerCase())
    );

    if (isCriticalError) {
      console.error('[CRITICAL] Stopping process due to critical swap error:', e.message);
      process.exit(1);
    } else {
      console.error('[ERROR] Non-critical swap error:', e.message);
      throw e;
    }
  }
}

// Global flag to control the main loop
let isRunning = true;

// Handle termination signals
process.on('SIGINT', async () => {
  console.log('\n[INFO] Received termination signal. Gracefully shutting down...');
  isRunning = false;
});

process.on('SIGTERM', async () => {
  console.log('\n[INFO] Received termination signal. Gracefully shutting down...');
  isRunning = false;
});

/**
 * Logs memory usage information
 */
function logMemoryUsage() {
  const memUsage = process.memoryUsage();
  console.log('[MEMORY] RSS:', Math.round(memUsage.rss / 1024 / 1024) + 'MB',
              'Heap:', Math.round(memUsage.heapUsed / 1024 / 1024) + 'MB /',
              Math.round(memUsage.heapTotal / 1024 / 1024) + 'MB');
}

async function mainLoop() {
  console.log('[INFO] Starting optimized auto-swap-runner background process');
  console.log('[INFO] Press Ctrl+C to stop the auto-swap-runner gracefully');
  logMemoryUsage(); // Imprime uso de memoria al inicio
  
  while (isRunning) {
    try {
      // Process all assets in parallel for efficiency
      const predictions = await Promise.all(
        ASSETS.map(asset => callPrediction(asset))
      );

      // Process predictions and trigger swaps if needed
      for (let i = 0; i < predictions.length; i++) {
        const prediction = predictions[i];
        const asset = ASSETS[i];

        if (
          prediction?.data?.prediction === AFFIRMATIVE_RESPONSE
        ) {
          console.log(`[INFO] Affirmative prediction for ${asset}, executing swap`);
          console.log(`\nExecuting swap for ${asset}...`);
          await triggerSwapAction(asset);
          console.log(`Swap completed for ${asset}\n`);
        }
      }

      if (isRunning) {
        // Schedule next run for midnight
        await new Promise<void>((resolve, reject) => {
          const nextRun = new Date();
          nextRun.setHours(24, 0, 0, 0); // Next day at midnight
          
          const delay = nextRun.getTime() - Date.now();
          console.log(`[INFO] Next execution scheduled for ${nextRun.toISOString()}`);
          
          // Store timeout reference so we can clear it if needed
          const timeoutId = setTimeout(resolve, delay);
          
          // Create an interval to show that the auto-swap-runner is still alive
          const intervalId = setInterval(() => {
            console.log('[INFO] auto-swap-runner is running... (Press Ctrl+C to stop)');
            logMemoryUsage(); // Monitorea la memoria cada 5 minutos
          }, 5 * 60 * 1000); // Show message every 5 minutes
          
          // If the process is stopping, clear both timers
          const checkInterval = setInterval(() => {
            if (!isRunning) {
              clearTimeout(timeoutId);
              clearInterval(intervalId);
              clearInterval(checkInterval);
              resolve();
            }
          }, 1000);
        });
      }

    } catch (error: any) {
      console.error('[ERROR] Error in main loop:', error.message);
      if (error.stack) {
        console.error('[ERROR] Stack trace:', error.stack.split('\n').slice(0, 3).join('\n'));
      }
      
      // Log memory usage during errors to detect potential issues
      logMemoryUsage();
      
      // If the error came from triggerSwapAction, it's non-critical
      // Critical errors in triggerSwapAction will exit the process directly
      console.log('[INFO] Retrying in 5 minutes...');
      await new Promise(resolve => setTimeout(resolve, 5 * 60 * 1000));
    }
  }
}

// Start the auto-swap-runner
mainLoop().then(() => {
  console.log('[INFO] auto-swap-runner stopped successfully');
  process.exit(0);
}).catch((error) => {
  console.error('[ERROR] Fatal error in auto-swap-runner:', error);
  process.exit(1);
});
