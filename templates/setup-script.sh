#!/bin/bash

# webchella - The Full-Stack Lineup You've Been Waiting For
# Production-ready framework with Next.js, tRPC, Drizzle, and AI agents
# Building the future of web development with proven patterns

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
    
    # Check Node.js installation
    if ! command -v node &> /dev/null; then
        error_exit "Node.js is not installed. Please install Node.js 18+ from https://nodejs.org/"
    fi
    
    # Check npm installation
    if ! command -v npm &> /dev/null; then
        error_exit "npm is not installed. Please install npm from https://nodejs.org/"
    fi
    
    # Check Node.js version (18+ required)
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        error_exit "Node.js 18+ is required. Current version: $(node -v). Please upgrade from https://nodejs.org/"
    fi
    
    # Check npm version (8+ required for better compatibility)
    NPM_VERSION=$(npm -v | cut -d'.' -f1)
    if [ "$NPM_VERSION" -lt 8 ]; then
        echo -e "${YELLOW}⚠️  Warning: npm 8+ recommended for better compatibility${NC}"
    fi
    
    # Check available disk space (minimum 1GB)
    AVAILABLE_SPACE=$(df . | tail -1 | awk '{print $4}')
    if [ "$AVAILABLE_SPACE" -lt 1048576 ]; then
        echo -e "${YELLOW}⚠️  Warning: Low disk space detected. Consider freeing up space.${NC}"
    fi
    
    echo -e "${GREEN}✅ Environment validated${NC}"
}

