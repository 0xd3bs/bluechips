import { Account, RpcProvider, constants } from "starknet";
import { fetchQuotes, executeSwap, Quote } from "@avnu/avnu-sdk";
import { formatUnits, parseUnits } from "ethers";
import dotenv from "dotenv";

dotenv.config();

// Configuración de la red Starknet Sepolia
const NETWORK_CONFIG = {
    nodeUrl: process.env.NODE_URL,
    avnuBaseUrl: process.env.AVNU_BASE_URL!
};

// Configuración de tokens
const TOKEN_CONFIG = {
    ETH: process.env.ETH_ADDRESS!,
    WBTC: process.env.WBTC_ADDRESS!,
    BTC: process.env.WBTC_ADDRESS!,    
    STRK: process.env.STRK_ADDRESS!
};

/**
 * Manages token swaps using the Avnu SDK
 */
export class SwapManager {
    private provider: RpcProvider;
    private account: Account;

    constructor() {
        this.provider = new RpcProvider({
            nodeUrl: NETWORK_CONFIG.nodeUrl,
            chainId: constants.StarknetChainId.SN_SEPOLIA
        });

        // Initialize account
        this.account = new Account(
            this.provider,
            process.env.ACCOUNT_ADDRESS!,
            process.env.ACCOUNT_PRIVATE_KEY!
        );
    }

    /**
     * Get account balance in ETH
     */
    async getAccountBalance(): Promise<string> {
        try {
            // Call contract to get balance
            const response = await this.provider.getStorageAt(TOKEN_CONFIG.ETH, this.account.address);
            return formatUnits(response, 18);
        } catch (error) {
            console.error('Error getting balance:', error);
            throw error;
        }
    }

    /**
     * Get quotes for a swap
     */
    async getQuotes(buyTokenSymbol: string, sellAmount: string): Promise<Quote[]> {
        try {
            const buyTokenAddress = TOKEN_CONFIG[buyTokenSymbol as keyof typeof TOKEN_CONFIG];
            if (!buyTokenAddress) {
                throw new Error(`Token address not found for ${buyTokenSymbol}`);
            }

            // Convert amount to proper decimals (18 decimals)
            const parsedAmount = parseUnits(sellAmount, 18);
            const amountBigInt = BigInt(parsedAmount.toString());

            const quoteParams = {
                sellTokenAddress: TOKEN_CONFIG.STRK,
                buyTokenAddress: buyTokenAddress,
                sellAmount: amountBigInt,
                takerAddress: this.account.address
            };

            console.log("Fetching quotes with params:", {
                sellTokenAddress: quoteParams.sellTokenAddress,
                buyTokenAddress: quoteParams.buyTokenAddress,
                sellAmount: sellAmount, // Show amount in string
                takerAddress: quoteParams.takerAddress
            });

            const quotes = await fetchQuotes(quoteParams, {
                baseUrl: NETWORK_CONFIG.avnuBaseUrl
            });

            return quotes;
        } catch (error: any) {
            console.error("Error fetching quotes:", error.message);
            throw error;
        }
    }

    /**
     * Execute a swap with the best available quote
     */
    async executeSwapWithBestQuote(buyTokenSymbol: string) {
        try {
            const sellAmount = process.env.INPUT_AMOUNT || '0.1';
            // 1. Get quotes
            const quotes = await this.getQuotes(buyTokenSymbol, sellAmount);
            
            if (!quotes || quotes.length === 0) {
                throw new Error('No quotes available for the swap');
            }

            const bestQuote = quotes[0];
            
            // 2. Show best quote details
            console.log('\nBest quote details:');
            console.log(`Sell: ${formatUnits(bestQuote.sellAmount, 18)} STRK`);
            console.log(`Buy: ${formatUnits(bestQuote.buyAmount, 18)} ${buyTokenSymbol}`);

            // 3. Execute the swap
            console.log('\nExecuting swap...');
            const swapResult = await executeSwap(
                this.account,
                bestQuote,
                {}, // Additional options if needed
                { baseUrl: NETWORK_CONFIG.avnuBaseUrl }
            );

            console.log('\nSwap transaction submitted successfully!');
            if (swapResult.transactionHash) {
                console.log(`Transaction Hash: ${swapResult.transactionHash}`);
                console.log(`View on Starkscan: ${process.env.STARKSCAN_URL}${swapResult.transactionHash}`);
            }

            return swapResult;

        } catch (error: any) {
            let errorMessage = 'Swap execution failed';

            if (error.message) {
                errorMessage += `: ${error.message}`;
            }

            // Handle specific API errors
            if (error.response?.data) {
                const apiError = error.response.data;
                if (apiError.error) {
                    errorMessage += `\nAPI Error: ${apiError.error}`;
                }
                if (apiError.details) {
                    errorMessage += `\nDetails: ${apiError.details}`;
                }
            }

            // Handle contract errors
            if (error.errorCode) {
                errorMessage += `\nContract Error Code: ${error.errorCode}`;
            }

            console.error('\nError:', errorMessage);
            throw new Error(errorMessage);
        }
    }

    /**
     * Obtener el saldo de la cuenta
     */
    async getAccountInfo() {
        try {
            const address = this.account.address;
            console.log(`Account Address: ${address}`);
            return {
                address,
                provider: this.provider
            };
        } catch (error) {
            console.error("Error getting account info:", error);
            throw error;
        }
    }
}