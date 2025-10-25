#!/bin/bash

# webapppromptpack - Modern Web App Framework
# "Impossible to Mess Up" - Strong opinions, proven patterns, strict constraints
# Building the future of web development with AI-first architecture

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Error handling
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# Check requirements
check_requirements() {
    echo -e "${BLUE}🔍 Validating development environment...${NC}"
    
    if ! command -v node &> /dev/null; then
        error_exit "Node.js is not installed. Please install Node.js 18+ from https://nodejs.org/"
    fi
    
    if ! command -v npm &> /dev/null; then
        error_exit "npm is not installed. Please install npm from https://nodejs.org/"
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        error_exit "Node.js 18+ is required. Current version: $(node -v). Please upgrade from https://nodejs.org/"
    fi
    
    echo -e "${GREEN}✅ Environment validated${NC}"
}

# Validate project name
validate_project_name() {
    if [[ ! "$1" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
        error_exit "Invalid project name: $1. Use only letters, numbers, hyphens, and underscores. Must start with a letter."
    fi
    
    # Check if directory already exists and is not empty
    if [ -d "$1" ] && [ "$(ls -A "$1" 2>/dev/null)" ]; then
        error_exit "Directory '$1' already exists and is not empty. Please choose a different name or remove the existing directory."
    fi
}

# Cleanup function for error recovery
cleanup() {
    if [ -n "${PROJECT_NAME:-}" ] && [ -d "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}Cleaning up failed setup...${NC}"
        rm -rf "$PROJECT_NAME"
    fi
}

# Set up error handling
trap cleanup EXIT

# Main execution
main() {
    if [ $# -eq 0 ]; then
        error_exit "Please provide a project name: bash setup-script.sh my-app"
    fi
    
    PROJECT_NAME="$1"
    validate_project_name "$PROJECT_NAME"
    
    echo -e "${PURPLE}🚀 webapppromptpack - Modern Web App Framework${NC}"
    echo -e "${PURPLE}===============================================${NC}"
    echo -e "${PURPLE}💡 'Impossible to Mess Up' - Strong opinions, proven patterns${NC}"
    echo -e "${PURPLE}🔧 Building the future of web development${NC}"
    
    check_requirements
    
    echo -e "${BLUE}📦 Initializing project: $PROJECT_NAME${NC}"
    
    # Create Next.js project
    echo -e "${BLUE}⚡ Creating Next.js 16 application...${NC}"
    
    if ! npx create-next-app@latest "$PROJECT_NAME" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --yes; then
        error_exit "Failed to create Next.js project. Please check your internet connection and try again."
    fi
    
    # Verify project was created
    sleep 1
    if [ ! -d "$PROJECT_NAME" ]; then
        error_exit "Project directory not found. The Next.js setup may have failed."
    fi
    
    # Change to project directory
    if ! cd "$PROJECT_NAME" 2>/dev/null; then
        error_exit "Cannot change to project directory: $PROJECT_NAME. Check permissions."
    fi
    echo -e "${GREEN}✅ Successfully changed to project directory${NC}"
    
    # Install webapppromptpack framework dependencies
    echo -e "${BLUE}📚 Installing core framework dependencies...${NC}"
    
    # Core UI and utilities
    if ! npm install clsx tailwind-merge class-variance-authority lucide-react tailwindcss-animate tailwindcss sonner; then
        error_exit "Failed to install UI dependencies. Please check your internet connection and try again."
    fi
    
    # Database and API stack
    echo -e "${BLUE}🗄️ Installing database and API dependencies...${NC}"
    if ! npm install @supabase/supabase-js drizzle-orm postgres @trpc/server @trpc/client @trpc/react-query @trpc/next @tanstack/react-query @tanstack/react-query-devtools zod better-auth @better-auth/client pino; then
        error_exit "Failed to install database and API dependencies. Please check your internet connection and try again."
    fi
    
    # External integrations
    echo -e "${BLUE}🔗 Installing external service dependencies...${NC}"
    if ! npm install resend stripe ai @ai-sdk/openai @ai-sdk/react trigger.dev; then
        error_exit "Failed to install external service dependencies. Please check your internet connection and try again."
    fi
    
    # Development dependencies
    echo -e "${BLUE}🛠️ Installing development dependencies...${NC}"
    if ! npm install -D prettier eslint-config-prettier vitest @testing-library/react @testing-library/jest-dom @vitejs/plugin-react autoprefixer @typescript-eslint/parser @typescript-eslint/eslint-plugin @tailwindcss/postcss drizzle-kit @vitest/coverage-v8 postcss pino-pretty @types/react @types/react-dom tsx husky lint-staged @commitlint/config-conventional @commitlint/cli; then
        error_exit "Failed to install dev dependencies. Please check your internet connection and try again."
    fi
    
    # Configure webapppromptpack development environment
    echo -e "${BLUE}⚙️ Configuring webapppromptpack framework...${NC}"
    
    # Next.js 16 configuration with webapppromptpack optimizations
    cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  // Next.js 16 typed routes for type-safe navigation
  typedRoutes: true,
  
  // Optimized image handling with modern formats
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
    formats: ['image/webp', 'image/avif'],
  },
  
  // Experimental features for performance
  experimental: {
    optimizePackageImports: ['lucide-react', '@trpc/client', '@trpc/server'],
  },
  
  // Server external packages
  serverExternalPackages: ['@types/node', 'drizzle-orm', 'better-auth'],
  
  // Compiler optimizations
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
  
  // Set output file tracing root to avoid workspace warnings
  outputFileTracingRoot: process.cwd(),
}

module.exports = nextConfig
EOF

    # PostCSS for Tailwind 4+
    cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    '@tailwindcss/postcss': {},
    autoprefixer: {},
  },
}
EOF

    # Strict TypeScript configuration for webapppromptpack
    cat > tsconfig.json << 'EOF'
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
EOF

    # Strict ESLint configuration for webapppromptpack
    cat > .eslintrc.json << 'EOF'
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
    "@typescript-eslint/explicit-function-return-type": "warn",
    "@typescript-eslint/no-non-null-assertion": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/no-unnecessary-condition": "error",
    "@typescript-eslint/no-floating-promises": "error",
    "@typescript-eslint/await-thenable": "error",
    "@typescript-eslint/no-misused-promises": "error",
    "@typescript-eslint/require-await": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/prefer-readonly": "error",
    "@typescript-eslint/prefer-function-type": "error",
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/consistent-type-exports": "error",
    "prefer-const": "error",
    "no-var": "error",
    "no-console": "warn",
    "no-debugger": "error",
    "no-duplicate-imports": "error",
    "no-unused-expressions": "error",
    "prefer-template": "error",
    "object-shorthand": "error",
    "prefer-arrow-callback": "error",
    "prefer-destructuring": "error",
    "no-nested-ternary": "error",
    "no-unneeded-ternary": "error",
    "react/jsx-boolean-value": "error",
    "react/jsx-curly-brace-presence": "error",
    "react/jsx-fragments": "error",
    "react/jsx-no-useless-fragment": "error",
    "react/jsx-prefer-fragment": "error",
    "react/no-array-index-key": "warn",
    "react/no-unused-prop-types": "error",
    "react/self-closing-comp": "error",
    "react-hooks/exhaustive-deps": "error",
    "react-hooks/rules-of-hooks": "error"
  },
  "ignorePatterns": ["node_modules/", ".next/", "out/", "dist/", "build/"]
}
EOF

    # Strict Prettier configuration for webapppromptpack
    cat > .prettierrc << 'EOF'
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2,
  "trailingComma": "es5",
  "printWidth": 80,
  "endOfLine": "lf"
}
EOF

    # Tailwind CSS 4+ configuration with design system
    cat > tailwind.config.ts << 'EOF'
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
EOF

    # Vitest configuration for webapppromptpack
    cat > vitest.config.ts << 'EOF'
