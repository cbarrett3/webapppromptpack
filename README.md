# Blueberry Prompt Kit

```
    🫐🫐
   🫐🫐🫐🫐
  🫐🫐🫐🫐🫐
 🫐🫐🫐🫐🫐🫐
🫐🫐🫐🫐🫐🫐🫐
 🫐🫐🫐🫐🫐🫐
  🫐🫐🫐🫐🫐
   🫐🫐🫐🫐
    🫐🫐
```

A comprehensive framework for building web applications with AI agents. Provides strict guardrails, proven patterns, and a systematic approach to development.

## Core Philosophy

**"Impossible to Mess Up"** - The Blueberry Prompt Kit ensures consistent, high-quality results through:

- **Strict Guardrails** - Prevents over-engineering and keeps AI focused
- **Proven Patterns** - Battle-tested approaches that scale
- **Systematic Methodology** - 6-phase back-to-front development process
- **Type Safety Everywhere** - End-to-end TypeScript with validation
- **Production Ready** - Complete with testing, deployment, and optimization

## Quick Start

### 1. Get the Framework
```bash
# Clone the repository
git clone https://github.com/cbarrett3/blueberry-prompt-kit.git

# Or download the complete framework
curl -o blueberry-prompt-kit.zip https://github.com/cbarrett3/blueberry-prompt-kit/archive/refs/heads/main.zip
```

### 2. Copy Framework Files
```bash
# Copy Cursor rules to your project
cp blueberry-prompt-kit/.cursorrules ./

# Copy detailed Cursor configuration
cp -r blueberry-prompt-kit/.cursor ./
```

### 3. Install Dependencies
```bash
# Core framework dependencies
npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client @trpc/next zod better-auth pino

# Development dependencies
npm install -D @types/node eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom
```

### 4. Start Building
Follow the 6-phase development methodology with AI agents guiding each step.

## Development Methodology

### Phase 1: Data Planning
Plan features, model database schema, design API endpoints, map user flows

### Phase 2: Database Layer
Create Drizzle schemas, run migrations, set up relationships, test with sample data

### Phase 3: API Layer
Build tRPC procedures, add Zod validation, implement authentication, test API endpoints

### Phase 4: UI Layer
Create Next.js pages, build components with shadcn/ui, apply Tailwind CSS 4+ styling, implement responsive design

### Phase 5: Polish
Add loading states, implement error handling, optimize performance, add toast notifications

### Phase 6: Testing
Write unit tests, write component tests, write integration tests, test accessibility

## Technology Stack

### Frontend
- **Next.js 14+** (App Router) - Full-stack framework
- **TypeScript** (strict mode) - Type safety everywhere
- **Tailwind CSS 4+** - Utility-first styling (NON-NEGOTIABLE)
- **shadcn/ui** - Pre-built components

### Backend
- **Supabase** (PostgreSQL) - Database and auth
- **Drizzle ORM** - Type-safe database access
- **tRPC + Zod** - Type-safe APIs with validation
- **Better Auth** - Modern authentication

### External Services
- **Supabase Storage** - File storage
- **Resend** - Email service
- **Stripe** - Payments
- **Vercel AI SDK** - AI integration
- **trigger.dev** - Background jobs

### Development
- **Vitest + Testing Library** - Testing
- **Pino** - Logging
- **Vercel** - Deployment

## AI Agent System

### Master Agent
Coordinates the entire development process and ensures quality standards.

### Development Agents
- **Phase 1 Agent** - Data planning and requirements
- **Phase 2 Agent** - Database schema and migrations
- **Phase 3 Agent** - API development and validation
- **Phase 4 Agent** - UI components and pages (with Design Agent)
- **Phase 5 Agent** - Polish and optimization
- **Phase 6 Agent** - Testing and quality assurance

### PM Agents
- **Product Manager Agent** - Feature planning and prioritization
- **Roadmap Agent** - Long-term planning and strategy
- **Feature Planning Agent** - Detailed feature specifications
- **Sprint Planning Agent** - Sprint organization and execution
- **QA Agent** - Quality assurance and testing

### Design Agent
- **Clean, Professional Design** - Immaculate interfaces
- **Dark Mode Excellence** - Sophisticated dark themes
- **Data Visualization** - Clean charts and metrics display
- **Typography Mastery** - Perfect hierarchy and readability

## Project Structure

```
blueberry-prompt-kit/
├── .cursorrules                 # Cursor IDE rules
├── .cursor/                     # Detailed Cursor configuration
│   ├── rules/                  # Framework rules
│   └── prompts/                # Agent prompts
├── docs/                       # Complete documentation
│   ├── framework/              # Core framework docs
│   ├── agents/                 # AI agent coordination
│   └── templates/              # Ready-to-use templates
├── showcase/                   # Live demonstration
└── README.md                   # This file
```

## Design System

### Clean, Professional Design
- **Immaculate Clean Style** - Every pixel serves a purpose
- **Dark Mode Excellence** - Deep, rich backgrounds with high contrast text
- **Data-First Design** - Information architecture drives visual design
- **Sophisticated Typography** - Clean sans-serif with perfect hierarchy
- **Minimalist Aesthetic** - Uncluttered interfaces with purposeful whitespace

### Design Tokens
- **Colors** - Deep dark backgrounds, crisp white text, subtle accents
- **Typography** - font-semibold (not font-bold), clean hierarchy
- **Spacing** - Generous whitespace, purposeful breathing room
- **Components** - Dashboard cards, data visualization, clean buttons

## Configuration

### Cursor IDE Integration
The framework includes comprehensive Cursor IDE rules that:
- Enforce technology stack compliance
- Guide development methodology
- Ensure code quality standards
- Coordinate AI agent workflows

### Environment Setup
```bash
# Create environment file
touch .env.local

# Add environment variables
echo "NEXT_PUBLIC_SUPABASE_URL=your_supabase_url" >> .env.local
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key" >> .env.local
echo "SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key" >> .env.local
echo "DATABASE_URL=your_database_url" >> .env.local
echo "NEXTAUTH_SECRET=your_nextauth_secret" >> .env.local
echo "NEXTAUTH_URL=http://localhost:3000" >> .env.local
```

## Documentation

### Framework Documentation
- [Technology Stack](docs/framework/tech-stack.md)
- [Architecture](docs/framework/architecture.md)
- [Development Methodology](docs/framework/development-methodology.md)
- [Code Standards](docs/framework/code-standards.md)

### Agent Documentation
- [Master Agent](docs/agents/master-agent.md)
- [Development Agents](docs/agents/development-agents.md)
- [PM Agents](docs/agents/pm-agents.md)
- [Agent Coordination](docs/agents/agent-coordination.md)
- [Design Agent](docs/agents/design-agent.md)

### Templates
- [Next.js Project Setup](docs/templates/project-setup/nextjs-project.md)
- [tRPC Procedures](docs/templates/code-templates/trpc-procedures.md)
- [Feature Tickets](docs/templates/ticket-templates/feature-ticket.md)
- [Master Agent Prompt](docs/templates/agent-prompts/master-agent-prompt.md)

## Live Demo

Check out the [showcase application](showcase/) to see the framework in action:
- Framework overview and methodology
- Interactive examples and patterns
- Complete documentation
- Getting started guide

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the framework methodology
4. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

- **shadcn/ui** - Component foundation
- **Next.js Team** - Framework foundation
- **Supabase Team** - Backend infrastructure

---

**The Blueberry Prompt Kit ensures consistent, high-quality results that are impossible to mess up.**