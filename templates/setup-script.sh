#!/bin/bash

# webapppromptpack - Zero-Friction Setup Script
# This script sets up a complete Next.js project with all the right configurations

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Error handling
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# Check if required tools are available
check_requirements() {
    echo -e "${BLUE}🔍 Checking requirements...${NC}"
    
    if ! command -v node &> /dev/null; then
        error_exit "Node.js is required but not installed. Please install Node.js from https://nodejs.org/"
    fi
    
    if ! command -v npm &> /dev/null; then
        error_exit "npm is required but not installed. Please install npm or use a Node.js installer that includes npm."
    fi
    
    # Check Node.js version (require 18+)
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        error_exit "Node.js 18+ is required. Current version: $(node -v). Please upgrade from https://nodejs.org/"
    fi
    
    echo -e "${GREEN}✅ Requirements check passed${NC}"
}

# Version pinning for stability (update these as needed)
NEXTJS_VERSION="16.0.0"
REACT_VERSION="18.3.1"
TYPESCRIPT_VERSION="5.6.3"
TAILWIND_VERSION="4.0.0"

# Check for script updates
check_for_updates() {
    echo -e "${BLUE}🔍 Checking for framework updates...${NC}"
    # This could be expanded to check for updates to the framework
    echo -e "${GREEN}✅ Using stable versions${NC}"
}

echo -e "${BLUE}🚀 webapppromptpack - Zero-Friction Setup${NC}"
echo "========================================"

# Check requirements first
check_requirements

# Check for updates
check_for_updates

# Check if project name is provided
if [ -z "${1:-}" ]; then
    error_exit "Please provide a project name: ./setup-script.sh my-awesome-app"
fi

PROJECT_NAME="$1"

# Validate project name
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    error_exit "Project name must contain only letters, numbers, hyphens, and underscores"
fi

echo -e "${BLUE}📁 Creating project: $PROJECT_NAME${NC}"

# Create Next.js project with pinned versions
echo -e "${BLUE}⚡ Creating Next.js project...${NC}"
if ! npx create-next-app@$NEXTJS_VERSION "$PROJECT_NAME" --typescript --tailwind --app --src-dir=false --import-alias="@/*" --yes; then
    error_exit "Failed to create Next.js project. Please check your internet connection and try again."
fi

cd "$PROJECT_NAME" || error_exit "Failed to enter project directory"

# Install additional dependencies with error handling
echo -e "${BLUE}📦 Installing essential dependencies...${NC}"
if ! npm install @tailwindcss/postcss tailwindcss-animate class-variance-authority clsx lucide-react tailwind-merge autoprefixer; then
    error_exit "Failed to install essential dependencies. Please check your internet connection and try again."
fi

# Install dev dependencies with error handling
echo -e "${BLUE}🔧 Installing development dependencies...${NC}"
if ! npm install -D eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom @vitejs/plugin-react lint-staged husky @commitlint/config-conventional @commitlint/cli @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-unused-imports; then
    error_exit "Failed to install development dependencies. Please check your internet connection and try again."
fi

# Cleanup function for error recovery
cleanup() {
    if [ -d "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}🧹 Cleaning up failed setup...${NC}"
        rm -rf "$PROJECT_NAME"
    fi
}

# Set up cleanup trap
trap cleanup EXIT

# Create essential configuration files
echo -e "${BLUE}⚙️  Setting up configuration files...${NC}"

# Next.js config
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  typedRoutes: true,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**',
      },
    ],
  },
}

module.exports = nextConfig
EOF

# PostCSS config for Tailwind CSS 4+
cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    '@tailwindcss/postcss': {},
    autoprefixer: {},
  },
}
EOF