import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    setupFiles: ['./test/setup.ts'],
    globals: true,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      exclude: [
        'node_modules/',
        'test/',
        '**/*.d.ts',
        '**/*.config.*',
        '**/coverage/**',
      ],
    },
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './'),
    },
  },
})
EOF

    # Create test setup file
    mkdir -p test
    cat > test/setup.ts << 'EOF'
import '@testing-library/jest-dom'
import { vi } from 'vitest'

// Mock Next.js router
vi.mock('next/navigation', () => ({
  useRouter: () => ({
    push: vi.fn(),
    replace: vi.fn(),
    prefetch: vi.fn(),
  }),
  useSearchParams: () => ({
    get: vi.fn(),
  }),
  usePathname: () => '/',
}))

// Mock tRPC
vi.mock('@/lib/trpc/client', () => ({
  api: {
    useQuery: vi.fn(),
    useMutation: vi.fn(),
  },
}))
EOF

    # Global CSS with design tokens
    cat > src/app/globals.css << 'EOF'
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
    border-color: hsl(var(--border));
  }
  body {
    background-color: hsl(var(--background));
    color: hsl(var(--foreground));
  }
}
EOF

    # Environment variables template
    cat > .env.example << 'EOF'
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/database_name"

# Better Auth
BETTER_AUTH_SECRET="your-secret-key-here"
BETTER_AUTH_URL="http://localhost:3000"
BETTER_AUTH_DATABASE_URL="postgresql://username:password@localhost:5432/database_name"
NEXT_PUBLIC_BETTER_AUTH_URL="http://localhost:3000"
NEXTAUTH_URL="http://localhost:3000"

