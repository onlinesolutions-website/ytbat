const ALLOWED_TOPICS = [
  "task",
  "list",
  "reminder",
  "web",
  "website",
  "summary",
  "email",
  "text",
  "account",
  "privacy",
  "permission",
  "automation"
];

function isAllowedTopic(prompt = "") {
  const normalized = prompt.toLowerCase();
  return ALLOWED_TOPICS.some((topic) => normalized.includes(topic));
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed. Use POST." });
  }

  const { prompt = "", userId = "anonymous" } = req.body ?? {};

  if (!prompt.trim()) {
    return res.status(400).json({ error: "Prompt is required." });
  }

  const allowed = isAllowedTopic(prompt);

  const response = allowed
    ? `Understood. I will assist with: ${prompt}. I will keep your requests private and focused on approved assistant features.`
    : "I can help with assistant workflows, account settings, or privacy controls. Please rephrase your request within those areas.";

  return res.status(200).json({
    assistant: "Mac",
    userId,
    allowed,
    response,
    safety: {
      restrictedTopics: !allowed,
      dataScope: "Account + privacy settings"
    }
  });
}