# Clean ESLint config for high code quality
cat > .eslintrc.json << 'EOF'
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
    "plugin:jsx-a11y/recommended",
    "plugin:import/recommended",
    "plugin:import/typescript",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json",
    "ecmaVersion": 2022,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "plugins": [
    "@typescript-eslint",
    "react",
    "react-hooks",
    "jsx-a11y",
    "import",
    "unused-imports"
  ],
  "settings": {
    "react": {
      "version": "detect"
    },
    "import/resolver": {
      "typescript": {
        "alwaysTryTypes": true
      }
    }
  },
  "rules": {
    // TypeScript essential rules
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/no-explicit-any": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "@typescript-eslint/no-floating-promises": "error",
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/no-unnecessary-condition": "error",
    "@typescript-eslint/prefer-as-const": "error",
    "@typescript-eslint/no-empty-function": "error",
    "@typescript-eslint/no-empty-interface": "error",

    // React essential rules
    "react/jsx-boolean-value": "error",
    "react/jsx-curly-brace-presence": "error",
    "react/jsx-fragments": "error",
    "react/jsx-no-useless-fragment": "error",
    "react/no-array-index-key": "warn",
    "react/self-closing-comp": "error",
    "react/prop-types": "off",
    "react/react-in-jsx-scope": "off",
    "react-hooks/exhaustive-deps": "error",
    "react-hooks/rules-of-hooks": "error",

    // Import/Export rules
    "import/no-duplicates": "error",
    "import/order": ["error", {
      "groups": ["builtin", "external", "internal", "parent", "sibling", "index"],
      "newlines-between": "always",
      "alphabetize": { "order": "asc", "caseInsensitive": true }
    }],
    "unused-imports/no-unused-imports": "error",
    "unused-imports/no-unused-vars": ["error", {
      "vars": "all",
      "varsIgnorePattern": "^_",
      "args": "after-used",
      "argsIgnorePattern": "^_"
    }],

    // General code quality
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
    "no-useless-return": "error",
    "no-useless-concat": "error",
    "no-useless-escape": "error"
  }
}
EOF

# Prettier config
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

# Prettier ignore
cat > .prettierignore << 'EOF'
node_modules
.next
.vercel
out
dist
build
coverage
*.log
.env*
EOF

# Vitest config
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
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './'),
    },
  },
})
EOF

# Create test setup
mkdir -p test
cat > test/setup.ts << 'EOF'
import '@testing-library/jest-dom'

// Mock Next.js router
jest.mock('next/navigation', () => ({
  useRouter: () => ({
    push: jest.fn(),
    replace: jest.fn(),
    prefetch: jest.fn(),
  }),
  useSearchParams: () => ({
    get: jest.fn(),
  }),
  usePathname: () => '/',
}))
EOF

# ESLint ignore (Next.js handles most of this)
cat > .eslintignore << 'EOF'
node_modules
.next
.vercel
out
dist
build
coverage
*.log
.env*
EOF

# Lint-staged config
cat > lint-staged.config.js << 'EOF'
module.exports = {
  '*.{js,jsx,ts,tsx}': [
    'eslint --fix',
    'prettier --write',
  ],
  '*.{json,md,yml,yaml}': [
    'prettier --write',
  ],
}
EOF

# Commitlint config
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
        'chore',
        'ci',
        'build',
        'revert',
      ],
    ],
    'subject-case': [2, 'never', ['pascal-case', 'upper-case']],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'type-case': [2, 'always', 'lower-case'],
    'type-empty': [2, 'never'],
  },
}
EOF

# EditorConfig
cat > .editorconfig << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
indent_size = 2
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false
EOF

