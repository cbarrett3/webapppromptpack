# Code Standards

## TypeScript Configuration (Strict Standards)

### **tsconfig.json (Strict Configuration)**
```json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"]
    },
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noPropertyAccessFromIndexSignature": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
```

### **Type Definition Rules**
1. **"No `any` types"** - Use `unknown` if type is truly unknown
2. **"Interface over type for objects"** - Use interfaces for object shapes
3. **"Generic constraints where possible"** - Constrain generics with `extends`
4. **"Explicit return types for functions"** - Always specify return types
5. **"No implicit any"** - All parameters must be typed

### **Type Patterns**
```typescript
// ✅ Good: Interface for objects
interface User {
  id: string
  email: string
  role: 'admin' | 'user'
}

// ✅ Good: Type for unions/primitives
type Status = 'pending' | 'approved' | 'rejected'

// ✅ Good: Generic with constraints
function processData<T extends Record<string, unknown>>(data: T): T {
  return data
}

// ❌ Bad: Any types
function badFunction(data: any): any {
  return data
}
```

## ESLint Configuration (Strict Standards)

### **.eslintrc.json (Strict Configuration)**
```json
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "@typescript-eslint/recommended-requiring-type-checking",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module",
    "project": "./tsconfig.json"
  },
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/prefer-const": "error",
    "@typescript-eslint/no-non-null-assertion": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "no-console": "warn",
    "prefer-const": "error",
    "no-var": "error",
    "no-unused-vars": "off",
    "@typescript-eslint/no-unused-vars": "error"
  }
}
```

### **Prettier Configuration (Strict Standards)**
```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "bracketSameLine": false,
  "arrowParens": "avoid",
  "endOfLine": "lf"
}
```

### **Code Quality Rules**
1. **"No console.log in production"** - Use Pino for logging
2. **"No unused variables"** - Remove or prefix with underscore
3. **"Consistent formatting"** - Prettier handles this
4. **"Import order"** - External → Internal → Relative
5. **"No magic numbers"** - Use named constants

## Theming & Design System (Strict Standards)

### **CSS Variables (Design Tokens)**
```css
/* app/globals.css */
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    /* Light theme colors */
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --card: 0 0% 100%;
    --card-foreground: 222.2 84% 4.9%;
    --popover: 0 0% 100%;
    --popover-foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    --secondary: 210 40% 96%;
    --secondary-foreground: 222.2 47.4% 11.2%;
    --muted: 210 40% 96%;
    --muted-foreground: 215.4 16.3% 46.9%;
    --accent: 210 40% 96%;
    --accent-foreground: 222.2 47.4% 11.2%;
    --destructive: 0 84.2% 60.2%;
    --destructive-foreground: 210 40% 98%;
    --border: 214.3 31.8% 91.4%;
    --input: 214.3 31.8% 91.4%;
    --ring: 222.2 47.4% 11.2%;
    --radius: 0.5rem;
  }

  .dark {
    /* Dark theme colors */
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --card: 222.2 84% 4.9%;
    --card-foreground: 210 40% 98%;
    --popover: 222.2 84% 4.9%;
    --popover-foreground: 210 40% 98%;
    --primary: 210 40% 98%;
    --primary-foreground: 222.2 47.4% 11.2%;
    --secondary: 217.2 32.6% 17.5%;
    --secondary-foreground: 210 40% 98%;
    --muted: 217.2 32.6% 17.5%;
    --muted-foreground: 215 20.2% 65.1%;
    --accent: 217.2 32.6% 17.5%;
    --accent-foreground: 210 40% 98%;
    --destructive: 0 62.8% 30.6%;
    --destructive-foreground: 210 40% 98%;
    --border: 217.2 32.6% 17.5%;
    --input: 217.2 32.6% 17.5%;
    --ring: 212.7 26.8% 83.9%;
  }
}

@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply bg-background text-foreground;
  }
}
```

