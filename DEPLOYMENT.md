# ClassMate AI - Deployment Guide

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and pnpm
- Docker and Docker Compose
- PostgreSQL 16+ with pgvector extension
- Redis
- AWS S3 bucket (for file storage)
- OpenAI API key

### 1. Environment Setup

```bash
# Clone and install dependencies
git clone <repository-url>
cd classmate-ai
pnpm install

# Copy environment template
cp env.example .env

# Edit .env with your configuration
```

### 2. Database Setup

```bash
# Start PostgreSQL and Redis with Docker
docker-compose up -d postgres redis

# Generate Prisma client
cd apps/api
pnpm db:generate

# Run database migrations
pnpm db:push
```

### 3. Development

```bash
# Start all services
pnpm dev

# Or start individually
pnpm --filter @classmateai/web dev    # Frontend: http://localhost:3000
pnpm --filter @classmateai/api dev    # Backend: http://localhost:3001
```

## 🌐 Production Deployment

### Frontend (Vercel)

1. **Connect Repository**
   - Link your GitHub repository to Vercel
   - Set root directory to `apps/web`

2. **Environment Variables**
   ```
   NEXT_PUBLIC_API_URL=https://your-api-domain.com
   ```

3. **Build Settings**
   - Framework: Next.js
   - Build Command: `pnpm build`
   - Output Directory: `.next`

### Backend (Railway/Fly.io)

#### Option A: Railway

1. **Connect Repository**
   - Link GitHub repository
   - Set root directory to `apps/api`

2. **Environment Variables**
   ```
   DATABASE_URL=postgresql://...
   REDIS_URL=redis://...
   OPENAI_API_KEY=sk-...
   AWS_ACCESS_KEY_ID=...
   AWS_SECRET_ACCESS_KEY=...
   JWT_SECRET=...
   ```

3. **Deploy**
   - Railway will automatically build and deploy

#### Option B: Fly.io

1. **Install Fly CLI**
   ```bash
   curl -L https://fly.io/install.sh | sh
   ```

2. **Create Fly App**
   ```bash
   cd apps/api
   fly launch
   ```

3. **Set Secrets**
   ```bash
   fly secrets set DATABASE_URL="postgresql://..."
   fly secrets set REDIS_URL="redis://..."
   fly secrets set OPENAI_API_KEY="sk-..."
   ```

4. **Deploy**
   ```bash
   fly deploy
   ```

### Database (Neon/Supabase)

#### Option A: Neon (Recommended)