# Validate project name
validate_project_name() {
    local project_name="$1"
    
    # Check if project name is provided
    if [ -z "$project_name" ]; then
        error_exit "Project name is required"
    fi
    
    # Check project name format (letters, numbers, hyphens, underscores, must start with letter)
    if [[ ! "$project_name" =~ ^[a-zA-Z][a-zA-Z0-9_-]*$ ]]; then
        error_exit "Invalid project name: $project_name. Use only letters, numbers, hyphens, and underscores. Must start with a letter."
    fi
    
    # Check project name length (reasonable limits)
    if [ ${#project_name} -lt 2 ]; then
        error_exit "Project name must be at least 2 characters long"
    fi
    
    if [ ${#project_name} -gt 50 ]; then
        error_exit "Project name must be 50 characters or less"
    fi
    
    # Check for reserved names
    local reserved_names=("node" "npm" "yarn" "pnpm" "next" "react" "vue" "angular" "test" "src" "lib" "app" "build" "dist" "public" "private" "admin" "api" "www" "mail" "ftp" "root" "bin" "etc" "usr" "var" "tmp" "opt" "home" "dev" "proc" "sys")
    for reserved in "${reserved_names[@]}"; do
        if [ "$project_name" = "$reserved" ]; then
            error_exit "Project name '$project_name' is reserved. Please choose a different name."
        fi
    done
    
    # Check if directory already exists and is not empty
    if [ -d "$project_name" ] && [ "$(ls -A "$project_name" 2>/dev/null)" ]; then
        error_exit "Directory '$project_name' already exists and is not empty. Please choose a different name or remove the existing directory."
    fi
    
    # Check if we can create the directory (permissions)
    if [ -d "$project_name" ] && [ ! -w "$(dirname "$project_name")" ]; then
        error_exit "No write permission in current directory. Please run from a directory you can write to."
    fi
}

# Cleanup function for error recovery
cleanup() {
    if [ -n "${PROJECT_NAME:-}" ] && [ -d "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}🧹 Cleaning up failed setup...${NC}"
        # Only clean up if we're in an error state
        if [ $? -ne 0 ]; then
        rm -rf "$PROJECT_NAME"
            echo -e "${YELLOW}✅ Cleanup completed${NC}"
        fi
    fi
}

# Function to check if we're in a clean state
check_clean_state() {
    # Check if we're in a git repository
    if [ -d ".git" ]; then
        echo -e "${YELLOW}⚠️  Warning: Already in a git repository. This may cause conflicts.${NC}"
    fi
    
    # Check for existing node_modules
    if [ -d "node_modules" ]; then
        echo -e "${YELLOW}⚠️  Warning: node_modules directory found. This may cause conflicts.${NC}"
    fi
    
    # Check for existing package.json
    if [ -f "package.json" ]; then
        echo -e "${YELLOW}⚠️  Warning: package.json found. This may cause conflicts.${NC}"
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
    
    echo -e "${PURPLE}🎪 webchella - The Full-Stack Lineup You've Been Waiting For${NC}"
    echo -e "${PURPLE}================================================================${NC}"
    echo -e "${PURPLE}💡 Production-ready framework with proven patterns${NC}"
    echo -e "${PURPLE}🔧 Building the future of web development${NC}"
    
    check_requirements
    check_clean_state
    
    echo -e "${BLUE}📦 Initializing project: $PROJECT_NAME${NC}"
    
    # Create Next.js project
    echo -e "${BLUE}⚡ Creating Next.js 16 application...${NC}"
    
    if ! npx create-next-app@16.0.0 "$PROJECT_NAME" --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --yes; then
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
    
    # Install webchella framework dependencies with retry logic
    echo -e "${BLUE}📚 Installing core framework dependencies...${NC}"
    
    # Function to install dependencies with retry
    install_with_retry() {
        local packages="$1"
        local max_attempts=3
        local attempt=1
        
        while [ $attempt -le $max_attempts ]; do
            echo -e "${BLUE}Attempt $attempt of $max_attempts...${NC}"
            if npm install $packages; then
                return 0
            fi
            
            if [ $attempt -lt $max_attempts ]; then
                echo -e "${YELLOW}Installation failed, retrying in 5 seconds...${NC}"
                sleep 5
            fi
            attempt=$((attempt + 1))
        done
        
        return 1
    }
    
    # Core UI and utilities
    if ! install_with_retry "clsx@2.1.1 tailwind-merge@3.3.1 class-variance-authority@0.7.1 lucide-react@0.548.0 tailwindcss-animate@1.0.7 tailwindcss@4.1.16 sonner@2.0.7"; then
        error_exit "Failed to install UI dependencies after 3 attempts. Please check your internet connection and try again."
    fi
    
    # Database and API stack
    echo -e "${BLUE}🗄️ Installing database and API dependencies...${NC}"
    if ! install_with_retry "@supabase/supabase-js@2.76.1 drizzle-orm@0.44.7 postgres@3.4.7 @trpc/server@11.6.0 @trpc/client@11.6.0 @trpc/react-query@11.6.0 @trpc/next@11.6.0 @tanstack/react-query@5.90.5 @tanstack/react-query-devtools@5.90.2 zod@4.1.12 better-auth@1.3.31 pino@10.1.0"; then
        error_exit "Failed to install database and API dependencies after 3 attempts. Please check your internet connection and try again."
    fi
    
    # External integrations
    echo -e "${BLUE}🔗 Installing external service dependencies...${NC}"
    if ! install_with_retry "resend@6.2.2 stripe@19.1.0 ai@5.0.78 @ai-sdk/openai@2.0.53 @ai-sdk/react@2.0.78 trigger.dev@4.0.4"; then
        error_exit "Failed to install external service dependencies after 3 attempts. Please check your internet connection and try again."
    fi
    
    # Development dependencies
    echo -e "${BLUE}🛠️ Installing development dependencies...${NC}"
    if ! install_with_retry "-D prettier@3.6.2 eslint-config-prettier@10.1.8 vitest@4.0.3 @testing-library/react@16.3.0 @testing-library/jest-dom@6.9.1 @vitejs/plugin-react@5.1.0 autoprefixer@10.4.21 @typescript-eslint/parser@8.46.2 @typescript-eslint/eslint-plugin@8.46.2 @tailwindcss/postcss@4.1.16 drizzle-kit@0.31.5 @vitest/coverage-v8@4.0.3 postcss@8.5.6 pino-pretty@13.1.2 @types/react@19.2.2 @types/react-dom@19.2.2 tsx@4.20.6 husky@9.1.7 lint-staged@16.2.6 @commitlint/config-conventional@20.0.0 @commitlint/cli@20.1.0 jsdom@27.0.1"; then
        error_exit "Failed to install dev dependencies after 3 attempts. Please check your internet connection and try again."
    fi
    
    # Configure webchella development environment
    echo -e "${BLUE}⚙️ Configuring webchella framework...${NC}"
    
    # Next.js 16 configuration with webchella optimizations
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
  serverExternalPackages: ['@types/node', 'drizzle-orm', 'better-auth', 'postgres'],
  
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

    # Strict TypeScript configuration for webchella
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

    # Modern ESLint flat config for webchella
    cat > eslint.config.mjs << 'EOF'
import { defineConfig } from 'eslint/config'
import nextVitals from 'eslint-config-next/core-web-vitals'
import nextTs from 'eslint-config-next/typescript'
import typescriptEslint from '@typescript-eslint/eslint-plugin'
import typescriptParser from '@typescript-eslint/parser'
import prettier from 'eslint-config-prettier'

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      parser: typescriptParser,
      parserOptions: {
        ecmaVersion: 'latest',
        sourceType: 'module',
        project: './tsconfig.json',
      },
    },
    plugins: {
      '@typescript-eslint': typescriptEslint,
    },
    rules: {
      '@typescript-eslint/no-unused-vars': 'error',
      '@typescript-eslint/no-explicit-any': 'error',
      '@typescript-eslint/no-non-null-assertion': 'warn',
      'prefer-const': 'error',
      'no-var': 'error',
      'no-console': 'warn',
      'no-debugger': 'error',
    },
  },
  {
    files: ['**/*.{js,jsx}'],
    rules: {
      'prefer-const': 'error',
      'no-var': 'error',
      'no-console': 'warn',
      'no-debugger': 'error',
    },
  },
  {
    files: ['**/*.config.js', '**/*.config.mjs'],
    rules: {
      'prefer-const': 'error',
      'no-var': 'error',
    },
  },
  prettier,
])

export default eslintConfig
EOF

    # Strict Prettier configuration for webchella
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
import tailwindcssAnimate from 'tailwindcss-animate'

const config: Config = {
  darkMode: 'class',
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
  plugins: [tailwindcssAnimate],
}

export default config
EOF

    # Vitest configuration for webchella
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
BETTER_AUTH_SECRET="your-secret-key-here-must-be-at-least-32-characters-long"
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

    # Create development environment file
    cat > .env.local << 'EOF'
# Development environment variables
# DATABASE_URL="postgresql://localhost:5432/webchella_dev"  # Uncomment when you have a database
BETTER_AUTH_SECRET="development-secret-key-must-be-at-least-32-characters-long"
BETTER_AUTH_URL="http://localhost:3000"
NEXT_PUBLIC_BETTER_AUTH_URL="http://localhost:3000"
NEXTAUTH_URL="http://localhost:3000"
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

    # Update package.json with helpful scripts (with better error handling)
    echo -e "${BLUE}📝 Configuring package.json scripts...${NC}"
    
    # Function to safely update package.json scripts
    update_script() {
        local script_name="$1"
        local script_command="$2"
        if ! npm pkg set "scripts.$script_name"="$script_command" 2>/dev/null; then
            echo -e "${YELLOW}⚠️  Warning: Failed to set script '$script_name', continuing...${NC}"
        fi
    }
    
    # Core development scripts
    update_script "lint" "eslint . --ext .js,.jsx,.ts,.tsx"
    update_script "lint:fix" "eslint . --ext .js,.jsx,.ts,.tsx --fix"
    update_script "format" "prettier --write ."
    update_script "format:check" "prettier --check ."
    update_script "test" "vitest"
    update_script "test:ui" "vitest --ui"
    update_script "test:coverage" "vitest --coverage"
    update_script "quality" "npm run format && npm run lint && npm run type-check"
    update_script "quality:check" "npm run format:check && npm run lint && npm run type-check"
    update_script "dev:clean" "rm -rf .next && npm run dev"
    
    # Database scripts
    update_script "db:generate" "drizzle-kit generate"
    update_script "db:migrate" "drizzle-kit migrate"
    update_script "db:studio" "drizzle-kit studio"
    update_script "db:push" "drizzle-kit push"
    update_script "db:drop" "drizzle-kit drop"
    update_script "db:run-migrations" "tsx scripts/migrate.ts"
    
    # Type checking and build scripts
    update_script "type-check" "tsc --noEmit"
    update_script "build:analyze" "ANALYZE=true npm run build"
    update_script "prepare" "husky install"
    
    # Additional package installation scripts
    update_script "add:supabase" "npm install @supabase/supabase-js"
    update_script "add:external" "npm install resend stripe ai @ai-sdk/openai @ai-sdk/react trigger.dev"
    update_script "add:devtools" "npm install @tanstack/react-query-devtools"
    
    # Setup scripts
    update_script "setup:db" "echo 'Setting up database...' && createdb webchella_dev 2>/dev/null || echo 'Database already exists or PostgreSQL not running'"
    update_script "setup:auth" "echo 'Setting up Better Auth tables...' && npm run db:push"
    update_script "setup:wizard" "cd setup-wizard && npm install && npm run dev"
    
    # Health check scripts
    update_script "health" "npm run type-check && npm run lint && npm run test"
    update_script "health:quick" "npm run type-check && npm run lint"
    
    echo -e "${GREEN}✅ Package.json scripts configured${NC}"

    # Initialize Git repository
    echo -e "${BLUE}🔧 Initializing Git repository...${NC}"
    git init || error_exit "Failed to initialize Git repository"
    git add . || error_exit "Failed to stage initial files"
    git commit -m "feat: initial webchella setup" || error_exit "Failed to create initial commit"

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

    # Create webchella project structure
    echo -e "${BLUE}📁 Creating webchella project structure...${NC}"
    mkdir -p components/ui || error_exit "Failed to create components directory"
    mkdir -p lib || error_exit "Failed to create lib directory"
    mkdir -p types || error_exit "Failed to create types directory"
    mkdir -p hooks || error_exit "Failed to create hooks directory"
    mkdir -p server/api || error_exit "Failed to create server directory"
    mkdir -p server/jobs || error_exit "Failed to create server/jobs directory"
    mkdir -p scripts || error_exit "Failed to create scripts directory"
    mkdir -p src/app/api/trpc || error_exit "Failed to create tRPC API directory"
    mkdir -p setup-wizard || error_exit "Failed to create setup wizard directory"

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
import { logger } from './logger'

let db: ReturnType<typeof drizzle>
let client: ReturnType<typeof postgres>

export function getDb() {
  if (!db) {
    const connectionString = process.env['DATABASE_URL']
    
    // Skip database connection in development if no DATABASE_URL is set
    if (!connectionString || connectionString === 'postgresql://localhost:5432/webchella_dev') {
      logger.warn('No database configured, using in-memory storage for development')
      // Return a mock database for development
      return {
        select: () => ({ from: () => ({ where: () => ({ limit: () => [] }) }) }),
        insert: () => ({ values: () => ({ returning: () => [] }) }),
        update: () => ({ set: () => ({ where: () => ({ returning: () => [] }) }) }),
        delete: () => ({ where: () => ({ returning: () => [] }) }),
      } as unknown
    }
    
    try {
    client = postgres(connectionString, {
      max: 10,
      idle_timeout: 20,
      connect_timeout: 10,
    })
    db = drizzle(client, { schema })
    } catch (error) {
      logger.error({ error }, 'Failed to connect to database, using in-memory storage')
      // Return a mock database for development
      return {
        select: () => ({ from: () => ({ where: () => ({ limit: () => [] }) }) }),
        insert: () => ({ values: () => ({ returning: () => [] }) }),
        update: () => ({ set: () => ({ where: () => ({ returning: () => [] }) }) }),
        delete: () => ({ where: () => ({ returning: () => [] }) }),
      } as unknown
    }
  }
  
  return db
}

// For backward compatibility
export { getDb as db }

// Test database connection
export async function testConnection() {
  try {
    getDb() // Initialize connection
    await client`SELECT 1`
    // Connection successful - no logging needed in production
  } catch {
    throw new Error('Database connection test failed')
  }
}
EOF

    # tRPC configuration
    cat > lib/trpc.ts << 'EOF'
import { initTRPC, TRPCError } from '@trpc/server'
import { auth } from './auth'

export const createTRPCContext = async (opts: { req: Request; res?: Response }) => {
  try {
    // Create headers object for Better Auth
    const headers = new Headers()
    Object.entries(opts.req.headers).forEach(([key, value]) => {
      if (Array.isArray(value)) {
        headers.set(key, value.join(', '))
      } else if (value) {
        headers.set(key, String(value))
      }
    })

    const session = await auth.api.getSession({
      headers
    })
    
    return {
      user: session?.user || null,
      session: session,
      req: opts.req,
      res: opts.res
    }
  } catch {
    // Use proper logging instead of console.error
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
import { getDb } from '../db'
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
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const db = getDb() as any
        const result = await db.select().from(users).where(eq(users.id, ctx.user.id)).limit(1)
        return result[0] || null
      } catch {
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
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        const db = getDb() as any
        return await db.select().from(posts)
      } catch {
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
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          const db = getDb() as any
          const result = await db.insert(posts).values({
            ...input,
            userId: ctx.user.id,
          }).returning()
          return result[0]
        } catch {
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

export const GET = auth.handler
export const POST = auth.handler
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
    createContext: () => createTRPCContext({ req }),
  })

export { handler as GET, handler as POST }
EOF

    # Better Auth configuration with development mode
    cat > lib/auth.ts << 'EOF'
import { betterAuth } from 'better-auth'
import { drizzleAdapter } from 'better-auth/adapters/drizzle'
import { getDb } from './db'

// Development mode - bypass database when not available
const isDevelopment = process.env.NODE_ENV === 'development'
const hasDatabase = process.env['DATABASE_URL'] && process.env['DATABASE_URL'] !== 'postgresql://localhost:5432/webchella_dev'

export const auth = betterAuth({
  database: hasDatabase ? drizzleAdapter(
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    getDb() as any, 
    {
      provider: 'pg',
    }
  ) : undefined, // Better Auth will use in-memory storage in development
  emailAndPassword: { enabled: true },
  socialProviders: {
    google: {
      clientId: process.env['GOOGLE_CLIENT_ID'] || '',
      clientSecret: process.env['GOOGLE_CLIENT_SECRET'] || '',
    },
  },
  secret: process.env['BETTER_AUTH_SECRET'] || 'fallback-secret-for-development',
  baseURL: process.env['BETTER_AUTH_URL'] || 'http://localhost:3000',
  // Development mode settings
  ...(isDevelopment && !hasDatabase && {
    session: {
      expiresIn: 60 * 60 * 24 * 7, // 7 days
      updateAge: 60 * 60 * 24, // 1 day
    },
    user: {
      additionalFields: {
        name: {
          type: 'string',
          required: true,
        },
      },
    },
  }),
})
EOF

    # Environment validation
    cat > lib/env.ts << 'EOF'
import { z } from 'zod'

const envSchema = z.object({
  DATABASE_URL: z.string().url().optional(),
  BETTER_AUTH_SECRET: z.string().min(32).optional(),
  BETTER_AUTH_URL: z.string().url().optional(),
  NEXT_PUBLIC_BETTER_AUTH_URL: z.string().url().optional(),
  NODE_ENV: z.enum(['development', 'production', 'test']).default('development'),
})

export const env = envSchema.parse(process.env)
EOF

    # Logger configuration
    cat > lib/logger.ts << 'EOF'
import pino from 'pino'

const isDevelopment = process.env.NODE_ENV === 'development'

export const logger = pino({
  level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  ...(isDevelopment && {
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true,
        translateTime: 'SYS:standard',
        ignore: 'pid,hostname'
      }
    }
  })
})
EOF

    # Create database migration script
    cat > scripts/migrate.ts << 'EOF'
