import { NextResponse } from "next/server";

export async function GET() {
  const comprehensiveGuide = `# webchella - Complete Framework

## Overview
The webchella is a comprehensive framework for building web applications with AI agents. It provides strict guardrails, proven patterns, and a systematic approach to development that makes it impossible to mess up.

## Technology Stack (Non-Negotiable)
- **Frontend**: Next.js 14+ (App Router) + TypeScript + Tailwind CSS 4+ + shadcn/ui
- **Backend**: Supabase (PostgreSQL) + Drizzle ORM + tRPC + Zod + Better Auth
- **External**: Supabase Storage + Resend + Stripe + Vercel AI SDK + trigger.dev
- **Development**: Vitest + Testing Library + Pino + Vercel

## Development Methodology (Back-to-Front)
1. **Phase 1: Data Planning** - Plan features, data needs, database schema
2. **Phase 2: Database Layer** - Create Drizzle schemas and migrations
3. **Phase 3: API Layer** - Build tRPC procedures and validation
4. **Phase 4: UI Layer** - Create components and pages
5. **Phase 5: Polish** - Add loading states, error handling, responsiveness
6. **Phase 6: Testing** - Write tests and verify functionality

## Code Quality Rules
- **TypeScript strict mode**: No \`any\` types, explicit returns
- **ESLint + Prettier**: Consistent formatting
- **No console.log in production**: Use Pino for logging
- **Validate all inputs**: Use Zod schemas
- **Use protected procedures**: No direct database access

## AI Agent Rules
- **Complete current phase before moving to next phase**
- **Ask permission to proceed to next phase**
- **Use only approved technologies**
- **Follow established patterns**
- **Document all decisions**

## Project Structure
\`\`\`
/app                    # Next.js App Router
/components             # Reusable components
  /ui                  # shadcn/ui components
/lib                   # Core utilities
  /auth.ts            # Better Auth config
  /db.ts              # Drizzle setup
  /trpc.ts            # tRPC setup
  /validations.ts     # Zod schemas
/types                # TypeScript definitions
/hooks                # Custom React hooks
/server               # Server-only code
\`\`\`

## Design System
- **Use shadcn/ui components by default**
- **Use Tailwind utility classes**
- **Use CSS variables for theming**
- **Support light and dark themes**
- **Follow responsive design patterns**

## Error Handling
- **Use global error boundaries**
- **Handle all errors gracefully**
- **Use toast notifications for user feedback**
- **Log errors with Pino**
- **Provide recovery options**

## Testing Strategy
- **Write unit tests for tRPC procedures**
- **Write component tests for UI**
- **Write integration tests for API**
- **Test accessibility compliance**
- **Verify end-to-end functionality**

## Security & Performance
- **Use Better Auth for authentication**
- **Validate all inputs with Zod**
- **Use protected procedures for user data**
- **Optimize bundle size and performance**
- **Monitor errors and performance**

## Documentation
- **Document all decisions**
- **Use clear, concise language**
- **Provide examples and patterns**
- **Keep documentation up to date**
- **Share knowledge and best practices**

## Quick Start Commands

### 1. Create New Project
\`\`\`bash
npx create-next-app@latest my-project --typescript --tailwind --app
cd my-project
\`\`\`

### 2. Install Dependencies
\`\`\`bash
npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client @trpc/next zod better-auth pino
npm install -D @types/node eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom
\`\`\`

### 3. Set Up Environment
\`\`\`bash
# Create .env.local
touch .env.local

# Add environment variables
echo "NEXT_PUBLIC_SUPABASE_URL=your_supabase_url" >> .env.local
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key" >> .env.local
echo "SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key" >> .env.local
echo "DATABASE_URL=your_database_url" >> .env.local
echo "NEXTAUTH_SECRET=your_nextauth_secret" >> .env.local
echo "NEXTAUTH_URL=http://localhost:3000" >> .env.local
\`\`\`

### 4. Start Development
\`\`\`bash
npm run dev
\`\`\`

This is the complete webchella framework - everything you need to build consistent, high-quality web applications with AI agents.
`;

  return new NextResponse(comprehensiveGuide, {
    headers: {
      "Content-Type": "text/plain",
      "Content-Disposition":
        'attachment; filename="blueberry-prompt-kit-complete.txt"',
    },
  });
}
