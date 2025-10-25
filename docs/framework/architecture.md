# Architecture Principles

## Core Philosophy: "Impossible to Mess Up"

**Strong opinions, proven patterns, and strict constraints that make it nearly impossible to build bad software when following this framework.**

## Architecture Principles

### **1. "Everything Through tRPC"**
- **No REST APIs** - All communication via tRPC procedures
- **External APIs hidden** - All external calls wrapped in tRPC procedures
- **Type safety end-to-end** - Client and server share TypeScript types
- **No OpenAPI needed** - tRPC is self-documenting

### **2. "Database-First Development"**
- **Drizzle schemas drive everything**
- **tRPC procedures built on database models**
- **Zod validation for all inputs/outputs**
- **Better Auth integration with user context**

### **3. "Cache External Data"**
- **External APIs → tRPC procedures → Supabase cache → Frontend**
- **No direct external API calls from frontend**
- **Server-side API keys and authentication**
- **Graceful error handling and fallbacks**

## Data Flow Architecture

### **Unidirectional Data Flow**
```
Database (Supabase) → Drizzle ORM → tRPC Procedures → React Components → UI
```

### **External API Integration**
```
External API → tRPC Procedure → Supabase Cache → Frontend
```

### **Authentication Flow**
```
User Login → Better Auth → Session → tRPC Context → Protected Procedures
```

## Project Structure (Impossible to Mess Up)

### **Root Level Structure**
```
/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Route groups
│   ├── api/trpc/          # tRPC API routes
│   ├── globals.css        # Global styles
│   └── layout.tsx         # Root layout
├── components/            # Reusable components
│   ├── ui/               # shadcn/ui components
│   ├── forms/            # Form components
│   └── layout/           # Layout components
├── lib/                  # Core utilities
│   ├── auth.ts           # Better Auth config
│   ├── db.ts             # Drizzle setup
│   ├── trpc.ts           # tRPC setup
│   ├── validations.ts    # Zod schemas
│   └── utils.ts          # Utility functions
├── types/                # TypeScript definitions
│   └── index.ts
├── hooks/                # Custom React hooks
├── server/               # Server-only code
│   ├── api/              # External API integrations
│   └── jobs/             # trigger.dev jobs
└── public/               # Static assets
```

### **File Naming Conventions**
- **Components**: `PascalCase.tsx` (e.g., `UserProfile.tsx`)
- **Utilities**: `camelCase.ts` (e.g., `formatDate.ts`)
- **Types**: `camelCase.ts` (e.g., `userTypes.ts`)
- **Constants**: `UPPER_SNAKE_CASE.ts` (e.g., `API_ENDPOINTS.ts`)

## Component Architecture

### **Server Components (Default)**
```typescript
// app/dashboard/page.tsx - Server Component
import { api } from '@/lib/trpc/server'

export default async function DashboardPage() {
  // Server-side data fetching
  const user = await api.users.getCurrent()
  const posts = await api.posts.getUserPosts()
  
  return (
    <div>
      <h1>Welcome, {user.name}</h1>
      <PostsList posts={posts} />
    </div>
  )
}
```

### **Client Components (When Needed)**
```typescript
// components/PostsList.tsx - Client Component
'use client'

import { api } from '@/lib/trpc/client'

export function PostsList({ posts }: { posts: Post[] }) {
  const [newPost, setNewPost] = useState('')
  
  const createPost = api.posts.create.useMutation({
    onSuccess: () => {
      // Refetch posts
      utils.posts.getUserPosts.invalidate()
    }
  })
  
  return (
    <div>
      {posts.map(post => <PostItem key={post.id} post={post} />)}
      <form onSubmit={handleSubmit}>
        <input value={newPost} onChange={e => setNewPost(e.target.value)} />
        <button type="submit">Create Post</button>
      </form>
    </div>
  )
}
```

## API Architecture

### **tRPC Setup**
```typescript
// lib/trpc.ts
import { createTRPCContext } from './trpc'
import { auth } from './auth' // Better Auth instance

export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  const session = await auth.api.getSession({
    headers: opts.req.headers
  })
  
  return {
    user: session?.user || null,
    // ... other context
  }
}

// Protected procedure
export const protectedProcedure = publicProcedure
  .use(({ ctx, next }) => {
    if (!ctx.user) {
      throw new TRPCError({ code: 'UNAUTHORIZED' })
    }
    return next({ ctx: { ...ctx, user: ctx.user } })
  })
```

### **External API Integration**
```typescript
// tRPC procedure that fetches from external API
const getWeatherData = publicProcedure
  .input(z.object({ city: z.string() }))
  .query(async ({ input }) => {
    // Check cache first
    const cached = await db.weather.findFirst({
      where: { city: input.city, updatedAt: { gte: new Date(Date.now() - 3600000) } }
    })
    
    if (cached) return cached.data
    
    // Fetch from external API
    const weather = await fetch(`https://api.weather.com/${input.city}`)
    const data = await weather.json()
    
    // Cache in database
    await db.weather.upsert({
      where: { city: input.city },
      update: { data, updatedAt: new Date() },
      create: { city: input.city, data, updatedAt: new Date() }
    })
    
    return data
  })