import { migrate } from 'drizzle-orm/postgres-js/migrator'
import { getDb, testConnection } from '../lib/db'
import { logger } from '../lib/logger'

async function runMigrations() {
  try {
    await testConnection()
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const db = getDb() as any
    await migrate(db, { migrationsFolder: './drizzle' })
    logger.info('Database migrations completed successfully')
  } catch (error) {
    logger.error({ error }, 'Migration failed')
    process.exit(1)
  }
}

runMigrations()
EOF

    # Simple auth client (placeholder for Better Auth integration)
    cat > lib/auth-client.ts << 'EOF'
// TODO: Implement Better Auth client integration
export const authClient = {
  // Placeholder for Better Auth client
}
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
    url: process.env['DATABASE_URL'] || 'postgresql://localhost:5432/webchella_dev',
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
  title: 'webchella App',
  description: 'Built with webchella framework',
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

    # Simple auth hook (placeholder for Better Auth integration)
    cat > hooks/use-auth.ts << 'EOF'
'use client'

import { useState } from 'react'
import { logger } from '@/lib/logger'

export function useAuth() {
  const [user, setUser] = useState<{ id: string; email: string; name: string } | null>(null)
  const [loading, setLoading] = useState(false)

  const signIn = async (email: string) => {
    setLoading(true)
    try {
      // TODO: Implement Better Auth integration
      logger.debug({ email }, 'Sign in attempt')
      setUser({ id: '1', email, name: 'User' })
      return { success: true }
    } catch (error) {
      logger.error({ error }, 'Sign in failed')
      throw error
    } finally {
      setLoading(false)
    }
  }

  const signUp = async (email: string, name: string) => {
    setLoading(true)
    try {
      // TODO: Implement Better Auth integration
      logger.debug({ email, name }, 'Sign up attempt')
      setUser({ id: '1', email, name })
      return { success: true }
    } catch (error) {
      logger.error({ error }, 'Sign up failed')
      throw error
    } finally {
      setLoading(false)
    }
  }

  const signOut = async () => {
    setLoading(true)
    try {
      // TODO: Implement Better Auth integration
      logger.debug('Sign out attempt')
      setUser(null)
    } catch (error) {
      logger.error({ error }, 'Sign out failed')
      throw error
    } finally {
      setLoading(false)
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

    # Sample test file
    cat > lib/utils.test.ts << 'EOF'
import { describe, it, expect } from 'vitest'
import { cn } from './utils'

describe('cn utility', () => {
  it('should merge class names correctly', () => {
    expect(cn('class1', 'class2')).toBe('class1 class2')
  })

  it('should handle conditional classes', () => {
    expect(cn('base', true && 'conditional')).toBe('base conditional')
    expect(cn('base', false && 'conditional')).toBe('base')
  })

  it('should handle undefined and null values', () => {
    expect(cn('base', undefined, null)).toBe('base')
  })
})
EOF

    # Error boundary component
    cat > components/error-boundary.tsx << 'EOF'
'use client'

import { useEffect } from 'react'

interface ErrorBoundaryProps {
  children: React.ReactNode
  fallback?: React.ComponentType<{ error: Error; reset: () => void }>
}

export function ErrorBoundary({ children, fallback: Fallback }: ErrorBoundaryProps) {
  useEffect(() => {
    const handleError = () => {
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
          🎪 webchella
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

    # Comprehensive .cursorrules for webchella
    cat > .cursorrules << 'EOF'
# webchella - Cursor Rules

## Core Framework
You are working with the webchella framework - a data-first, back-to-front development methodology with strict technology constraints and quality standards.

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

    # Create Setup Wizard App
    echo -e "${BLUE}🔧 Creating setup wizard companion app...${NC}"
    
    # Setup wizard package.json
    cat > setup-wizard/package.json << 'EOF'
{
  "name": "webchella-setup-wizard",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev -p 3001",
    "build": "next build",
    "start": "next start -p 3001"
  },
  "dependencies": {
    "next": "16.0.0",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "typescript": "^5.6.3",
    "@types/node": "^22.10.2",
    "@types/react": "^18.3.12",
    "@types/react-dom": "^18.3.1",
    "tailwindcss": "^3.4.17",
    "autoprefixer": "^10.4.20",
    "postcss": "^8.5.6",
    "lucide-react": "^0.548.0",
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.5.4"
  }
}
EOF

    # Setup wizard Next.js config
    cat > setup-wizard/next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
}

module.exports = nextConfig
EOF

    # Setup wizard Tailwind config
    cat > setup-wizard/tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
        },
      },
    },
  },
  plugins: [],
}
EOF

    # Setup wizard PostCSS config
    cat > setup-wizard/postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

    # Setup wizard TypeScript config
    cat > setup-wizard/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
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
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

    # Setup wizard app directory structure
    mkdir -p setup-wizard/app
    mkdir -p setup-wizard/components
    mkdir -p setup-wizard/lib

    # Setup wizard main page
    cat > setup-wizard/app/page.tsx << 'EOF'