# Google OAuth (optional)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"

# Supabase (optional)
NEXT_PUBLIC_SUPABASE_URL="your-supabase-url"
NEXT_PUBLIC_SUPABASE_ANON_KEY="your-supabase-anon-key"
SUPABASE_SERVICE_ROLE_KEY="your-supabase-service-role-key"

# External Services (optional)
RESEND_API_KEY="your-resend-api-key"
STRIPE_SECRET_KEY="your-stripe-secret-key"
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="your-stripe-publishable-key"
EOF

    # Create helpful .gitignore
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.pnp
.pnp.js

# Testing
coverage/

# Next.js
.next/
out/

# Production
build/
dist/

# Misc
.DS_Store
*.pem

# Debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Local env files
.env*.local
.env

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts

# Drizzle
drizzle/
EOF

    # Update package.json with helpful scripts
    npm pkg set scripts.lint="next lint" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.lint:fix="next lint --fix" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.format="prettier --write ." || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.format:check="prettier --check ." || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.test="vitest" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.test:ui="vitest --ui" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.test:coverage="vitest --coverage" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.quality="npm run lint && npm run format && npm run test" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.dev:clean="rm -rf .next && npm run dev" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:generate="drizzle-kit generate" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:migrate="drizzle-kit migrate" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:studio="drizzle-kit studio" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:push="drizzle-kit push" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:drop="drizzle-kit drop" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.db:run-migrations="tsx scripts/migrate.ts" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.type-check="tsc --noEmit" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.build:analyze="ANALYZE=true npm run build" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.prepare="husky install" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.add:supabase="npm install @supabase/supabase-js" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.add:external="npm install resend stripe ai @ai-sdk/openai @ai-sdk/react trigger.dev" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.add:devtools="npm install @tanstack/react-query-devtools" || error_exit "Failed to update package.json scripts"

    # Initialize Git repository
    echo -e "${BLUE}🔧 Initializing Git repository...${NC}"
    git init || error_exit "Failed to initialize Git repository"
    git add . || error_exit "Failed to stage initial files"
    git commit -m "feat: initial webapppromptpack setup" || error_exit "Failed to create initial commit"

    # Setup Git hooks with Husky
    echo -e "${BLUE}🔧 Setting up Git hooks...${NC}"
    npx husky init || error_exit "Failed to setup Husky"
    echo "npx lint-staged" > .husky/pre-commit || error_exit "Failed to create pre-commit hook"
    chmod +x .husky/pre-commit || error_exit "Failed to make pre-commit hook executable"
    echo "npx --no -- commitlint --edit \$1" > .husky/commit-msg || error_exit "Failed to create commit-msg hook"
    chmod +x .husky/commit-msg || error_exit "Failed to make commit-msg hook executable"

    # Create lint-staged configuration
    cat > .lintstagedrc.json << 'EOF'
{
  "*.{js,jsx,ts,tsx}": [
    "eslint --fix",
    "prettier --write"
  ],
  "*.{json,md,yml,yaml}": [
    "prettier --write"
  ]
}
EOF

    # Create commitlint configuration
    cat > commitlint.config.js << 'EOF'
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'ci',
        'chore',
        'revert'
      ]
    ]
  }
}
EOF

    # Create webapppromptpack project structure
    echo -e "${BLUE}📁 Creating webapppromptpack project structure...${NC}"
    mkdir -p components/ui || error_exit "Failed to create components directory"
    mkdir -p lib || error_exit "Failed to create lib directory"
    mkdir -p types || error_exit "Failed to create types directory"
    mkdir -p hooks || error_exit "Failed to create hooks directory"
    mkdir -p server/api || error_exit "Failed to create server directory"
    mkdir -p server/jobs || error_exit "Failed to create server/jobs directory"
    mkdir -p scripts || error_exit "Failed to create scripts directory"
    mkdir -p src/app/api/trpc || error_exit "Failed to create tRPC API directory"

    # Core utility functions
    cat > lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]): string {
  return twMerge(clsx(inputs))
}
EOF

    # Database configuration
    cat > lib/db.ts << 'EOF'