```

## Database Architecture

### **Drizzle Schema Patterns**
```typescript
// lib/db/schema.ts
import { pgTable, text, timestamp, uuid } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').notNull().unique(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow()
})

export const posts = pgTable('posts', {
  id: uuid('id').primaryKey().defaultRandom(),
  title: text('title').notNull(),
  content: text('content').notNull(),
  userId: uuid('user_id').references(() => users.id),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow()
})
```

### **Database Access Patterns**
```typescript
// lib/trpc.ts - Database access through tRPC
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({
      where: { userId: ctx.user.id }
    })
  })

const createPost = protectedProcedure
  .input(z.object({ title: z.string(), content: z.string() }))
  .mutation(async ({ ctx, input }) => {
    return db.posts.create({
      data: {
        ...input,
        userId: ctx.user.id
      }
    })
  })
```

## Security Architecture

### **Authentication Patterns**
```typescript
// lib/auth.ts - Better Auth configuration
export const auth = betterAuth({
  database: drizzleAdapter(db),
  emailAndPassword: { enabled: true },
  socialProviders: { google: { /* config */ } }
})
```

### **Authorization Patterns**
```typescript
// lib/trpc.ts - Authorization middleware
export const protectedProcedure = publicProcedure
  .use(({ ctx, next }) => {
    if (!ctx.user) throw new TRPCError({ code: 'UNAUTHORIZED' })
    return next({ ctx: { ...ctx, user: ctx.user } })
  })

export const adminProcedure = protectedProcedure
  .use(({ ctx, next }) => {
    if (ctx.user.role !== 'admin') throw new TRPCError({ code: 'FORBIDDEN' })
    return next({ ctx })
  })
```

### **Data Access Patterns**
```typescript
// User can only access their own data
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({ where: { userId: ctx.user.id } })
  })

// Admin can access all data
const getAllUsers = adminProcedure
  .query(async () => {
    return db.users.findMany()
  })
```

## Performance Architecture

### **Caching Strategy**
```typescript
// lib/trpc.ts - Caching with tRPC
export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  const session = await auth.api.getSession({ headers: opts.req.headers })
  
  return {
    user: session?.user || null,
    cache: new Map(), // Simple in-memory cache
  }
}

// tRPC procedure with caching
const getPosts = publicProcedure
  .query(async ({ ctx }) => {
    const cacheKey = 'posts:all'
    const cached = ctx.cache.get(cacheKey)
    
    if (cached) return cached
    
    const posts = await db.posts.findMany()
    ctx.cache.set(cacheKey, posts)
    
    return posts
  })
```

### **Image Optimization**
```typescript
// components/OptimizedImage.tsx
import Image from 'next/image'

export function OptimizedImage({ src, alt, ...props }) {
  return (
    <Image
      src={src}
      alt={alt}
      width={800}
      height={600}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwCdABmX/9k="
      {...props}
    />
  )
}
```

## Error Handling Architecture

### **Global Error Boundaries**
```typescript
// components/ErrorBoundary.tsx
'use client'

import { useEffect } from 'react'
import { useToast } from '@/hooks/use-toast'

export function ErrorBoundary({ children }: { children: React.ReactNode }) {
  const { toast } = useToast()

  useEffect(() => {
    const handleError = (error: ErrorEvent) => {
      toast({
        title: 'Something went wrong',
        description: 'An unexpected error occurred. Please refresh the page.',
        variant: 'destructive'
      })
    }

    window.addEventListener('error', handleError)
    return () => window.removeEventListener('error', handleError)
  }, [toast])

  return <>{children}</>
}
```

### **API Error Handling**
```typescript
// lib/trpc.ts - Error handling
export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  try {
    const session = await auth.api.getSession({ headers: opts.req.headers })
    return { user: session?.user || null }
  } catch (error) {
    logger.error('Failed to create tRPC context', { error })
    throw new TRPCError({ code: 'INTERNAL_SERVER_ERROR' })
  }
}
```

## What This Architecture Prevents

### **Over-Engineering**
- No unnecessary state management libraries
- No complex caching solutions until needed
- No external services until required
- No custom implementations of standard patterns

### **Inconsistency**
- Same patterns across all projects
- Consistent technology choices
- Predictable project structure
- Standardized development workflow

### **Security Issues**
- API keys never exposed to frontend
- Authentication handled by battle-tested Better Auth
- Type-safe database access with Drizzle
- Input validation with Zod

### **Performance Issues**
- Optimized services (Vercel, Supabase, etc.)
- Built-in caching and optimization
- Type-safe, compile-time error checking
- Minimal bundle size with tree-shaking

This architecture creates a **"perfect puzzle"** where every piece fits together seamlessly, making it nearly impossible to build bad software when following these patterns.