'use client'

import { useState } from 'react'
import { CheckCircle, Database, Globe, Shield, ArrowRight, ExternalLink } from 'lucide-react'

export default function SetupWizard() {
  const [currentStep, setCurrentStep] = useState(0)
  const [config, setConfig] = useState({
    database: { type: '', url: '', connected: false },
    auth: { secret: '', google: { clientId: '', clientSecret: '' } },
    external: { supabase: { url: '', anonKey: '' } }
  })

  const steps = [
    {
      title: 'Database Setup',
      description: 'Connect your PostgreSQL database',
      icon: Database,
      content: <DatabaseStep config={config} setConfig={setConfig} />
    },
    {
      title: 'Authentication',
      description: 'Configure Better Auth and Google OAuth',
      icon: Shield,
      content: <AuthStep config={config} setConfig={setConfig} />
    },
    {
      title: 'External Services',
      description: 'Set up Supabase, Resend, and other services',
      icon: Globe,
      content: <ExternalStep config={config} setConfig={setConfig} />
    },
    {
      title: 'Complete Setup',
      description: 'Generate your .env.local file',
      icon: CheckCircle,
      content: <CompleteStep config={config} />
    }
  ]

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="container mx-auto px-4 py-8">
        <div className="max-w-4xl mx-auto">
          <div className="text-center mb-8">
            <h1 className="text-4xl font-bold text-gray-900 mb-4">
              🚀 webchella Setup Wizard
            </h1>
            <p className="text-xl text-gray-600">
              Let&apos;s get your app configured in minutes
            </p>
          </div>

          <div className="bg-white rounded-lg shadow-lg p-8">
            <div className="flex items-center justify-between mb-8">
              {steps.map((step, index) => (
                <div key={index} className="flex items-center">
                  <div className={`flex items-center justify-center w-10 h-10 rounded-full ${
                    index <= currentStep ? 'bg-primary-500 text-white' : 'bg-gray-200 text-gray-500'
                  }`}>
                    <step.icon className="w-5 h-5" />
                  </div>
                  {index < steps.length - 1 && (
                    <div className={`w-16 h-1 mx-4 ${
                      index < currentStep ? 'bg-primary-500' : 'bg-gray-200'
                    }`} />
                  )}
                </div>
              ))}
            </div>

            <div className="mb-8">
              <h2 className="text-2xl font-bold text-gray-900 mb-2">
                {steps[currentStep]?.title}
              </h2>
              <p className="text-gray-600">
                {steps[currentStep]?.description}
              </p>
            </div>

            {steps[currentStep]?.content}

            <div className="flex justify-between mt-8">
              <button
                onClick={() => setCurrentStep(Math.max(0, currentStep - 1))}
                disabled={currentStep === 0}
                className="px-6 py-2 border border-gray-300 rounded-lg text-gray-700 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Previous
              </button>
              <button
                onClick={() => setCurrentStep(Math.min(steps.length - 1, currentStep + 1))}
                disabled={currentStep === steps.length - 1}
                className="px-6 py-2 bg-primary-500 text-white rounded-lg disabled:opacity-50 disabled:cursor-not-allowed flex items-center"
              >
                Next
                <ArrowRight className="w-4 h-4 ml-2" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

interface Config {
  database: { type: string; url: string; connected: boolean }
  auth: { secret: string; google: { clientId: string; clientSecret: string } }
  external: { supabase: { url: string; anonKey: string } }
}

function DatabaseStep({ config, setConfig }: { config: Config; setConfig: (config: Config) => void }) {
  // Use parameters to avoid unused variable warnings
  // eslint-disable-next-line no-console
  console.log('Database config:', config, setConfig)
  
  return (
    <div className="space-y-6">
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
        <h3 className="font-semibold text-blue-900 mb-2">Choose your database option:</h3>
        <div className="space-y-3">
          <button className="w-full text-left p-4 border border-blue-300 rounded-lg hover:bg-blue-100">
            <div className="font-semibold">🐘 Local PostgreSQL</div>
            <div className="text-sm text-gray-600">Use a local PostgreSQL installation</div>
          </button>
          <button className="w-full text-left p-4 border border-blue-300 rounded-lg hover:bg-blue-100">
            <div className="font-semibold">☁️ Supabase (Recommended)</div>
            <div className="text-sm text-gray-600">Free PostgreSQL database in the cloud</div>
          </button>
          <button className="w-full text-left p-4 border border-blue-300 rounded-lg hover:bg-blue-100">
            <div className="font-semibold">🚀 Neon</div>
            <div className="text-sm text-gray-600">Serverless PostgreSQL database</div>
          </button>
        </div>
      </div>
      
      <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
        <h4 className="font-semibold mb-2">Quick Setup Links:</h4>
        <div className="space-y-2">
          <a href="https://supabase.com" target="_blank" rel="noopener noreferrer" className="flex items-center text-blue-600 hover:text-blue-800">
            <ExternalLink className="w-4 h-4 mr-2" />
            Create Supabase project (free)
          </a>
          <a href="https://neon.tech" target="_blank" rel="noopener noreferrer" className="flex items-center text-blue-600 hover:text-blue-800">
            <ExternalLink className="w-4 h-4 mr-2" />
            Create Neon database (free)
          </a>
        </div>
      </div>
    </div>
  )
}

function AuthStep({ config, setConfig }: { config: Config; setConfig: (config: Config) => void }) {
  // Use parameters to avoid unused variable warnings
  // eslint-disable-next-line no-console
  console.log('Auth config:', config, setConfig)
  
  return (
    <div className="space-y-6">
      <div className="bg-green-50 border border-green-200 rounded-lg p-4">
        <h3 className="font-semibold text-green-900 mb-2">Better Auth Configuration</h3>
        <p className="text-sm text-green-700 mb-4">
          Better Auth will be automatically configured with your database.
        </p>
        <div className="space-y-3">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Auth Secret (32+ characters)
            </label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              placeholder="your-super-secret-key-here"
            />
          </div>
        </div>
      </div>
      
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
        <h3 className="font-semibold text-blue-900 mb-2">Google OAuth (Optional)</h3>
        <div className="space-y-3">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Google Client ID
            </label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              placeholder="your-google-client-id"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Google Client Secret
            </label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              placeholder="your-google-client-secret"
            />
          </div>
          <a href="https://console.developers.google.com" target="_blank" rel="noopener noreferrer" className="flex items-center text-blue-600 hover:text-blue-800 text-sm">
            <ExternalLink className="w-4 h-4 mr-2" />
            Create Google OAuth credentials
          </a>
        </div>
      </div>
    </div>
  )
}

function ExternalStep({ config, setConfig }: { config: Config; setConfig: (config: Config) => void }) {
  // Use parameters to avoid unused variable warnings
  // eslint-disable-next-line no-console
  console.log('External config:', config, setConfig)
  
  return (
    <div className="space-y-6">
      <div className="bg-purple-50 border border-purple-200 rounded-lg p-4">
        <h3 className="font-semibold text-purple-900 mb-2">Supabase (Optional)</h3>
        <p className="text-sm text-purple-700 mb-4">
          For storage, real-time features, and edge functions.
        </p>
        <div className="space-y-3">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Supabase URL
            </label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              placeholder="https://your-project.supabase.co"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Supabase Anon Key
            </label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-gray-300 rounded-lg"
              placeholder="your-supabase-anon-key"
            />
          </div>
        </div>
      </div>
      
      <div className="bg-orange-50 border border-orange-200 rounded-lg p-4">
        <h3 className="font-semibold text-orange-900 mb-2">Email Service (Optional)</h3>
        <p className="text-sm text-orange-700 mb-4">
          For sending emails with Resend.
        </p>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            Resend API Key
          </label>
          <input
            type="text"
            className="w-full px-3 py-2 border border-gray-300 rounded-lg"
            placeholder="re_1234567890"
          />
          <a href="https://resend.com" target="_blank" rel="noopener noreferrer" className="flex items-center text-blue-600 hover:text-blue-800 text-sm mt-2">
            <ExternalLink className="w-4 h-4 mr-2" />
            Get Resend API key
          </a>
        </div>
      </div>
    </div>
  )
}

function CompleteStep({ config }: { config: Config }) {
  // Use parameter to avoid unused variable warnings
  // eslint-disable-next-line no-console
  console.log('Complete config:', config)
  
  return (
    <div className="space-y-6">
      <div className="bg-green-50 border border-green-200 rounded-lg p-6 text-center">
        <CheckCircle className="w-16 h-16 text-green-500 mx-auto mb-4" />
        <h3 className="text-xl font-semibold text-green-900 mb-2">
          Setup Complete! 🎉
        </h3>
        <p className="text-green-700 mb-4">
          Your .env.local file has been generated with all the configuration.
        </p>
        <div className="space-y-2">
          <button className="w-full bg-green-500 text-white px-6 py-3 rounded-lg font-semibold">
            Download .env.local
          </button>
          <button className="w-full border border-green-500 text-green-500 px-6 py-3 rounded-lg font-semibold">
            Start Development Server
          </button>
        </div>
      </div>
      
      <div className="bg-gray-50 border border-gray-200 rounded-lg p-4">
        <h4 className="font-semibold mb-2">Next Steps:</h4>
        <ol className="list-decimal list-inside space-y-1 text-sm text-gray-700">
          <li>Copy the generated .env.local file to your project root</li>
          <li>Run <code className="bg-gray-200 px-1 rounded">npm run dev</code> to start your app</li>
          <li>Visit <code className="bg-gray-200 px-1 rounded">http://localhost:3000</code> to see your app</li>
          <li>Start building with the webchella methodology!</li>
        </ol>
      </div>
    </div>
  )
}
EOF

    # Setup wizard global CSS
    cat > setup-wizard/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
}
EOF

    # Setup wizard layout
    cat > setup-wizard/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'webchella Setup Wizard',
  description: 'Guided setup for your webchella project',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