import { drizzle } from 'drizzle-orm/postgres-js'
import postgres from 'postgres'
import * as schema from './db/schema'

const connectionString = process.env.DATABASE_URL!

if (!connectionString) {
  throw new Error('DATABASE_URL environment variable is not set')
}

// Create connection with error handling
const client = postgres(connectionString, {
  max: 10,
  idle_timeout: 20,
  connect_timeout: 10,
})

export const db = drizzle(client, { schema })

// Test database connection
export async function testConnection() {
  try {
    await client`SELECT 1`
    // Connection successful - no logging needed in production
  } catch (error) {
    throw new Error('Database connection test failed')
  }
}
EOF

    # tRPC configuration
    cat > lib/trpc.ts << 'EOF'
import { initTRPC, TRPCError } from '@trpc/server'
import { type CreateNextContextOptions } from '@trpc/server/adapters/next'
import { auth } from './auth'

export const createTRPCContext = async (opts: CreateNextContextOptions) => {
  try {
    const session = await auth.api.getSession({
      headers: opts.req.headers
    })
    
    return {
      user: session?.user || null,
      session: session,
      req: opts.req,
      res: opts.res
    }
  } catch (error) {
    console.error('Failed to create tRPC context:', error)
    return {
      user: null,
      session: null,
      req: opts.req,
      res: opts.res
    }
  }
}

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
EOF

    # Create tRPC directory
    mkdir -p lib/trpc

    # tRPC client configuration
    cat > lib/trpc/client.ts << 'EOF'
import { createTRPCReact } from '@trpc/react-query'
import { type AppRouter } from './server'

export const api = createTRPCReact<AppRouter>()
EOF

    # tRPC provider setup
    cat > lib/trpc/provider.tsx << 'EOF'
'use client'

import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { httpBatchLink } from '@trpc/client'
import { useState } from 'react'
import { api } from './client'

export function TRPCProvider({ children }: { children: React.ReactNode }) {
  const [queryClient] = useState(() => new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 5 * 60 * 1000, // 5 minutes
        retry: 1,
      },
    },
  }))
  const [trpcClient] = useState(() =>
    api.createClient({
      links: [
        httpBatchLink({
          url: '/api/trpc',
        }),
      ],
    })
  )

  return (
    <api.Provider client={trpcClient} queryClient={queryClient}>
      <QueryClientProvider client={queryClient}>
        {children}
        {process.env.NODE_ENV === 'development' && <ReactQueryDevtools />}
      </QueryClientProvider>
    </api.Provider>
  )
}
EOF

    # tRPC server router
    cat > lib/trpc/server.ts << 'EOF'
import { router, publicProcedure, protectedProcedure } from '../trpc'
import { TRPCError } from '@trpc/server'
import { z } from 'zod'
import { eq } from 'drizzle-orm'
import { db } from '../db'
import { users, posts } from '../db/schema'

