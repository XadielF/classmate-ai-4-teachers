# Multi-stage build for the API
FROM node:18-alpine AS base

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app

# Copy package files
COPY package.json pnpm-workspace.yaml pnpm-lock.yaml* ./
COPY apps/api/package.json ./apps/api/
COPY packages/*/package.json ./packages/*/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Build packages
COPY packages/ ./packages/
RUN pnpm --filter @classmateai/types build
RUN pnpm --filter @classmateai/core build
RUN pnpm --filter @classmateai/prompts build

# Build API
COPY apps/api/ ./apps/api/
RUN pnpm --filter @classmateai/api build

# Production stage
FROM node:18-alpine AS production

WORKDIR /app

# Install pnpm
RUN npm install -g pnpm

# Copy built application
COPY --from=base /app/apps/api/dist ./dist
COPY --from=base /app/apps/api/package.json ./package.json
COPY --from=base /app/apps/api/prisma ./prisma
COPY --from=base /app/node_modules ./node_modules

# Generate Prisma client
RUN pnpm prisma generate

EXPOSE 3001

CMD ["node", "dist/main.js"]
