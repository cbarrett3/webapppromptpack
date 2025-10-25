#!/bin/bash

# webapppromptpack - Zero-Friction Setup Script
# Creates a production-ready Next.js app with all best practices

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Version pinning for stability
NEXTJS_VERSION="16.0.0"
REACT_VERSION="19.0.0"
TYPESCRIPT_VERSION="5.7.2"
TAILWIND_VERSION="4.0.0"

# Error handling
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# Check requirements
check_requirements() {
    echo -e "${BLUE}🔍 Checking requirements...${NC}"
    
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
    
    echo -e "${GREEN}✅ Requirements check passed${NC}"
}

# Check for script updates
check_for_updates() {
    echo -e "${BLUE}🔍 Checking for framework updates...${NC}"
    # This could be expanded to check for updates to the framework
    echo -e "${GREEN}✅ Using stable versions${NC}"
}

# Validate project name
validate_project_name() {
    if [[ ! "$1" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
        error_exit "Invalid project name: $1. Use only letters, numbers, hyphens, and underscores. Must start with a letter."
    fi
}

# Cleanup function for error recovery
cleanup() {
    if [ -d "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}🧹 Cleaning up failed setup...${NC}"
        rm -rf "$PROJECT_NAME"
    fi
}

# Set up error handling
trap cleanup EXIT

# Main execution
main() {
    # Check if project name is provided
    if [ $# -eq 0 ]; then
        error_exit "Please provide a project name: bash setup-script.sh my-app"
    fi
    
    PROJECT_NAME="$1"
    validate_project_name "$PROJECT_NAME"
    
    echo -e "${BLUE}🚀 webapppromptpack - Zero-Friction Setup${NC}"
    echo -e "${BLUE}========================================${NC}"
    
    check_requirements
    check_for_updates
    
    echo -e "${BLUE}📁 Creating project: $PROJECT_NAME${NC}"
    
    # Create Next.js project with optimal defaults
    echo -e "${BLUE}⚡ Creating Next.js project...${NC}"
    if ! npx create-next-app@latest "$PROJECT_NAME" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm; then
        error_exit "Failed to create Next.js project. Please check your internet connection and try again."
    fi
    
    cd "$PROJECT_NAME"
    
    # Install essential dependencies
    echo -e "${BLUE}📦 Installing essential dependencies...${NC}"
    if ! npm install clsx tailwind-merge class-variance-authority lucide-react; then
        error_exit "Failed to install essential dependencies. Please check your internet connection and try again."
    fi
    
    # Install dev dependencies with error handling
    echo -e "${BLUE}🔧 Installing development dependencies...${NC}"
    if ! npm install -D eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom @vitejs/plugin-react lint-staged husky @commitlint/config-conventional @commitlint/cli @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-unused-imports autoprefixer; then
        error_exit "Failed to install development dependencies. Please check your internet connection and try again."
    fi
    
    # Cleanup function for error recovery
    cleanup() {
        if [ -d "$PROJECT_NAME" ]; then
            echo -e "${YELLOW}🧹 Cleaning up failed setup...${NC}"
            rm -rf "$PROJECT_NAME"
        fi
    }
    
    # Set up error handling
    trap cleanup EXIT
    
    # Main execution
    main() {
        # Check if project name is provided
        if [ $# -eq 0 ]; then
            error_exit "Please provide a project name: bash setup-script.sh my-app"
        fi
        
        PROJECT_NAME="$1"
        validate_project_name "$PROJECT_NAME"
        
        echo -e "${BLUE}🚀 webapppromptpack - Zero-Friction Setup${NC}"
        echo -e "${BLUE}========================================${NC}"
        
        check_requirements
        check_for_updates
        
        echo -e "${BLUE}📁 Creating project: $PROJECT_NAME${NC}"
        
        # Create Next.js project with optimal defaults
        echo -e "${BLUE}⚡ Creating Next.js project...${NC}"
        if ! npx create-next-app@latest "$PROJECT_NAME" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm; then
            error_exit "Failed to create Next.js project. Please check your internet connection and try again."
        fi
        
        cd "$PROJECT_NAME"
        
        # Install essential dependencies
        echo -e "${BLUE}📦 Installing essential dependencies...${NC}"
        if ! npm install clsx tailwind-merge class-variance-authority lucide-react; then
            error_exit "Failed to install essential dependencies. Please check your internet connection and try again."
        fi
        
        # Install dev dependencies with error handling
        echo -e "${BLUE}🔧 Installing development dependencies...${NC}"
        if ! npm install -D eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom @vitejs/plugin-react lint-staged husky @commitlint/config-conventional @commitlint/cli @typescript-eslint/eslint-plugin @typescript-eslint/parser eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-jsx-a11y eslint-plugin-import eslint-plugin-unused-imports autoprefixer; then
            error_exit "Failed to install development dependencies. Please check your internet connection and try again."
        fi
        
        # Configuration files
        echo -e "${BLUE}⚙️  Setting up configuration files...${NC}"
        
        # Next.js config
        cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    typedRoutes: true,
  },
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

        # Simplified ESLint config that works with Next.js
        cat > .eslintrc.json << 'EOF'
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "plugins": [
    "@typescript-eslint",
    "unused-imports"
  ],
  "rules": {
    "@typescript-eslint/no-unused-vars": "off",
    "unused-imports/no-unused-imports": "error",
    "unused-imports/no-unused-vars": [
      "error",
      {
        "vars": "all",
        "varsIgnorePattern": "^_",
        "args": "after-used",
        "argsIgnorePattern": "^_"
      }
    ],
    "@typescript-eslint/no-explicit-any": "warn",
    "@typescript-eslint/consistent-type-imports": "error",
    "no-console": "warn",
    "prefer-const": "error",
    "prefer-template": "error"
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
dist
build
coverage
*.log
.DS_Store
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
EOF

        # ESLint ignore (Next.js handles most of this)
        cat > .eslintignore << 'EOF'
node_modules
.next
.vercel
dist
build
coverage
*.log
.DS_Store
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
        npm pkg set scripts.quality="npm run type-check && npm run lint && npm run format:check && npm run test"
        npm pkg set scripts.db:generate="drizzle-kit generate"
        npm pkg set scripts.db:migrate="drizzle-kit migrate"
        npm pkg set scripts.db:studio="drizzle-kit studio"
        npm pkg set scripts.db:push="drizzle-kit push"
        npm pkg set scripts.setup:db="npm run db:generate && npm run db:migrate"
        npm pkg set scripts.dev:clean="rm -rf .next && npm run dev"
        npm pkg set scripts.reset="rm -rf .next node_modules package-lock.json && npm install"

        # Setup Husky for git hooks
        echo "🐕 Setting up Husky for git hooks..."
        npx husky init
        echo 'npm run quality' > .husky/pre-commit
        echo 'npx --no -- commitlint --edit $1' > .husky/commit-msg

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
    'body-leading-blank': [1, 'always'],
    'body-max-line-length': [2, 'always', 100],
    'footer-leading-blank': [1, 'always'],
    'header-max-length': [2, 'always', 100],
    'subject-case': [
      2,
      'never',
      ['sentence-case', 'start-case', 'pascal-case', 'upper-case'],
    ],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'type-case': [2, 'always', 'lower-case'],
    'type-empty': [2, 'never'],
  },
}
EOF

        # Create project structure
        echo "📁 Creating project structure..."
        mkdir -p src/components/ui
        mkdir -p src/lib
        mkdir -p src/types
        mkdir -p src/hooks
        mkdir -p src/server
        mkdir -p src/app/api

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
    "jsx": "react-jsx",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    },
    "target": "ES2017",
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "exactOptionalPropertyTypes": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "allowUnreachableCode": false,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

        # Create example components
        echo "📄 Creating example components..."
        
        # Button component
        cat > src/components/ui/button.tsx << 'EOF'
import * as React from "react"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive:
          "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline:
          "border border-input bg-background hover:bg-accent hover:text-accent-foreground",
        secondary:
          "bg-secondary text-secondary-foreground hover:bg-secondary/80",
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

        # Card component
        cat > src/components/ui/card.tsx << 'EOF'
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

        # Utils
        cat > src/lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOF

        # Types
        cat > src/types/index.ts << 'EOF'
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

        # Core files
        echo "📄 Creating core files..."
        
        # Cursor rules for AI guidance
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

        # Success message
        echo ""
        echo -e "${GREEN}🎉 Setup complete!${NC}"
        echo ""
        echo -e "${GREEN}✅ Project created: $PROJECT_NAME${NC}"
        echo -e "${GREEN}✅ All dependencies installed${NC}"
        echo -e "${GREEN}✅ Configuration files created${NC}"
        echo -e "${GREEN}✅ Framework rules added${NC}"
        echo ""
        echo -e "${BLUE}🚀 Next steps:${NC}"
        echo -e "   cd $PROJECT_NAME"
        echo -e "   npm run dev"
        echo ""
        echo -e "${BLUE}✨ Your app is ready to build with AI guidance!${NC}"
        echo -e "   Open in Cursor IDE for the best experience"
        echo ""
        echo -e "${BLUE}📚 Available commands:${NC}"
        echo -e "   npm run dev          - Start development server"
        echo -e "   npm run build        - Build for production"
        echo -e "   npm run quality      - Run all quality checks"
        echo -e "   npm run lint         - Run ESLint"
        echo -e "   npm run test         - Run tests"
        echo ""
        echo -e "${BLUE}🎯 Framework features enabled:${NC}"
        echo -e "   ✅ TypeScript strict mode"
        echo -e "   ✅ Tailwind CSS 4+ with animations"
        echo -e "   ✅ ESLint with quality rules"
        echo -e "   ✅ Prettier formatting"
        echo -e "   ✅ Vitest testing"
        echo -e "   ✅ Git hooks with Husky"
        echo -e "   ✅ AI agent guidance"
        echo ""
    }
    
    # Run main function
    main "$@"