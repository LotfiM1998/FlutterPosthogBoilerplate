/* eslint-disable */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as dotenv from "dotenv";
import { PostHog } from "posthog-node";


// Load environment variables from .env
dotenv.config();

admin.initializeApp();

// Initialize PostHog
const POSTHOG_API_KEY = process.env.POSTHOG_API_KEY ||
functions.config().posthog?.api_key;
const POSTHOG_HOST = process.env.POSTHOG_HOST || 
functions.config().posthog?.host;

const posthog = new PostHog(POSTHOG_API_KEY, {
  host: POSTHOG_HOST, // Update with your PostHog host if needed
});

// Example: Tracking a user event
export const trackPaymentEvent = async (userId: string, eventName: string) => {
  posthog.capture({
    distinctId: userId,
    event: eventName,
    properties: {
      timestamp: new Date().toISOString(),
    },
  });

  console.log(`✅ Event '${eventName}' sent to PostHog for user ${userId}`);
};

// Example usage inside a Firebase function
exports.paymentWebhook = functions.https.onRequest(async (req, res) => {
  const { userId, paymentStatus } = req.body;

  if (!userId || !paymentStatus) {
    res.status(400).json({ error: "Missing parameters" });
    return;
  }

  // Track payment status
  await trackPaymentEvent(userId, `Payment ${paymentStatus}`);

  res.status(200).json({ success: true });
  return;
});