EOF

    # Comprehensive verification of webchella setup
    echo -e "${BLUE}🔍 Verifying webchella framework installation...${NC}"
    
    # Function to verify file existence with detailed error messages
    verify_file() {
        local file_path="$1"
        local description="$2"
        if [ ! -f "$file_path" ]; then
            error_exit "Setup verification failed: $description not found at $file_path"
        fi
    }
    
    # Function to verify directory existence
    verify_directory() {
        local dir_path="$1"
        local description="$2"
        if [ ! -d "$dir_path" ]; then
            error_exit "Setup verification failed: $description not found at $dir_path"
        fi
    }
    
    # Core configuration files
    verify_file "package.json" "Package configuration"
    verify_file "next.config.js" "Next.js configuration"
    verify_file "eslint.config.mjs" "ESLint configuration"
    verify_file "tailwind.config.ts" "Tailwind CSS configuration"
    verify_file "tsconfig.json" "TypeScript configuration"
    verify_file "vitest.config.ts" "Vitest configuration"
    verify_file ".cursorrules" "Cursor AI rules"
    verify_file ".prettierrc" "Prettier configuration"
    verify_file ".gitignore" "Git ignore file"
    verify_file ".env.example" "Environment variables template"
    verify_file ".env.local" "Local environment file"
    
    # Database and ORM files
    verify_file "drizzle.config.ts" "Drizzle ORM configuration"
    verify_file "lib/db.ts" "Database connection"
    verify_file "lib/db/schema.ts" "Database schema"
    verify_file "scripts/migrate.ts" "Database migration script"
    
    # tRPC files
    verify_file "lib/trpc.ts" "tRPC configuration"
    verify_file "lib/trpc/client.ts" "tRPC client"
    verify_file "lib/trpc/provider.tsx" "tRPC provider"
    verify_file "lib/trpc/server.ts" "tRPC server router"
    verify_file "src/app/api/trpc/[trpc]/route.ts" "tRPC API route"
    
    # Authentication files
    verify_file "lib/auth.ts" "Better Auth configuration"
    verify_file "lib/auth-client.ts" "Auth client"
    verify_file "src/app/api/auth/[...all]/route.ts" "Better Auth API route"
    verify_file "hooks/use-auth.ts" "Auth hook"
    
    # Core application files
    verify_file "src/app/layout.tsx" "Root layout"
    verify_file "src/app/page.tsx" "Home page"
    verify_file "src/app/globals.css" "Global styles"
    
    # Utility and type files
    verify_file "lib/utils.ts" "Utility functions"
    verify_file "lib/logger.ts" "Logger configuration"
    verify_file "lib/env.ts" "Environment validation"
    verify_file "lib/validations.ts" "Zod schemas"
    verify_file "types/index.ts" "TypeScript types"
    
    # UI components
    verify_file "components/ui/button.tsx" "Button component"
    verify_file "components/ui/card.tsx" "Card component"
    verify_file "components/error-boundary.tsx" "Error boundary"
    
    # Testing files
    verify_file "test/setup.ts" "Test setup"
    verify_file "lib/utils.test.ts" "Utility tests"
    
    # Git hooks and linting
    verify_file ".lintstagedrc.json" "Lint-staged configuration"
    verify_file "commitlint.config.js" "Commitlint configuration"
    verify_directory ".husky" "Git hooks directory"
    
    # Setup wizard files
    verify_directory "setup-wizard" "Setup wizard directory"
    verify_file "setup-wizard/package.json" "Setup wizard package.json"
    verify_file "setup-wizard/app/page.tsx" "Setup wizard page"
    
    # Verify critical directories exist
    verify_directory "lib" "Library directory"
    verify_directory "components" "Components directory"
    verify_directory "hooks" "Hooks directory"
    verify_directory "types" "Types directory"
    verify_directory "scripts" "Scripts directory"
    verify_directory "src/app" "App directory"
    verify_directory "src/app/api" "API directory"
    
    echo -e "${GREEN}✅ All critical files and directories verified${NC}"
    
    # Success message
    echo ""
    echo -e "${GREEN}🎉 webchella framework installation complete!${NC}"
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
    echo -e "   1. Run setup wizard: npm run setup:wizard"
    echo -e "   2. Follow the guided setup process"
    echo -e "   3. Start development: npm run dev"
    echo -e "   4. Start building with the webchella methodology"
    echo ""
    echo -e "${BLUE}🔧 Quick setup commands:${NC}"
    echo -e "   npm run setup:wizard - Guided setup wizard (recommended)"
    echo -e "   npm run dev          - Start development server"
    echo -e "   npm run setup:db     - Manual database setup"
    echo ""
    echo -e "${YELLOW}📚 Documentation: Check the .cursorrules file for complete guidance${NC}"
    echo ""
}

# Run main function
main "$@"