### **Tailwind Configuration (Design System)**
```typescript
// tailwind.config.ts
import type { Config } from 'tailwindcss'

const config: Config = {
  darkMode: ['class'],
  content: [
    './pages/**/*.{ts,tsx}',
    './components/**/*.{ts,tsx}',
    './app/**/*.{ts,tsx}',
    './src/**/*.{ts,tsx}',
  ],
  prefix: '',
  theme: {
    container: {
      center: true,
      padding: '2rem',
      screens: {
        '2xl': '1400px',
      },
    },
    extend: {
      colors: {
        border: 'hsl(var(--border))',
        input: 'hsl(var(--input))',
        ring: 'hsl(var(--ring))',
        background: 'hsl(var(--background))',
        foreground: 'hsl(var(--foreground))',
        primary: {
          DEFAULT: 'hsl(var(--primary))',
          foreground: 'hsl(var(--primary-foreground))',
        },
        secondary: {
          DEFAULT: 'hsl(var(--secondary))',
          foreground: 'hsl(var(--secondary-foreground))',
        },
        destructive: {
          DEFAULT: 'hsl(var(--destructive))',
          foreground: 'hsl(var(--destructive-foreground))',
        },
        muted: {
          DEFAULT: 'hsl(var(--muted))',
          foreground: 'hsl(var(--muted-foreground))',
        },
        accent: {
          DEFAULT: 'hsl(var(--accent))',
          foreground: 'hsl(var(--accent-foreground))',
        },
        popover: {
          DEFAULT: 'hsl(var(--popover))',
          foreground: 'hsl(var(--popover-foreground))',
        },
        card: {
          DEFAULT: 'hsl(var(--card))',
          foreground: 'hsl(var(--card-foreground))',
        },
      },
      borderRadius: {
        lg: 'var(--radius)',
        md: 'calc(var(--radius) - 2px)',
        sm: 'calc(var(--radius) - 4px)',
      },
      keyframes: {
        'accordion-down': {
          from: { height: '0' },
          to: { height: 'var(--radix-accordion-content-height)' },
        },
        'accordion-up': {
          from: { height: 'var(--radix-accordion-content-height)' },
          to: { height: '0' },
        },
      },
      animation: {
        'accordion-down': 'accordion-down 0.2s ease-out',
        'accordion-up': 'accordion-up 0.2s ease-out',
      },
    },
  },
  plugins: [require('tailwindcss-animate')],
}

export default config
```

### **Design System Rules (Strict Guidelines)**

#### **Color System Rules**
1. **"Use CSS variables for all colors"** - No hardcoded color values
2. **"Use semantic color names"** - primary, secondary, destructive, etc.
3. **"Support light and dark themes"** - CSS variables for both
4. **"Use HSL color format"** - Better for theme switching
5. **"No custom color classes"** - Use design tokens only

#### **Spacing System Rules**
1. **"Use Tailwind spacing scale"** - 4, 8, 12, 16, 24, 32, etc.
2. **"Use consistent spacing patterns"** - p-4, m-8, gap-6, etc.
3. **"Use responsive spacing"** - p-4 md:p-6 lg:p-8
4. **"No custom spacing values"** - Use Tailwind scale only

#### **Typography Rules**
1. **"Use Tailwind typography classes"** - text-lg, font-semibold, etc.
2. **"Use consistent font sizes"** - text-sm, text-base, text-lg, etc.
3. **"Use semantic heading classes"** - text-2xl, text-3xl, etc.
4. **"No custom font sizes"** - Use Tailwind scale only

#### **Component Rules**
1. **"Use shadcn/ui components by default"** - No custom components unless needed
2. **"Customize shadcn/ui with design tokens"** - Use CSS variables
3. **"Use Radix UI for complex components"** - When shadcn/ui isn't enough
4. **"No custom component styling"** - Use design system patterns

## Security & Authorization (Strict Patterns)

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
    if (!ctx.user) {
      throw new TRPCError({ code: 'UNAUTHORIZED' })
    }
    return next({ ctx: { ...ctx, user: ctx.user } })
  })

export const adminProcedure = protectedProcedure
  .use(({ ctx, next }) => {
    if (ctx.user.role !== 'admin') {
      throw new TRPCError({ code: 'FORBIDDEN' })
    }
    return next({ ctx })
  })