export const appRouter = router({
  // Public procedures
  health: publicProcedure.query(() => {
    return { status: 'ok', timestamp: new Date().toISOString() }
  }),

  // User procedures
  users: router({
    getCurrent: protectedProcedure.query(async ({ ctx }) => {
      try {
        const result = await db.select().from(users).where(eq(users.id, ctx.user.id)).limit(1)
        return result[0] || null
      } catch (error) {
        throw new TRPCError({
          code: 'INTERNAL_SERVER_ERROR',
          message: 'Failed to get current user'
        })
      }
    }),
  }),

  // Post procedures
  posts: router({
    getAll: publicProcedure.query(async () => {
      try {
        return await db.select().from(posts)
      } catch (error) {
        throw new TRPCError({
          code: 'INTERNAL_SERVER_ERROR',
          message: 'Failed to get posts'
        })
      }
    }),
    
    create: protectedProcedure
      .input(z.object({
        title: z.string().min(1).max(200),
        content: z.string().min(1).max(10000),
        published: z.boolean().default(false),
      }))
      .mutation(async ({ ctx, input }) => {
        try {
          const result = await db.insert(posts).values({
            ...input,
            userId: ctx.user.id,
          }).returning()
          return result[0]
        } catch (error) {
          throw new TRPCError({
            code: 'INTERNAL_SERVER_ERROR',
            message: 'Failed to create post'
          })
        }
      }),
  }),
})

export type AppRouter = typeof appRouter
EOF

    # Create tRPC API route directory
    mkdir -p src/app/api/trpc/[trpc]
    mkdir -p src/app/api/auth/[...all]

    # Better Auth API routes
    cat > src/app/api/auth/[...all]/route.ts << 'EOF'
import { auth } from '@/lib/auth'

export const { GET, POST } = auth.handler
EOF

    # tRPC API route handler
    cat > src/app/api/trpc/[trpc]/route.ts << 'EOF'
import { fetchRequestHandler } from '@trpc/server/adapters/fetch'
import { appRouter } from '@/lib/trpc/server'
import { createTRPCContext } from '@/lib/trpc'

const handler = (req: Request) =>
  fetchRequestHandler({
    endpoint: '/api/trpc',
    req,
    router: appRouter,
    createContext: createTRPCContext,
  })

export { handler as GET, handler as POST }
EOF

    # Better Auth configuration
    cat > lib/auth.ts << 'EOF'
import { betterAuth } from 'better-auth'
import { drizzleAdapter } from 'better-auth/adapters/drizzle'
import { db } from './db'

export const auth = betterAuth({
  database: drizzleAdapter(db),
  emailAndPassword: { enabled: true },
  socialProviders: {
    google: {
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    },
  },
  secret: process.env.BETTER_AUTH_SECRET!,
  baseURL: process.env.BETTER_AUTH_URL!,
})
EOF

    # Environment validation
    cat > lib/env.ts << 'EOF'
import { z } from 'zod'

const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  BETTER_AUTH_SECRET: z.string().min(32),
  BETTER_AUTH_URL: z.string().url(),
  NEXT_PUBLIC_BETTER_AUTH_URL: z.string().url(),
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
})

export const env = envSchema.parse(process.env)
EOF

    # Logger configuration
    cat > lib/logger.ts << 'EOF'
import pino from 'pino'

export const logger = pino({
  level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  transport: process.env.NODE_ENV === 'development' ? {
    target: 'pino-pretty',
    options: {
      colorize: true,
      translateTime: 'SYS:standard',
      ignore: 'pid,hostname'
    }
  } : undefined
})
EOF

    # Create database migration script
    cat > scripts/migrate.ts << 'EOF'
import { migrate } from 'drizzle-orm/postgres-js/migrator'
import { db, testConnection } from '../lib/db'

async function runMigrations() {
  try {
    await testConnection()
    await migrate(db, { migrationsFolder: './drizzle' })
  } catch (error) {
    console.error('Migration failed:', error)
    process.exit(1)
  }
}

runMigrations()
EOF

    # Better Auth client configuration
    cat > lib/auth-client.ts << 'EOF'
import { createAuthClient } from '@better-auth/client'

export const authClient = createAuthClient({
  baseURL: process.env.NEXT_PUBLIC_BETTER_AUTH_URL || 'http://localhost:3000',
})
EOF

    # Zod validation schemas
    cat > lib/validations.ts << 'EOF'
import { z } from 'zod'