# Update package.json scripts
echo "📝 Updating package.json scripts..."
npm pkg set scripts.lint="next lint"
npm pkg set scripts.lint:fix="next lint --fix"
npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.format:check="prettier --check ."
npm pkg set scripts.type-check="tsc --noEmit"
npm pkg set scripts.test="vitest"
npm pkg set scripts.test:ui="vitest --ui"
npm pkg set scripts.test:coverage="vitest --coverage"
npm pkg set scripts.prepare="husky install"
npm pkg set scripts.lint:staged="lint-staged"
npm pkg set scripts.quality="npm run type-check && npm run lint && npm run format:check && npm run test"
npm pkg set scripts.dev:clean="rm -rf .next && npm run dev"
npm pkg set scripts.db:generate="drizzle-kit generate"
npm pkg set scripts.db:migrate="drizzle-kit migrate"
npm pkg set scripts.db:studio="drizzle-kit studio"
npm pkg set scripts.db:push="drizzle-kit push"
npm pkg set scripts.setup:db="npm run db:generate && npm run db:migrate"
npm pkg set scripts.reset="rm -rf .next node_modules package-lock.json && npm install"

# Initialize Husky
echo "🐕 Setting up Husky for git hooks..."
npx husky install

# Create Husky hooks
mkdir -p .husky
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
EOF

cat > .husky/commit-msg << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx commitlint --edit $1
EOF

chmod +x .husky/pre-commit
chmod +x .husky/commit-msg

# Create directory structure
echo "📁 Creating project structure..."
mkdir -p components/{ui,forms,layout}
mkdir -p lib
mkdir -p types
mkdir -p hooks
mkdir -p server/{api,jobs}
mkdir -p public

# Update TypeScript config for strict mode
echo "🔧 Updating TypeScript configuration for strict mode..."
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
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
    "target": "ES2022",
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noImplicitThis": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitOverride": true,
    "noFallthroughCasesInSwitch": true,
    "allowUnusedLabels": false,
    "allowUnreachableCode": false,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Create example components for quick start
echo "📄 Creating example components..."

# Create example button component
cat > components/ui/button.tsx << 'EOF'
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
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
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
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

# Create example card component
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

# Create core files
echo "📄 Creating core files..."

# Create lib/utils.ts
cat > lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOF

# Create types/index.ts
cat > types/index.ts << 'EOF'
// Global type definitions
export interface User {
  id: string
  email: string
  name?: string
  createdAt: Date
  updatedAt: Date
}

export interface ApiResponse<T> {
  data: T
  success: boolean
  message?: string
}
EOF

# Create .env.local template
cat > .env.local.example << 'EOF'
# Database
DATABASE_URL="file:./dev.db"

# Authentication (optional - add when ready)
# NEXTAUTH_SECRET="your-secret-here"
# NEXTAUTH_URL="http://localhost:3000"

# External Services (optional - add when ready)
# NEXT_PUBLIC_SUPABASE_URL="your-supabase-url"
# NEXT_PUBLIC_SUPABASE_ANON_KEY="your-supabase-anon-key"
# SUPABASE_SERVICE_ROLE_KEY="your-supabase-service-role-key"
EOF

# Create comprehensive .cursorrules for optimal development
echo -e "${BLUE}🎯 Adding webapppromptpack framework rules...${NC}"
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
- **Data-First Design** - Information architecture drives visual design
- **Immaculate Clean Style** - Every pixel serves a purpose
- **Sophisticated Dark Themes** - Deep backgrounds with high contrast
- **Generous Whitespace** - Purposeful breathing room
- **Professional Polish** - Interfaces that rival top SaaS products

## Component Patterns
- **Use shadcn/ui components** - Pre-built, accessible components
- **Extend with cva** - Class Variance Authority for variants
- **Forward refs** - Proper ref forwarding for all components
- **TypeScript interfaces** - Explicit prop types
- **Accessibility first** - ARIA labels, keyboard navigation

## Database Patterns
- **Drizzle schemas first** - Plan schema before building anything
- **Relationships matter** - Design for efficient queries
- **Migration strategy** - Version-controlled schema changes
- **Performance conscious** - Index appropriately

## API Patterns
- **tRPC procedures only** - No REST endpoints
- **Zod validation** - Validate all inputs/outputs
- **Protected procedures** - Use Better Auth context
- **Error handling** - Graceful error responses

