#!/bin/bash

# webapppromptpack - Modern Web App Framework
# Next-generation development environment with AI-first architecture
# Building the future of web development

set -euo pipefail

# Debug: Show current directory and environment
echo "DEBUG: Current directory: $(pwd)"
echo "DEBUG: Script arguments: $@"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Error handling
error_exit() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
    exit 1
}

# Check requirements
check_requirements() {
    echo -e "${BLUE}Validating development environment...${NC}"
    
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
    
    echo -e "${GREEN}Environment validated${NC}"
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
    
    echo -e "${BLUE}webapppromptpack - Modern Web App Framework${NC}"
    echo -e "${BLUE}===========================================${NC}"
    echo -e "${BLUE}Building the future of web development${NC}"
    
    check_requirements
    
    echo -e "${BLUE}Initializing project: $PROJECT_NAME${NC}"
    
    # Create Next.js project
    echo -e "${BLUE}Creating Next.js 16 application...${NC}"
    
    if ! npx create-next-app@latest "$PROJECT_NAME" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --yes; then
        error_exit "Failed to create Next.js project. Please check your internet connection and try again."
    fi
    
    # Verify project was created
    if [ ! -d "$PROJECT_NAME" ]; then
        error_exit "Project directory was not created. Please check the project name and try again."
    fi
    
    cd "$PROJECT_NAME"
    
    # Install cutting-edge dependencies
    echo -e "${BLUE}Installing framework dependencies...${NC}"
    if ! npm install clsx tailwind-merge class-variance-authority lucide-react; then
        error_exit "Failed to install dependencies. Please check your internet connection and try again."
    fi
    
    if ! npm install -D prettier eslint-config-prettier vitest @testing-library/react @testing-library/jest-dom @vitejs/plugin-react autoprefixer @typescript-eslint/parser @typescript-eslint/eslint-plugin @tailwindcss/postcss; then
        error_exit "Failed to install dev dependencies. Please check your internet connection and try again."
    fi
    
    # Configure development environment
    echo -e "${BLUE}Configuring development environment...${NC}"
    
    # Next.js 16 configuration with cutting-edge features
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
    optimizePackageImports: ['lucide-react'],
    serverComponentsExternalPackages: ['@types/node'],
  },
  
  // Compiler optimizations
  compiler: {
    removeConsole: process.env.NODE_ENV === 'production',
  },
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

    # Advanced ESLint configuration for production-grade code
    cat > .eslintrc.json << 'EOF'
{
  "extends": [
    "next/core-web-vitals",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "off",
    "@typescript-eslint/no-explicit-any": "warn",
    "@typescript-eslint/consistent-type-imports": "error",
    "@typescript-eslint/prefer-nullish-coalescing": "error",
    "@typescript-eslint/prefer-optional-chain": "error",
    "no-console": "warn",
    "prefer-const": "error",
    "prefer-template": "error",
    "no-var": "error"
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
  "printWidth": 80
}
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

# Vercel
.vercel

# TypeScript
*.tsbuildinfo
next-env.d.ts
EOF

    # Update package.json with helpful scripts
    npm pkg set scripts.lint="next lint" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.format="prettier --write ." || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.test="vitest" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.quality="npm run lint && npm run format && npm run test" || error_exit "Failed to update package.json scripts"
    npm pkg set scripts.dev:clean="rm -rf .next && npm run dev" || error_exit "Failed to update package.json scripts"

    # Create advanced project structure
    mkdir -p src/components/ui || error_exit "Failed to create project structure"
    mkdir -p src/lib || error_exit "Failed to create project structure"
    mkdir -p src/types || error_exit "Failed to create project structure"
    mkdir -p src/hooks || error_exit "Failed to create project structure"
    mkdir -p src/server || error_exit "Failed to create project structure"

    # Utils file
    cat > src/lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOF

    # Advanced Button component with modern patterns
    cat > src/components/ui/button.tsx << 'EOF'
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

    # Cursor rules for AI guidance
    cat > .cursorrules << 'EOF'
# webapppromptpack - Cursor Rules

## Technology Stack
- Next.js 16 (App Router) + TypeScript + Tailwind CSS 4+ + shadcn/ui
- Supabase (PostgreSQL) + Drizzle ORM + tRPC + Zod + Better Auth
- Vitest + Testing Library + Pino + Vercel

## Development Methodology (Back-to-Front)
1. **Data Planning** - Plan features, data needs, database schema
2. **Database Layer** - Create Drizzle schemas and migrations
3. **API Layer** - Build tRPC procedures and validation
4. **UI Layer** - Create components and pages
5. **Polish** - Add loading states, error handling, responsiveness
6. **Testing** - Write tests and verify functionality

## Code Quality Rules
- TypeScript strict mode: No `any` types, explicit returns
- ESLint + Prettier: Consistent formatting
- No console.log in production: Use Pino for logging
- Validate all inputs: Use Zod schemas
- Use protected procedures: No direct database access

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
- Use shadcn/ui components by default
- Use Tailwind utility classes
- Use CSS variables for theming
- Support light and dark themes
- Follow responsive design patterns

## Error Handling
- Use global error boundaries
- Handle all errors gracefully
- Use toast notifications for user feedback
- Log errors with Pino
- Provide recovery options

## Testing Strategy
- Write unit tests for tRPC procedures
- Write component tests for UI
- Write integration tests for API
- Test accessibility compliance
- Verify end-to-end functionality

## Security & Performance
- Use Better Auth for authentication
- Validate all inputs with Zod
- Use protected procedures for user data
- Optimize bundle size and performance
- Monitor errors and performance
EOF

    # Verify setup worked
    echo -e "${BLUE}Verifying framework installation...${NC}"
    if [ ! -f "package.json" ]; then
        error_exit "Setup verification failed: package.json not found"
    fi
    if [ ! -f "next.config.js" ]; then
        error_exit "Setup verification failed: next.config.js not found"
    fi
    if [ ! -f ".cursorrules" ]; then
        error_exit "Setup verification failed: .cursorrules not found"
    fi
    
    # Success message
    echo ""
    echo -e "${GREEN}Framework installation complete${NC}"
    echo ""
    echo -e "${GREEN}Project initialized: $PROJECT_NAME${NC}"
    echo -e "${GREEN}Dependencies installed${NC}"
    echo -e "${GREEN}Development environment configured${NC}"
    echo -e "${GREEN}AI-first architecture enabled${NC}"
    echo ""
    echo -e "${BLUE}Development workflow:${NC}"
    echo -e "   cd $PROJECT_NAME"
    echo -e "   npm run dev"
    echo ""
    echo -e "${BLUE}Available commands:${NC}"
    echo -e "   npm run dev          - Start development server"
    echo -e "   npm run build        - Build for production"
    echo -e "   npm run quality      - Run comprehensive quality checks"
    echo -e "   npm run lint         - Run advanced ESLint analysis"
    echo -e "   npm run test         - Run Vitest test suite"
    echo ""
    echo -e "${BLUE}Framework features enabled:${NC}"
    echo -e "   Next.js 16 with App Router and Server Components"
    echo -e "   Tailwind CSS 4+ with modern PostCSS pipeline"
    echo -e "   Advanced ESLint with production-grade rules"
    echo -e "   Vitest testing with React Testing Library"
    echo -e "   shadcn/ui component system with CVA patterns"
    echo -e "   AI-first development with comprehensive .cursorrules"
    echo -e "   Optimized build pipeline with modern tooling"
    echo ""
}

# Run main function
main "$@"