export const userSchema = z.object({
  email: z.string().email().toLowerCase(),
  name: z.string().min(1).max(100).trim(),
})

export const postSchema = z.object({
  title: z.string().min(1).max(200).trim(),
  content: z.string().min(1).max(10000).trim(),
  published: z.boolean().default(false),
})
EOF

    # Drizzle configuration
    cat > drizzle.config.ts << 'EOF'
import { defineConfig } from 'drizzle-kit'

export default defineConfig({
  schema: './lib/db/schema.ts',
  out: './drizzle',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
})
EOF

    # Database schema
    mkdir -p lib/db
    cat > lib/db/schema.ts << 'EOF'
import { pgTable, text, timestamp, uuid, boolean } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').notNull().unique(),
  name: text('name').notNull(),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow(),
})

export const posts = pgTable('posts', {
  id: uuid('id').primaryKey().defaultRandom(),
  title: text('title').notNull(),
  content: text('content').notNull(),
  published: boolean('published').default(false),
  userId: uuid('user_id').references(() => users.id),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow(),
})
EOF

    # Root layout with providers
    cat > src/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'
import { TRPCProvider } from '@/lib/trpc/provider'
import { Toaster } from 'sonner'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'webapppromptpack App',
  description: 'Built with webapppromptpack framework',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <TRPCProvider>
          {children}
          <Toaster />
        </TRPCProvider>
      </body>
    </html>
  )
}
EOF

    # Advanced Button component with modern patterns
    cat > components/ui/button.tsx << 'EOF'
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline: "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
        secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
        ghost: "hover:bg-accent hover:text-accent-foreground",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 rounded-md px-3",
        lg: "h-11 rounded-md px-8",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <button
        className={cn(buttonVariants({ variant, size, className }))}
        ref={ref}
        {...props}
      />
    )
  }
)
Button.displayName = "Button"

export { Button, buttonVariants }
EOF

    # Card component
    cat > components/ui/card.tsx << 'EOF'
import * as React from "react"
import { cn } from "@/lib/utils"

const Card = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn(
      "rounded-lg border bg-card text-card-foreground shadow-sm",
      className
    )}
    {...props}
  />
))
Card.displayName = "Card"

const CardHeader = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex flex-col space-y-1.5 p-6", className)}
    {...props}
  />
))
CardHeader.displayName = "CardHeader"

const CardTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, ...props }, ref) => (
  <h3
    ref={ref}
    className={cn(
      "text-2xl font-semibold leading-none tracking-tight",
      className
    )}
    {...props}
  />
))
CardTitle.displayName = "CardTitle"

const CardDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => (
  <p
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
CardDescription.displayName = "CardDescription"

const CardContent = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div ref={ref} className={cn("p-6 pt-0", className)} {...props} />
))
CardContent.displayName = "CardContent"

const CardFooter = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex items-center p-6 pt-0", className)}
    {...props}
  />
))
CardFooter.displayName = "CardFooter"

export { Card, CardHeader, CardFooter, CardTitle, CardDescription, CardContent }
EOF

    # Better Auth React hook
    cat > hooks/use-auth.ts << 'EOF'
'use client'

import { useEffect, useState } from 'react'
import { authClient } from '@/lib/auth-client'

export function useAuth() {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const checkAuth = async () => {
      try {
        const session = await authClient.getSession()
        setUser(session?.user || null)
      } catch (error) {
        console.error('Auth check failed:', error)
        setUser(null)
      } finally {
        setLoading(false)
      }
    }

    checkAuth()
  }, [])

  const signIn = async (email: string, password: string) => {
    try {
      const result = await authClient.signIn.email({
        email,
        password,
      })
      if (result.data) {
        setUser(result.data.user)
      }
      return result
    } catch (error) {
      console.error('Sign in failed:', error)
      throw error
    }
  }

  const signUp = async (email: string, password: string, name: string) => {
    try {
      const result = await authClient.signUp.email({
        email,
        password,
        name,
      })
      if (result.data) {
        setUser(result.data.user)
      }
      return result
    } catch (error) {
      console.error('Sign up failed:', error)
      throw error
    }
  }

  const signOut = async () => {
    try {
      await authClient.signOut()
      setUser(null)
    } catch (error) {
      console.error('Sign out failed:', error)
      throw error
    }
  }

  return {
    user,
    loading,
    signIn,
    signUp,
    signOut,
  }
}
EOF

    # TypeScript types
    cat > types/index.ts << 'EOF'
