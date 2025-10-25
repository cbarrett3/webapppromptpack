# Next.js Project Setup Template

## Quick Start Guide

### **1. Create New Project**
```bash
# Create new Next.js project with TypeScript and Tailwind
npx create-next-app@latest my-project --typescript --tailwind --app

# Navigate to project directory
cd my-project
```

### **2. Install Core Dependencies**
```bash
# Core framework dependencies
npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client @trpc/next zod better-auth pino

# Development dependencies
npm install -D @types/node eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom
```

### **3. Copy Framework Files**
```bash
# Copy Blueberry Prompt Kit framework files
cp -r blueberry-prompt-kit/.cursorrules ./my-project/
cp -r blueberry-prompt-kit/.cursor ./my-project/
cp -r blueberry-prompt-kit/docs ./my-project/
```

### **4. Configure Environment**
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

### **5. Start Development**
```bash
# Start development server
npm run dev

# Open in Cursor IDE
cursor .
```

---

## Project Structure Setup

### **Create Directory Structure**
```bash
# Create core directories
mkdir -p app/{api/trpc,\(auth\)}
mkdir -p components/{ui,forms,layout}
mkdir -p lib
mkdir -p types
mkdir -p hooks
mkdir -p server/{api,jobs}
mkdir -p public
```

### **Create Core Files**
```bash
# Create core configuration files
touch lib/{auth.ts,db.ts,trpc.ts,validations.ts,utils.ts}
touch types/index.ts
touch app/globals.css
touch app/layout.tsx
touch app/page.tsx
```

---

## Configuration Files

### **tsconfig.json**
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

### **.eslintrc.json**
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

### **.prettierrc**
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

### **tailwind.config.ts**
```typescript
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

---

## Core Setup Files

### **lib/db.ts**
```typescript
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import * as schema from './schema'

const connectionString = process.env.DATABASE_URL!

const client = postgres(connectionString)
export const db = drizzle(client, { schema })
```

### **lib/auth.ts**
```typescript
import { betterAuth } from 'better-auth'
import { drizzleAdapter } from 'better-auth/adapters/drizzle'
import { db } from './db'

export const auth = betterAuth({
  database: drizzleAdapter(db),
  emailAndPassword: {
    enabled: true,
    requireEmailVerification: true
  },
  socialProviders: {
    google: {
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!
    }
  }
})
```

### **lib/trpc.ts**
```typescript
import { initTRPC, TRPCError } from '@trpc/server'
import { createTRPCContext } from './trpc-context'
import { auth } from './auth'

const t = initTRPC.context<typeof createTRPCContext>().create()

export const router = t.router
export const publicProcedure = t.procedure

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

### **lib/validations.ts**
```typescript
import { z } from 'zod'

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
```

### **app/globals.css**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
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

---

## Package.json Scripts

### **package.json**
```json
{
  "name": "my-project",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest --coverage",
    "format": "prettier --write .",
    "format:check": "prettier --check ."
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0",
    "@supabase/supabase-js": "^2.0.0",
    "drizzle-orm": "^0.29.0",
    "@trpc/server": "^10.0.0",
    "@trpc/client": "^10.0.0",
    "@trpc/next": "^10.0.0",
    "zod": "^3.0.0",
    "better-auth": "^0.1.0",
    "pino": "^8.0.0"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0",
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

---

## Verification Checklist

### **Setup Verification**
- [ ] Project created successfully
- [ ] Dependencies installed
- [ ] Framework files copied
- [ ] Environment variables configured
- [ ] Development server starts
- [ ] Cursor IDE opens project

### **Configuration Verification**
- [ ] TypeScript strict mode enabled
- [ ] ESLint rules configured
- [ ] Prettier formatting working
- [ ] Tailwind CSS configured
- [ ] Design system variables set

### **Core Files Verification**
- [ ] Database connection working
- [ ] Authentication configured
- [ ] tRPC setup complete
- [ ] Validation schemas created
- [ ] Global styles applied

### **Development Environment**
- [ ] Hot reload working
- [ ] Type checking working
- [ ] Linting working
- [ ] Formatting working
- [ ] Testing framework ready

**Once all items are checked, your project is ready for development using the Blueberry Prompt Kit framework!**
