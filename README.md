# ClassMate AI - K-12 Education Platform

ClassMate AI is a comprehensive K-12 education platform that leverages artificial intelligence to help teachers create engaging lessons, generate quizzes, and enhance classroom experiences.

## 🚀 Features

- **AI-Powered Lesson Generation**: Create comprehensive lesson plans from educational materials
- **Automated Quiz Creation**: Generate engaging quizzes with various question types
- **RAG (Retrieval-Augmented Generation)**: Intelligent content search and retrieval
- **Multi-tenant Architecture**: Support for schools, districts, and organizations
- **LMS Integration**: Google Classroom, Canvas, and other platform integrations
- **Real-time Collaboration**: Live classroom features and student engagement tools
- **Compliance Ready**: FERPA, COPPA, and district security requirements

## 🏗️ Architecture

This is a monorepo built with modern technologies:

### Frontend (Next.js)
- **Framework**: Next.js 14 with App Router
- **UI**: Tailwind CSS + shadcn/ui components
- **State Management**: TanStack Query (React Query)
- **Authentication**: Clerk
- **Internationalization**: next-intl

### Backend (NestJS)
- **Framework**: NestJS with TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Vector Search**: pgvector for RAG capabilities
- **Caching/Queues**: Redis with BullMQ
- **File Storage**: AWS S3
- **API Documentation**: Swagger/OpenAPI

### AI/ML Layer
- **Model Broker**: Support for OpenAI, Anthropic, and Azure OpenAI
- **Embeddings**: OpenAI text-embedding-3-large
- **RAG**: pgvector for semantic search
- **Speech**: Whisper (STT) and OpenAI TTS

### Shared Packages
- `@classmateai/ui`: Shared UI components
- `@classmateai/types`: Zod schemas and TypeScript types
- `@classmateai/core`: Domain logic and services
- `@classmateai/prompts`: AI prompt templates

## 🛠️ Development Setup

### Prerequisites
- Node.js 18+ and pnpm
- PostgreSQL 16+
- Redis
- Docker (optional, for local development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd classmate-ai
   ```

2. **Install dependencies**
   ```bash
   pnpm install
   ```

3. **Set up environment variables**
   ```bash
   cp env.example .env
   # Edit .env with your configuration
   ```

4. **Set up the database**
   ```bash
   cd apps/api
   pnpm db:generate
   pnpm db:push
   ```

5. **Start development servers**
   ```bash
   # Start all services
   pnpm dev
   
   # Or start individually
   pnpm --filter @classmateai/web dev    # Frontend on :3000
   pnpm --filter @classmateai/api dev    # Backend on :3001
   ```

## 📁 Project Structure

```
classmate-ai/
├── apps/
│   ├── web/                 # Next.js frontend
│   └── api/                 # NestJS backend
├── packages/
│   ├── ui/                  # Shared UI components
│   ├── types/               # Zod schemas & types
│   ├── core/                # Domain logic
│   └── prompts/             # AI prompt templates
├── turbo.json              # Turborepo configuration
├── package.json            # Root package.json
└── pnpm-workspace.yaml     # pnpm workspace config
```

## 🚀 Deployment

### Frontend (Vercel)
- Automatic deployment from main branch
- Edge functions for API routes
- Image optimization and CDN

### Backend (Railway/Fly.io)
- Docker container deployment
- Auto-scaling based on load
- Database migrations on deploy

### Infrastructure
- **Database**: PostgreSQL with pgvector extension
- **Cache**: Redis (Upstash or AWS ElastiCache)
- **Storage**: AWS S3 with CloudFront CDN
- **Monitoring**: Sentry, DataDog, PostHog

## 🔐 Security & Compliance

- **Authentication**: JWT tokens with Clerk integration
- **Authorization**: Role-based access control (RBAC)
- **Data Protection**: AES-256 encryption at rest
- **PII Handling**: Automated detection and scrubbing
- **Audit Logging**: Comprehensive activity tracking
- **GDPR/FERPA**: Data export and deletion capabilities

## 📊 Monitoring & Analytics

- **Error Tracking**: Sentry for frontend and backend
- **Performance**: DataDog APM and metrics
- **Analytics**: PostHog for user behavior
- **Logs**: Structured logging with correlation IDs

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: [docs.classmateai.com](https://docs.classmateai.com)
- **Issues**: [GitHub Issues](https://github.com/classmateai/platform/issues)
- **Discord**: [Community Discord](https://discord.gg/classmateai)
- **Email**: support@classmateai.com

---

Built with ❤️ for educators and students worldwide.