export interface User {
  id: string
  email: string
  name: string
  createdAt: Date
  updatedAt: Date
}

export interface Post {
  id: string
  title: string
  content: string
  published: boolean
  userId: string
  createdAt: Date
  updatedAt: Date
}

export interface ApiResponse<T> {
  data: T
  success: boolean
  message?: string
}
EOF

    # Error boundary component
    cat > components/error-boundary.tsx << 'EOF'
'use client'

import { useEffect } from 'react'

interface ErrorBoundaryProps {
  children: React.ReactNode
  fallback?: React.ComponentType<{ error: Error; reset: () => void }>
}

interface ErrorBoundaryState {
  hasError: boolean
  error?: Error
}

export function ErrorBoundary({ children, fallback: Fallback }: ErrorBoundaryProps) {
  useEffect(() => {
    const handleError = (error: ErrorEvent) => {
      // Error handling - use proper logging in production
    }

    window.addEventListener('error', handleError)
    return () => window.removeEventListener('error', handleError)
  }, [])

  if (Fallback) {
    return <Fallback error={new Error('Unknown error')} reset={() => window.location.reload()} />
  }

  return <>{children}</>
}
EOF

    # Home page with tRPC example
    cat > src/app/page.tsx << 'EOF'
'use client'

import { api } from '@/lib/trpc/client'
import { Button } from '@/components/ui/button'

export default function Home() {
  const { data: health, isLoading } = api.health.useQuery()

  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm">
        <h1 className="text-4xl font-bold text-center mb-8">
          webapppromptpack Framework
        </h1>
        <div className="text-center">
          <p className="mb-4">Your app is ready to go!</p>
          {isLoading ? (
            <p>Loading...</p>
          ) : (
            <p>Status: {health?.status}</p>
          )}
          <Button className="mt-4">
            Get Started
          </Button>
        </div>
      </div>
    </main>
  )
}
EOF

    # Comprehensive .cursorrules for webapppromptpack
    cat > .cursorrules << 'EOF'
# webapppromptpack - Cursor Rules

## Core Framework
You are working with the webapppromptpack framework - a data-first, back-to-front development methodology with strict technology constraints and quality standards.

