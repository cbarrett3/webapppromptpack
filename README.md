# webapppromptpack

```
              ___.                                                            __                       __ 
__  _  __ ____\_ |__ _____  ______ ______ _____________  ____   _____ _______/  |____________    ____ |  | __
\ \/ \/ // __ \| __ \\__  \ \____ \\____ \\____ \_  __ \/  _ \ /     \\____ \   __\____ \__  \ _/ ___\|  |/ /
 \     /\  ___/| \_\ \/ __ \|  |_> >  |_> >  |_> >  | \(  <_> )  Y Y  \  |_> >  | |  |_> > __ \\  \___|    < 
  \/\_/  \___  >___  (____  /   __/|   __/|   __/|__|   \____/|__|_|  /   __/|__| |   __(____  /\___  >__|_ \
             \/    \/     \/|__|   |__|   |__|                      \/|__|        |__|       \/     \/     \/
```

**Impossible to mess up** - A comprehensive framework for building web applications with AI agents.

## 🚀 Start Building in 2 Minutes

```bash
# One command setup with everything configured
curl -sSL https://raw.githubusercontent.com/cbarrett3/webapppromptpack/main/templates/setup-script.sh | bash -s my-app

cd my-app && npm run dev
```

**What you get:**
- ✅ Complete Next.js 16 project with TypeScript
- ✅ Tailwind CSS 4+ with animations
- ✅ Strict ESLint with 30+ rules
- ✅ Prettier + Husky + Commitlint
- ✅ Vitest testing setup
- ✅ AI guidance via .cursorrules
- ✅ Example components (Button, Card)
- ✅ Development scripts for database, quality, and utilities

## 🤖 AI Agent Workflow

### **Two-Agent System**
1. **PM Agent** writes clear, actionable ticket
2. **Full-Stack Agent** receives ticket with requirements
3. **Full-Stack Agent** builds complete feature
4. **Feature complete** and ready for production

### **Agent Handoff Template**
```markdown
**Feature:** [Feature Name]
**Priority:** [High/Medium/Low]
**Effort:** [XS/S/M/L/XL]

**Requirements:**
- [Clear description of what needs to be built]
- [User story and acceptance criteria]
- [Technical specifications]
- [Design requirements]

**Dependencies:**
- [Other features that must be completed first]
- [External dependencies]

**Success Criteria:**
- [How to know when it's done]
- [Quality standards to meet]
```

## 🎯 Core Philosophy

**"Impossible to Mess Up"** - Strict guardrails, proven patterns, systematic methodology.

### Core Features
- **Data-first development** - Database schema drives everything
- **Type-safe end-to-end** - tRPC + TypeScript + Zod validation
- **AI agent coordination** - PM Agent + Full-Stack Agent workflow
- **Quality enforcement** - Strict linting, testing, and best practices

## 📁 Project Structure

```
my-app/
├── app/                    # Next.js App Router
├── components/            # Reusable components
│   ├── ui/               # shadcn/ui components
│   ├── forms/             # Form components
│   └── layout/           # Layout components
├── lib/                  # Core utilities
│   ├── auth.ts           # Better Auth config
│   ├── db.ts             # Drizzle setup
│   ├── trpc.ts           # tRPC setup
│   └── validations.ts    # Zod schemas
├── types/                # TypeScript definitions
├── hooks/                # Custom React hooks
└── server/               # Server-only code
```

## 🤖 AI Agent System

Two-agent coordination for efficient development:
- **PM Agent** - Strategic planning and technical tickets
- **Full-Stack Agent** - Complete feature implementation

## 🎨 Design System

- **Clean, Professional Design** - Immaculate interfaces
- **Dark Mode Excellence** - Sophisticated dark themes  
- **Data-First Design** - Information architecture drives visual design
- **Typography Mastery** - Perfect hierarchy and readability

## 🛠️ Troubleshooting

### **Setup Issues**
- **Node.js version**: Ensure Node.js 18+ is installed
- **Network issues**: Check internet connection for dependency downloads
- **Permission errors**: Run with proper permissions on your system

### **Development Issues**
- **TypeScript errors**: Run `npm run type-check` to identify issues
- **Lint errors**: Run `npm run lint:fix` to auto-fix issues
- **Build failures**: Check for missing dependencies or configuration issues

## 🚀 Deployment

### **Vercel Deployment**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy to Vercel
vercel --prod
```

### **Production Checklist**
- [ ] All tests passing
- [ ] Build successful
- [ ] Environment variables configured
- [ ] Database migrations applied
- [ ] Performance optimized

## 📚 Documentation

- [Live Showcase](showcase/) - See the framework in action
- [Framework Docs](docs/framework/) - Core framework documentation
- [Agent Docs](docs/agents/) - AI agent coordination

## 🚀 Quick Commands

```bash
# Start development
npm run dev

# Lint and format
npm run lint:fix
npm run format

# Test
npm run test
npm run test:ui

# Build for production
npm run build
```

---

**The webapppromptpack ensures consistent, high-quality results that are impossible to mess up.**