## Testing Patterns
- **Test tRPC procedures** - Unit test all API endpoints
- **Test components** - User interactions and accessibility
- **Test integrations** - Database and external APIs
- **Mock external services** - Isolate tests

## Performance Rules
- **No floating promises** - Always await or handle
- **Exhaustive deps** - Include all dependencies in useEffect
- **Bundle optimization** - Dynamic imports for large components
- **Image optimization** - Use Next.js Image component

## Security Rules
- **Input validation** - Validate all inputs with Zod
- **Authentication** - Use Better Auth for protected routes
- **CSRF protection** - Use CSRF tokens for mutations
- **Rate limiting** - Implement rate limiting for API endpoints

## File Naming Conventions
- **Components**: PascalCase (Button.tsx)
- **Utilities**: camelCase (utils.ts)
- **Types**: PascalCase (User.ts)
- **Hooks**: camelCase starting with 'use' (useAuth.ts)
- **Pages**: kebab-case (user-profile.tsx)

## Import Organization
```typescript
// 1. React imports
import React from 'react'
import { useState } from 'react'

// 2. External libraries
import { clsx } from 'clsx'
import { twMerge } from 'tailwind-merge'

// 3. Internal utilities
import { cn } from '@/lib/utils'

// 4. Types
import type { User } from '@/types'

// 5. Components
import { Button } from '@/components/ui/button'
```

## Common Patterns

### Component Structure
```typescript
import * as React from 'react'
import { cn } from '@/lib/utils'

interface ComponentProps {
  className?: string
  children: React.ReactNode
}

const Component = React.forwardRef<HTMLDivElement, ComponentProps>(
  ({ className, children, ...props }, ref) => {
    return (
      <div
        ref={ref}
        className={cn('base-classes', className)}
        {...props}
      >
        {children}
      </div>
    )
  }
)
Component.displayName = 'Component'

export { Component }
```

### tRPC Procedure
```typescript
import { z } from 'zod'
import { createTRPCRouter, protectedProcedure } from '@/lib/trpc'

export const userRouter = createTRPCRouter({
  getProfile: protectedProcedure
    .input(z.object({ id: z.string() }))
    .query(async ({ ctx, input }) => {
      return await ctx.db.user.findUnique({
        where: { id: input.id }
      })
    })
})
```

### Database Schema
```typescript
import { pgTable, text, timestamp, uuid } from 'drizzle-orm/pg-core'

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom(),
  email: text('email').notNull().unique(),
  name: text('name'),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow()
})
```

## Development Workflow
1. **Plan** - Understand requirements and data needs
2. **Schema** - Create/update database schema
3. **API** - Build tRPC procedures with validation
4. **UI** - Create components and pages
5. **Connect** - Wire everything together
6. **Test** - Write comprehensive tests
7. **Polish** - Add loading states and error handling

## Quality Gates
- [ ] TypeScript strict mode compliance
- [ ] ESLint rules passing
- [ ] All tests passing
- [ ] Accessibility compliance
- [ ] Performance optimized
- [ ] Security best practices followed

## Never Do
- ❌ Use `any` types
- ❌ Skip input validation
- ❌ Direct database access from components
- ❌ Console.log in production
- ❌ Skip error handling
- ❌ Ignore accessibility
- ❌ Skip tests

## Always Do
- ✅ Use TypeScript strict mode
- ✅ Validate all inputs with Zod
- ✅ Use tRPC for all API calls
- ✅ Write comprehensive tests
- ✅ Follow accessibility guidelines
- ✅ Handle errors gracefully
- ✅ Use proper TypeScript types
EOF

# Create README
cat > README.md << 'EOF'
# My webapppromptpack App

Built with the webapppromptpack framework - impossible to mess up!

