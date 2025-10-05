# ClassMate AI - Architecture Overview

## 🏗️ System Architecture

ClassMate AI is built as a modern, scalable monorepo with the following architecture:

### Frontend (Next.js)
- **Location**: `apps/web/`
- **Framework**: Next.js 14 with App Router
- **UI Library**: Tailwind CSS + shadcn/ui components
- **State Management**: TanStack Query (React Query)
- **Authentication**: Clerk integration
- **Internationalization**: next-intl support

### Backend (NestJS)
- **Location**: `apps/api/`
- **Framework**: NestJS with TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Vector Search**: pgvector extension for RAG
- **Caching/Queues**: Redis with BullMQ
- **API Documentation**: Swagger/OpenAPI

### Shared Packages
- **`@classmateai/ui`**: Reusable UI components (Button, Card, Input, etc.)
- **`@classmateai/types`**: Zod schemas and TypeScript types
- **`@classmateai/core`**: Domain logic and service interfaces
- **`@classmateai/prompts`**: AI prompt templates for lessons, quizzes, and RAG

## 📊 Database Schema

### Core Entities
- **Orgs**: Multi-tenant organizations (schools, districts)
- **Users**: Teachers, students, admins, parents
- **Classes**: Classroom management
- **Materials**: Uploaded educational content
- **Chunks**: RAG document chunks with embeddings
- **Quizzes**: Generated assessments
- **Questions**: Quiz questions with various types
- **Responses**: Student quiz responses

### Key Features
- **Multi-tenancy**: Org-scoped data with Row-Level Security
- **Vector Search**: pgvector for semantic search
- **Audit Logging**: Comprehensive activity tracking
- **Usage Tracking**: Token and feature usage monitoring

## 🤖 AI/ML Integration

### Model Broker Service
- **OpenAI**: GPT-4, GPT-3.5, text-embedding-3-large
- **Anthropic**: Claude 3 (Opus, Sonnet, Haiku)
- **Azure OpenAI**: Enterprise-grade deployments
- **Failover**: Automatic provider switching

### RAG Implementation
- **Document Processing**: Chunking with overlap
- **Embeddings**: OpenAI text-embedding-3-large
- **Vector Storage**: pgvector in PostgreSQL
- **Semantic Search**: Cosine similarity with metadata filtering

### Prompt Engineering
- **Lesson Generation**: Structured prompts for K-12 content
- **Quiz Creation**: Multi-type question generation
- **RAG Queries**: Context-aware educational responses
- **Validation**: Quality assurance and bias detection

## 🔐 Security & Compliance

### Authentication & Authorization
- **JWT Tokens**: Secure API authentication
- **Role-Based Access**: Admin, Teacher, Student, Parent roles
- **Multi-tenant**: Org-scoped resource access
- **Clerk Integration**: Enterprise SSO support

### Data Protection
- **Encryption**: AES-256 at rest, TLS 1.3 in transit
- **PII Handling**: Automated detection and scrubbing
- **Audit Logs**: Immutable activity tracking
- **GDPR/FERPA**: Data export and deletion capabilities

### Infrastructure Security
- **CSP Headers**: Content Security Policy
- **Rate Limiting**: API throttling and abuse prevention
- **Input Validation**: Zod schema validation
- **Dependency Scanning**: Automated vulnerability detection

## 🚀 Deployment Architecture

### Development Environment
```bash
# Local development with Docker
docker-compose up -d postgres redis
pnpm dev
```

### Production Deployment
- **Frontend**: Vercel (Edge functions, CDN)
- **Backend**: Railway/Fly.io (Docker containers)
- **Database**: PostgreSQL with pgvector (Neon/RDS)
- **Cache**: Redis (Upstash/ElastiCache)
- **Storage**: AWS S3 with CloudFront CDN

### CI/CD Pipeline
- **GitHub Actions**: Automated testing and deployment
- **Multi-stage builds**: Optimized Docker images
- **Database migrations**: Automated schema updates
- **Feature flags**: Gradual rollout capabilities

## 📈 Monitoring & Observability

### Application Monitoring
- **Sentry**: Error tracking and performance monitoring
- **DataDog**: APM, metrics, and logging
- **PostHog**: Product analytics and feature flags

### Infrastructure Monitoring
- **Health Checks**: Service availability monitoring
- **Performance Metrics**: Response times and throughput
- **Cost Tracking**: Token usage and spend monitoring
- **Alerting**: Slack notifications for critical issues

## 🔄 Development Workflow

### Getting Started
```bash
# Clone and setup
git clone <repo>
cd classmate-ai
pnpm install

# Start development
pnpm dev
```

### Available Commands
- `pnpm dev` - Start all development servers
- `pnpm build` - Build all packages
- `pnpm lint` - Lint all code
- `pnpm test` - Run test suite
- `pnpm db:generate` - Generate Prisma client
- `pnpm db:push` - Push schema changes

### Code Organization
- **Shared Types**: Centralized in `@classmateai/types`
- **UI Components**: Reusable in `@classmateai/ui`
- **Business Logic**: Domain services in `@classmateai/core`
- **AI Prompts**: Template management in `@classmateai/prompts`

## 🎯 MVP Roadmap

### Phase 1: Core Features (4-6 weeks)
- [x] Monorepo setup and shared packages
- [x] Authentication and user management
- [x] File upload and processing
- [x] Basic RAG implementation
- [x] Lesson generation from materials
- [x] Quiz creation and management

### Phase 2: Integrations (6-12 weeks)
- [ ] Google Classroom API integration
- [ ] LTI 1.3 support for LMS platforms
- [ ] Clever/ClassLink SSO
- [ ] Standards alignment
- [ ] Grade passback functionality

### Phase 3: Advanced Features (12+ weeks)
- [ ] Real-time classroom features
- [ ] Parent dashboards
- [ ] Advanced analytics
- [ ] Multi-language support
- [ ] Voice features (STT/TTS)

## 🔧 Configuration

### Environment Variables
- **Database**: `DATABASE_URL`
- **Redis**: `REDIS_URL`
- **AI Services**: `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`
- **Storage**: AWS credentials and S3 bucket
- **Auth**: JWT secrets and OAuth providers

### Feature Flags
- **A/B Testing**: PostHog integration
- **Gradual Rollout**: Feature toggles
- **Beta Features**: Early access controls

This architecture provides a solid foundation for building a scalable, secure, and maintainable K-12 education platform with AI-powered features.
