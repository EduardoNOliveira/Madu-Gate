const loginRateBuckets = new Map();
const loginAttemptBuckets = new Map();

const RATE_LIMIT_WINDOW_MS = Number(process.env.AUTH_LOGIN_RATE_LIMIT_WINDOW_MS || 15 * 60 * 1000);
const RATE_LIMIT_MAX_REQUESTS = Number(process.env.AUTH_LOGIN_RATE_LIMIT_MAX || 20);

const ATTEMPT_WINDOW_MS = Number(process.env.AUTH_ATTEMPT_WINDOW_MS || 30 * 60 * 1000);
const ATTEMPT_MAX_FAILURES = Number(process.env.AUTH_ATTEMPT_MAX_FAILURES || 5);
const ATTEMPT_BASE_LOCK_MS = Number(process.env.AUTH_ATTEMPT_BASE_LOCK_MS || 60 * 1000);
const ATTEMPT_MAX_LOCK_MS = Number(process.env.AUTH_ATTEMPT_MAX_LOCK_MS || 15 * 60 * 1000);

function nowMs() {
  return Date.now();
}

function getClientIp(req) {
  const header = req.headers["x-forwarded-for"];
  if (typeof header === "string" && header.length > 0) {
    return header.split(",")[0].trim();
  }
  return req.ip || req.socket?.remoteAddress || "unknown";
}

function normalizeEmail(email) {
  if (typeof email !== "string") {
    return "";
  }
  return email.trim().toLowerCase();
}

function computeRetrySeconds(until) {
  return Math.max(1, Math.ceil((until - nowMs()) / 1000));
}

function getOrCreateRateBucket(ip) {
  const current = loginRateBuckets.get(ip);
  const now = nowMs();

  if (!current || now - current.windowStart >= RATE_LIMIT_WINDOW_MS) {
    const fresh = { windowStart: now, count: 0 };
    loginRateBuckets.set(ip, fresh);
    return fresh;
  }

  return current;
}

function buildAttemptKey(req, email) {
  const ip = getClientIp(req);
  const normalizedEmail = normalizeEmail(email);
  return normalizedEmail ? `${ip}:${normalizedEmail}` : ip;
}

function getOrCreateAttemptBucket(key) {
  const current = loginAttemptBuckets.get(key);
  const now = nowMs();

  if (!current || now - current.windowStart >= ATTEMPT_WINDOW_MS) {
    const fresh = { windowStart: now, failures: 0, lockedUntil: 0 };
    loginAttemptBuckets.set(key, fresh);
    return fresh;
  }

  return current;
}

function isBucketLocked(bucket) {
  return bucket.lockedUntil && bucket.lockedUntil > nowMs();
}

function loginRateLimitMiddleware(req, res, next) {
  const ip = getClientIp(req);
  const bucket = getOrCreateRateBucket(ip);

  bucket.count += 1;

  if (bucket.count > RATE_LIMIT_MAX_REQUESTS) {
    const retryAfterMs = bucket.windowStart + RATE_LIMIT_WINDOW_MS;
    const retryAfterSeconds = computeRetrySeconds(retryAfterMs);
    res.set("Retry-After", String(retryAfterSeconds));
    return res.status(429).json({
      error: "Muitas tentativas de login. Tente novamente em instantes."
    });
  }

  return next();
}

function ensureLoginNotBlocked(req, res, next) {
  const key = buildAttemptKey(req, req.body?.email);
  const bucket = getOrCreateAttemptBucket(key);

  if (!isBucketLocked(bucket)) {
    return next();
  }

  const retryAfterSeconds = computeRetrySeconds(bucket.lockedUntil);
  res.set("Retry-After", String(retryAfterSeconds));
  return res.status(429).json({
    error: "Login temporariamente bloqueado por excesso de tentativas.",
    retryAfterSeconds
  });
}

function registerFailedLoginAttempt(req, email) {
  const key = buildAttemptKey(req, email);
  const bucket = getOrCreateAttemptBucket(key);

  bucket.failures += 1;

  if (bucket.failures < ATTEMPT_MAX_FAILURES) {
    return { blocked: false };
  }

  const power = bucket.failures - ATTEMPT_MAX_FAILURES;
  const computedLockMs = ATTEMPT_BASE_LOCK_MS * Math.pow(2, power);
  const lockMs = Math.min(computedLockMs, ATTEMPT_MAX_LOCK_MS);

  bucket.lockedUntil = nowMs() + lockMs;

  return {
    blocked: true,
    retryAfterSeconds: computeRetrySeconds(bucket.lockedUntil)
  };
}

function clearLoginAttempts(req, email) {
  const key = buildAttemptKey(req, email);
  loginAttemptBuckets.delete(key);
}

module.exports = {
  loginRateLimitMiddleware,
  ensureLoginNotBlocked,
  registerFailedLoginAttempt,
  clearLoginAttempts
};