1. **Create Database**
   - Sign up at [neon.tech](https://neon.tech)
   - Create new project
   - Enable pgvector extension

2. **Connection String**
   ```
   DATABASE_URL=postgresql://username:password@ep-xxx.us-east-1.aws.neon.tech/neondb?sslmode=require
   ```

#### Option B: Supabase

1. **Create Project**
   - Sign up at [supabase.com](https://supabase.com)
   - Create new project

2. **Enable Extensions**
   ```sql
   CREATE EXTENSION vector;
   ```

3. **Connection String**
   ```
   DATABASE_URL=postgresql://postgres:password@db.xxx.supabase.co:5432/postgres
   ```

### Redis (Upstash)

1. **Create Database**
   - Sign up at [upstash.com](https://upstash.com)
   - Create Redis database

2. **Connection String**
   ```
   REDIS_URL=redis://default:password@xxx.upstash.io:6379
   ```

### File Storage (AWS S3)

1. **Create S3 Bucket**
   - AWS Console → S3 → Create bucket
   - Enable versioning and encryption

2. **IAM User**
   - Create IAM user with S3 permissions
   - Generate access keys

3. **Environment Variables**
   ```
   AWS_ACCESS_KEY_ID=AKIA...
   AWS_SECRET_ACCESS_KEY=...
   AWS_REGION=us-east-1
   AWS_S3_BUCKET=your-bucket-name
   ```

## 🔧 Configuration

### Required Environment Variables

```bash
# Database
DATABASE_URL="postgresql://..."

# Redis
REDIS_URL="redis://..."

# AI Services
OPENAI_API_KEY="sk-..."
ANTHROPIC_API_KEY="..."

# File Storage
AWS_ACCESS_KEY_ID="..."
AWS_SECRET_ACCESS_KEY="..."
AWS_REGION="us-east-1"
AWS_S3_BUCKET="..."

# Authentication
JWT_SECRET="your-secret-key"
CLERK_SECRET_KEY="..."

# API Configuration
PORT=3001
NODE_ENV="production"
FRONTEND_URL="https://your-frontend-domain.com"
```

### Optional Environment Variables

```bash
# External Services
GOOGLE_CLASSROOM_CLIENT_ID="..."
GOOGLE_CLASSROOM_CLIENT_SECRET="..."

# Monitoring
SENTRY_DSN="..."
DATADOG_API_KEY="..."

# Feature Flags
DEFAULT_AI_PROVIDER="openai"
```

## 📊 Monitoring & Observability

### Sentry (Error Tracking)

1. **Setup**
   ```bash
   # Frontend
   npm install @sentry/nextjs
   
   # Backend
   npm install @sentry/node
   ```

2. **Configuration**
   ```javascript
   // sentry.client.config.js
   Sentry.init({
     dsn: process.env.SENTRY_DSN,
     environment: process.env.NODE_ENV,
   });
   ```

### DataDog (APM)

1. **Install Agent**
   ```bash
   # Add to Dockerfile
   RUN apt-get update && apt-get install -y datadog-agent
   ```

2. **Configuration**
   ```yaml
   # datadog.yaml
   api_key: ${DATADOG_API_KEY}
   logs_enabled: true
   apm_config:
     enabled: true
   ```

### PostHog (Analytics)

1. **Setup**
   ```bash
   npm install posthog-js
   ```

2. **Configuration**
   ```javascript
   posthog.init(process.env.NEXT_PUBLIC_POSTHOG_KEY, {
     api_host: 'https://app.posthog.com',
   });
   ```

## 🔒 Security Checklist

- [ ] Enable HTTPS (SSL certificates)
- [ ] Set up CSP headers
- [ ] Configure CORS properly
- [ ] Use environment variables for secrets
- [ ] Enable database encryption at rest
- [ ] Set up backup and disaster recovery
- [ ] Configure rate limiting
- [ ] Enable audit logging
- [ ] Set up monitoring and alerting
- [ ] Regular security updates

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Errors**
   ```bash
   # Check connection string
   echo $DATABASE_URL
   
   # Test connection
   psql $DATABASE_URL -c "SELECT 1;"
   ```

2. **Redis Connection Issues**
   ```bash
   # Test Redis connection
   redis-cli -u $REDIS_URL ping
   ```

3. **File Upload Failures**
   ```bash
   # Check S3 permissions
   aws s3 ls s3://your-bucket-name
   ```

4. **AI Service Errors**
   ```bash
   # Test OpenAI API
   curl -H "Authorization: Bearer $OPENAI_API_KEY" \
        https://api.openai.com/v1/models
   ```

### Logs and Debugging

```bash
# View application logs
fly logs

# View database logs
fly logs -a your-db-app

# View Redis logs
fly logs -a your-redis-app
```

## 📈 Scaling

### Horizontal Scaling

1. **API Servers**
   - Use load balancer (Railway/Fly.io handle this)
   - Scale based on CPU/memory usage

2. **Database**
   - Read replicas for read-heavy workloads
   - Connection pooling (PgBouncer)

3. **Redis**
   - Redis Cluster for high availability
   - Separate instances for different use cases

### Performance Optimization

1. **Frontend**
   - Enable CDN (Vercel Edge Network)
   - Image optimization
   - Code splitting

2. **Backend**
   - Redis caching
   - Database indexing
   - Connection pooling

3. **AI Services**
   - Response caching
   - Request batching
   - Model optimization

## 🎯 Production Checklist

- [ ] Environment variables configured
- [ ] Database migrations applied
- [ ] SSL certificates installed
- [ ] Monitoring setup
- [ ] Backup strategy implemented
- [ ] Security headers configured
- [ ] Rate limiting enabled
- [ ] Error tracking active
- [ ] Performance monitoring
- [ ] Documentation updated

Your ClassMate AI platform is now ready for production! 🎉