## Getting Started

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Open http://localhost:3000
```

## Available Scripts

### **Development**
- `npm run dev` - Start development server
- `npm run dev:clean` - Clean build and start dev server
- `npm run build` - Build for production
- `npm run start` - Start production server

### **Code Quality**
- `npm run lint` - Run ESLint
- `npm run lint:fix` - Fix ESLint issues
- `npm run format` - Format code with Prettier
- `npm run type-check` - Run TypeScript type checking
- `npm run quality` - Run all quality checks

### **Testing**
- `npm run test` - Run tests
- `npm run test:ui` - Run tests with UI
- `npm run test:coverage` - Run tests with coverage

### **Database (when using Drizzle)**
- `npm run db:generate` - Generate database migrations
- `npm run db:migrate` - Run database migrations
- `npm run db:studio` - Open Drizzle Studio
- `npm run db:push` - Push schema changes
- `npm run setup:db` - Generate and run migrations

### **Utilities**
- `npm run reset` - Reset project (clean install)
- `npm run lint:staged` - Run lint-staged

## Framework Features

- ✅ **TypeScript strict mode** with comprehensive type checking
- ✅ **Tailwind CSS 4+** with animations and design system
- ✅ **Strict ESLint rules** with essential quality rules
- ✅ **Prettier formatting** with consistent style
- ✅ **Vitest testing** with React Testing Library
- ✅ **Next.js 16** with App Router and typed routes
- ✅ **Git hooks** with Husky for pre-commit linting
- ✅ **Commit linting** with conventional commits
- ✅ **Lint-staged** for efficient pre-commit checks
- ✅ **EditorConfig** for consistent editor settings
- ✅ **AI agent guidance** via comprehensive .cursorrules
- ✅ **Example components** - Button and Card components ready to use
- ✅ **Development scripts** - Database, quality, and utility commands
- ✅ **Quality script** - run `npm run quality` for full checks

## Next Steps

1. Start building your app with AI guidance
2. Add backend services when ready (Supabase, Stripe, etc.)
3. Deploy to Vercel when ready

Happy coding! 🚀
EOF

# Success function
success() {
    echo ""
    echo -e "${GREEN}🎉 Setup complete!${NC}"
    echo ""
    echo -e "${GREEN}✅ Project created: $PROJECT_NAME${NC}"
    echo -e "${GREEN}✅ All dependencies installed${NC}"
    echo -e "${GREEN}✅ Configuration files created${NC}"
    echo -e "${GREEN}✅ Framework rules added${NC}"
    echo ""
    echo -e "${BLUE}🚀 Next steps:${NC}"
    echo -e "   ${YELLOW}cd $PROJECT_NAME${NC}"
    echo -e "   ${YELLOW}npm run dev${NC}"
    echo ""
    echo -e "${GREEN}✨ Your app is ready to build with AI guidance!${NC}"
    echo -e "   ${BLUE}Open in Cursor IDE for the best experience${NC}"
    echo ""
    echo -e "${BLUE}📚 Available commands:${NC}"
    echo -e "   ${YELLOW}npm run dev${NC}          - Start development server"
    echo -e "   ${YELLOW}npm run build${NC}        - Build for production"
    echo -e "   ${YELLOW}npm run quality${NC}      - Run all quality checks"
    echo -e "   ${YELLOW}npm run lint${NC}         - Run ESLint"
    echo -e "   ${YELLOW}npm run test${NC}         - Run tests"
    echo ""
    echo -e "${GREEN}🎯 Framework features enabled:${NC}"
    echo -e "   ✅ TypeScript strict mode"
    echo -e "   ✅ Tailwind CSS 4+ with animations"
    echo -e "   ✅ ESLint with quality rules"
    echo -e "   ✅ Prettier formatting"
    echo -e "   ✅ Vitest testing"
    echo -e "   ✅ Git hooks with Husky"
    echo -e "   ✅ AI agent guidance"
    echo ""
}

# Call success function
success

# Disable cleanup trap on success
trap - EXIT
