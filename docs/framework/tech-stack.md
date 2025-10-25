# Technology Stack

## Core Philosophy: "Battle-Tested & Opinionated"

This framework uses **strong opinions** based on what works best in the real world, with minimal dependencies and maximum type safety.

## Frontend Stack

### **Next.js 14+ (App Router) + TypeScript**
- **Why**: Full-stack framework, SSR/SSG built-in, scales from personal sites to enterprise
- **TypeScript**: Non-negotiable. Catches errors at compile time, scales with team size
- **App Router**: Latest Next.js routing system with server components

### **Tailwind CSS 4+ + shadcn/ui**
- **Tailwind CSS 4+**: ALWAYS use the latest version - improved performance, better caching, enhanced features
- **shadcn/ui**: Pre-built components with TypeScript, accessible by default
- **Radix UI**: Accessible primitives (when needed)
- **CSS Variables**: Theme system with CSS custom properties for consistent theming
- **NO ALTERNATIVES**: Never use CSS-in-JS, styled-components, or other CSS frameworks

### **What we DON'T use:**
- React without Next.js (missing too much)
- CSS-in-JS libraries (runtime overhead)
- Component libraries like Material-UI (too opinionated, hard to customize)

## Backend Stack

### **Supabase + Drizzle ORM**
- **Supabase**: PostgreSQL with built-in auth, real-time, storage, edge functions
- **Drizzle**: Type-safe database access, migrations, great DX
- **PostgreSQL**: Battle-tested, JSON support, scales to enterprise

### **tRPC + Zod**
- **tRPC**: Type-safe API calls, no API documentation needed, auto-completion everywhere
- **Zod**: Runtime validation, type inference, schema validation

### **Better Auth**
- **Better Auth**: Modern, better TypeScript, simpler configuration, better performance
- **What we DON'T use**: NextAuth (Better Auth is superior)

## External Services (Opinionated Choices)

### **File Storage: Supabase Storage**
- Integrated with database
- Built-in CDN and optimization
- No additional service needed

### **Email: Resend**
- Modern, developer-friendly
- Great TypeScript support
- Simple API

### **Payments: Stripe**
- Industry standard
- Comprehensive documentation
- TypeScript support

### **AI Integration: Vercel AI SDK**
- Built for Next.js
- Type-safe
- Streaming support

### **Background Jobs: trigger.dev**
- Type-safe background jobs
- Great developer experience
- Scales with your app

## Development & Production

### **Testing: Vitest + Testing Library**
- **Vitest**: Fast, modern testing framework
- **Testing Library**: Component testing best practices
- **No E2E testing by default** (add only if needed)

### **Logging: Pino**
- Fast, structured logging
- Great performance
- TypeScript support

### **Analytics: Vercel Analytics**
- Built-in with Vercel
- Core Web Vitals tracking
- No additional setup needed

### **Deployment: Vercel**
- Zero-config Next.js deployment
- Edge functions
- Automatic scaling

## What We Avoid (Anti-Patterns)

- **Over-engineering**: Don't add complexity until needed
- **Framework churn**: Stick to proven, stable choices
- **CSS-in-JS**: Runtime overhead
- **Redux for simple state**: Use React Context or Zustand
- **Separate backend**: Use Next.js API routes
- **NoSQL for relational data**: PostgreSQL handles everything
- **Custom CSS**: Use Tailwind utilities
- **Any types**: TypeScript strict mode

## Dependency Decision Framework

### **When to Add a New Dependency**
1. **"Does it solve a real problem?"** - Not just nice-to-have
2. **"Is it actively maintained?"** - Recent updates, good community
3. **"Does it fit our stack?"** - TypeScript, React, Next.js compatible
4. **"Is it lightweight?"** - Small bundle size, minimal dependencies
5. **"Can we build it ourselves?"** - Only add if building is too complex

### **Dependency Rules**
1. **"Start with core stack only"** - No additional dependencies by default
2. **"Add dependencies incrementally"** - One at a time, test each
3. **"Document why each dependency is needed"** - Clear justification
4. **"Regularly audit dependencies"** - Remove unused dependencies
5. **"Prefer built-in solutions"** - Use Next.js, React, TypeScript features

## Scaling Strategy

### **Personal Site → Restaurant → SaaS**
- Start with Next.js + Supabase + Drizzle + tRPC
- Add Better Auth for authentication
- Add shadcn/ui for components
- Add trigger.dev for background jobs
- Add Vercel AI SDK for AI features

### **The beauty**: Same stack scales from MVP to enterprise without rewrites.

## Core Dependencies (Non-Negotiable)

```json
{
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "typescript": "^5.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
    "tailwindcss": "^3.0.0",
    "drizzle-orm": "^0.29.0",
    "@supabase/supabase-js": "^2.0.0",
    "@trpc/server": "^10.0.0",
    "@trpc/client": "^10.0.0",
    "@trpc/next": "^10.0.0",
    "zod": "^3.0.0",
    "better-auth": "^0.1.0",
    "pino": "^8.0.0"
  }
}
```

## Development Dependencies (Essential)

```json
{
  "devDependencies": {
    "@types/node": "^20.0.0",
    "eslint": "^8.0.0",
    "eslint-config-next": "^14.0.0",
    "eslint-config-prettier": "^9.0.0",
    "prettier": "^3.0.0",
    "vitest": "^1.0.0",
    "@testing-library/react": "^14.0.0",
    "@testing-library/jest-dom": "^6.0.0"
  }
}
```

## Optional Dependencies (Add Only When Needed)

```json
{
  "dependencies": {
    "zustand": "^4.0.0", // Only if React Context insufficient
    "react-hook-form": "^7.0.0", // Only for complex forms
    "date-fns": "^2.0.0", // Only for date manipulation
    "clsx": "^2.0.0", // Only for conditional classes
    "lucide-react": "^0.0.0" // Only for icons
  }
}
```

This tech stack is **opinionated but flexible** - it makes the hard decisions so you don't have to, but allows customization within the constraints.