```

### **Data Access Patterns**
```typescript
// User can only access their own data
const getUserPosts = protectedProcedure
  .query(async ({ ctx }) => {
    return db.posts.findMany({
      where: { userId: ctx.user.id }
    })
  })

// Admin can access all data
const getAllUsers = adminProcedure
  .query(async () => {
    return db.users.findMany()
  })
```

### **Security Rules**
1. **"All user data access through protected procedures"** - No direct database access
2. **"Validate user permissions before data access"** - Check roles and ownership
3. **"Use Better Auth for all authentication"** - No custom auth logic
4. **"Sanitize all inputs with Zod"** - Validate and sanitize data
5. **"Never expose sensitive data"** - Filter responses appropriately

## Input Validation & Sanitization

### **Zod Schema Patterns**
```typescript
// lib/validations.ts - Input validation
export const userSchema = z.object({
  email: z.string().email().toLowerCase(),
  name: z.string().min(1).max(100).trim(),
  age: z.number().int().min(0).max(120)
})

export const postSchema = z.object({
  title: z.string().min(1).max(200).trim(),
  content: z.string().min(1).max(10000).trim(),
  published: z.boolean().default(false)
})

// tRPC procedure with validation
const createPost = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    // Input is already validated and sanitized
    return db.posts.create({
      data: {
        ...input,
        userId: ctx.user.id
      }
    })
  })
```

### **Validation Rules**
1. **"Validate all inputs with Zod"** - No unvalidated data
2. **"Sanitize strings with trim()"** - Remove whitespace
3. **"Use appropriate string methods"** - toLowerCase(), trim()
4. **"Set reasonable limits"** - Min/max lengths and values
5. **"Use specific types"** - email(), url(), uuid()

## Error Handling & Logging

### **Error Handling Patterns**
```typescript
// lib/trpc.ts - Error handling
export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  try {
    const session = await auth.api.getSession({
      headers: opts.req.headers
    })
    
    return {
      user: session?.user || null,
      req: opts.req,
      res: opts.res
    }
  } catch (error) {
    logger.error('Failed to create tRPC context', { error })
    throw new TRPCError({ code: 'INTERNAL_SERVER_ERROR' })
  }
}
```

### **Logging Patterns**
```typescript
// lib/logger.ts - Pino configuration
import pino from 'pino'

export const logger = pino({
  level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  transport: process.env.NODE_ENV === 'development' ? {
    target: 'pino-pretty'
  } : undefined
})

// Usage in tRPC procedures
const createPost = protectedProcedure
  .input(postSchema)
  .mutation(async ({ ctx, input }) => {
    try {
      logger.info('Creating post', { userId: ctx.user.id, title: input.title })
      
      const post = await db.posts.create({
        data: { ...input, userId: ctx.user.id }
      })
      
      logger.info('Post created successfully', { postId: post.id })
      return post
    } catch (error) {
      logger.error('Failed to create post', { error, userId: ctx.user.id })
      throw new TRPCError({ code: 'INTERNAL_SERVER_ERROR' })
    }
  })
```

## AI Guardrails for Code Standards

### **Code Quality Constraints**
1. **"Follow TypeScript strict mode"** - No any types, explicit returns
2. **"Use ESLint and Prettier"** - Consistent code formatting
3. **"No console.log in production"** - Use Pino for logging
4. **"Validate all inputs with Zod"** - No unvalidated data
5. **"Use protected procedures for user data"** - No direct database access

### **Security Constraints**
1. **"All user data through protected procedures"** - No direct database access
2. **"Validate user permissions before data access"** - Check roles and ownership
3. **"Use Better Auth for authentication"** - No custom auth logic
4. **"Sanitize all inputs"** - Use Zod validation and sanitization
5. **"Log all security events"** - Use Pino for security logging

### **Design System Constraints**
1. **"Use CSS variables for all colors"** - No hardcoded color values
2. **"Use Tailwind utility classes"** - No custom CSS unless needed
3. **"Use shadcn/ui components by default"** - No custom components unless needed
4. **"Use design tokens consistently"** - primary, secondary, destructive, etc.
5. **"Support light and dark themes"** - CSS variables for both

This gives you **complete code standards** that ensure consistent, secure, and maintainable code across all projects.
