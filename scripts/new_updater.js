import { Session } from '@wharfkit/session';
import { WalletPluginPrivateKey } from '@wharfkit/wallet-plugin-privatekey';
import { Contract } from '@wharfkit/contract';
import { APIClient, Name } from '@wharfkit/antelope';
import fetch from 'node-fetch';
import dotenv from 'dotenv';

dotenv.config();

const {
  FREQ,
  ORACLE,
  CONTRACT,
  KEY,
  CHAIN,
  ENDPOINT
} = process.env;

const client = new APIClient({ url: ENDPOINT });

const walletPlugin = new WalletPluginPrivateKey(KEY);

const session = new Session({
  actor: ORACLE,
  permission: 'active',
  chain: {
    id: CHAIN,
    url: ENDPOINT
  },
  walletPlugin
});

async function fetchPrices() {
  try {
    const response = await fetch('https://min-api.cryptocompare.com/data/price?fsym=EOS&tsyms=USD');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching price data:', error);
    return null;
  }
}

async function pushPrice() {
  const prices = await fetchPrices();
  if (!prices) return;

  const quotes = [
    {
      value: Math.round(prices.USD * 10000),
      pair: 'eosusd'
    }
  ];

  try {
    const contract = await Contract.from({
      account: Name.from(CONTRACT),
      client
    });

    const action = contract.action('write', {
      owner: Name.from(ORACLE),
      quotes
    }, {
      authorization: [session.permissionLevel]
    });

    const result = await session.transact({ action });
    console.log('Transaction successful:', result.response.transaction_id);
  } catch (error) {
    console.error('Error pushing price data:', error);
  }
}

setInterval(pushPrice, parseInt(FREQ, 10));