## Technology Stack (Non-Negotiable)
- **Frontend**: Next.js 16 (App Router) + TypeScript + Tailwind CSS 4+ + shadcn/ui
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
- **TypeScript strict mode**: No `any` types, explicit returns
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
```
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
```

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
EOF

    # Verify webapppromptpack setup
    echo -e "${BLUE}🔍 Verifying webapppromptpack framework installation...${NC}"
    if [ ! -f "package.json" ]; then
        error_exit "Setup verification failed: package.json not found"
    fi
    if [ ! -f "next.config.js" ]; then
        error_exit "Setup verification failed: next.config.js not found"
    fi
    if [ ! -f ".cursorrules" ]; then
        error_exit "Setup verification failed: .cursorrules not found"
    fi
    if [ ! -f "lib/db.ts" ]; then
        error_exit "Setup verification failed: lib/db.ts not found"
    fi
    if [ ! -f "lib/trpc.ts" ]; then
        error_exit "Setup verification failed: lib/trpc.ts not found"
    fi
    if [ ! -f "drizzle.config.ts" ]; then
        error_exit "Setup verification failed: drizzle.config.ts not found"
    fi
    if [ ! -f ".env.example" ]; then
        error_exit "Setup verification failed: .env.example not found"
    fi
    if [ ! -f "src/app/api/trpc/[trpc]/route.ts" ]; then
        error_exit "Setup verification failed: tRPC API route not found"
    fi
    if [ ! -f "src/app/api/auth/[...all]/route.ts" ]; then
        error_exit "Setup verification failed: Better Auth API route not found"
    fi
    if [ ! -f "src/app/layout.tsx" ]; then
        error_exit "Setup verification failed: src/app/layout.tsx not found"
    fi
    if [ ! -f "src/app/page.tsx" ]; then
        error_exit "Setup verification failed: src/app/page.tsx not found"
    fi
    if [ ! -f "types/index.ts" ]; then
        error_exit "Setup verification failed: types/index.ts not found"
    fi
    if [ ! -f "lib/trpc/provider.tsx" ]; then
        error_exit "Setup verification failed: lib/trpc/provider.tsx not found"
    fi
    if [ ! -f "lib/auth-client.ts" ]; then
        error_exit "Setup verification failed: lib/auth-client.ts not found"
    fi
    if [ ! -f "lib/logger.ts" ]; then
        error_exit "Setup verification failed: lib/logger.ts not found"
    fi
    if [ ! -f "hooks/use-auth.ts" ]; then
        error_exit "Setup verification failed: hooks/use-auth.ts not found"
    fi
    if [ ! -f "components/error-boundary.tsx" ]; then
        error_exit "Setup verification failed: components/error-boundary.tsx not found"
    fi
    if [ ! -f "lib/env.ts" ]; then
        error_exit "Setup verification failed: lib/env.ts not found"
    fi
    if [ ! -f "scripts/migrate.ts" ]; then
        error_exit "Setup verification failed: scripts/migrate.ts not found"
    fi
    if [ ! -f ".lintstagedrc.json" ]; then
        error_exit "Setup verification failed: .lintstagedrc.json not found"
    fi
    if [ ! -f "commitlint.config.js" ]; then
        error_exit "Setup verification failed: commitlint.config.js not found"
    fi
    if [ ! -f "components/ui/card.tsx" ]; then
        error_exit "Setup verification failed: components/ui/card.tsx not found"
    fi
    if [ ! -d ".husky" ]; then
        error_exit "Setup verification failed: .husky directory not found"
    fi
    
    # Success message
    echo ""
    echo -e "${GREEN}🎉 webapppromptpack framework installation complete!${NC}"
    echo ""
    echo -e "${GREEN}✅ Project initialized: $PROJECT_NAME${NC}"
    echo -e "${GREEN}✅ All dependencies installed${NC}"
    echo -e "${GREEN}✅ Development environment configured${NC}"
    echo -e "${GREEN}✅ AI-first architecture enabled${NC}"
    echo -e "${GREEN}✅ 'Impossible to Mess Up' framework ready${NC}"
    echo ""
    echo -e "${PURPLE}🚀 Development workflow:${NC}"
    echo -e "   cd $PROJECT_NAME"
    echo -e "   npm run dev"
    echo ""
    echo -e "${BLUE}📋 Available commands:${NC}"
    echo -e "   npm run dev          - Start development server"
    echo -e "   npm run build        - Build for production"
    echo -e "   npm run quality      - Run comprehensive quality checks"
    echo -e "   npm run lint         - Run strict ESLint analysis"
    echo -e "   npm run test         - Run Vitest test suite"
    echo -e "   npm run format        - Format code with Prettier"
    echo ""
    echo -e "${BLUE}🔧 Framework features enabled:${NC}"
    echo -e "   Next.js 16 with App Router and Server Components"
    echo -e "   Tailwind CSS 4+ with design system and CSS variables"
    echo -e "   Strict TypeScript with production-grade rules"
    echo -e "   Advanced ESLint with comprehensive error checking"
    echo -e "   Vitest testing with React Testing Library"
    echo -e "   shadcn/ui component system with CVA patterns"
    echo -e "   Supabase + Drizzle ORM for database"
    echo -e "   tRPC for end-to-end type safety"
    echo -e "   Better Auth for authentication"
    echo -e "   Zod for input validation"
    echo -e "   Pino for structured logging"
    echo -e "   AI-first development with comprehensive .cursorrules"
    echo ""
    echo -e "${PURPLE}💡 Next steps:${NC}"
    echo -e "   1. Set up your Supabase project and add DATABASE_URL"
    echo -e "   2. Configure environment variables"
    echo -e "   3. Run database migrations with Drizzle"
    echo -e "   4. Start building with the webapppromptpack methodology"
    echo ""
    echo -e "${YELLOW}📚 Documentation: Check the .cursorrules file for complete guidance${NC}"
    echo ""
}

# Run main function
main "$@"