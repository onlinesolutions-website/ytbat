# ytbat

## Mac Assistant (Swift + Vercel-ready backend)

This repository includes:
- `MacAssistantApp/`: a SwiftUI starter app for **Mac**, your personal AI butler assistant.
- `MacAssistantBackend/`: a Vercel serverless backend endpoint (`/api/mac`) for assistant responses.

## Can this launch on Vercel?
Yes for the backend layer. The SwiftUI iOS app itself is built in Xcode, while `MacAssistantBackend` deploys to Vercel and the app calls it over HTTPS.

## Mac's behavior
- Trustworthy, calm male voice.
- Fluent full-sentence responses.
- Stays focused on assistant workflows, account controls, and privacy settings.

## Built-in capabilities
- Create and manage lists.
- Set push reminder workflows.
- Search the web and summarize websites.
- Generate starter websites.
- Draft/send email and text workflows.
- Permission-based device automation center.

## Extra innovation features
- Morning Briefing.
- Adaptive Focus Mode.
- Action Memory for recurring routines.
- Travel Concierge.
- Family Safety Center.

## Local testing
```bash
cd MacAssistantApp
swift test
```

## Vercel backend setup
```bash
cd MacAssistantBackend
npm install
npm run lint
npm run dev
```

Then point the Swift app API base URL to your deployed Vercel domain.
