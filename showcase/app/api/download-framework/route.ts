import { NextResponse } from 'next/server'
import fs from 'fs'
import path from 'path'

export async function GET() {
  try {
    const parentDir = path.join(process.cwd(), '..')
    
    // Read all the framework files
    const cursorRulesPath = path.join(parentDir, '.cursorrules')
    const cursorRulesContent = fs.readFileSync(cursorRulesPath, 'utf8')
    
    const readmePath = path.join(parentDir, 'README.md')
    const readmeContent = fs.readFileSync(readmePath, 'utf8')
    
    // Read framework documentation
    const techStackPath = path.join(parentDir, 'docs', 'framework', 'tech-stack.md')
    const techStackContent = fs.readFileSync(techStackPath, 'utf8')
    
    const architecturePath = path.join(parentDir, 'docs', 'framework', 'architecture.md')
    const architectureContent = fs.readFileSync(architecturePath, 'utf8')
    
    const methodologyPath = path.join(parentDir, 'docs', 'framework', 'development-methodology.md')
    const methodologyContent = fs.readFileSync(methodologyPath, 'utf8')
    
    const codeStandardsPath = path.join(parentDir, 'docs', 'framework', 'code-standards.md')
    const codeStandardsContent = fs.readFileSync(codeStandardsPath, 'utf8')
    
    // Read agent documentation
    const masterAgentPath = path.join(parentDir, 'docs', 'agents', 'master-agent.md')
    const masterAgentContent = fs.readFileSync(masterAgentPath, 'utf8')
    
    const developmentAgentsPath = path.join(parentDir, 'docs', 'agents', 'development-agents.md')
    const developmentAgentsContent = fs.readFileSync(developmentAgentsPath, 'utf8')
    
    const pmAgentsPath = path.join(parentDir, 'docs', 'agents', 'pm-agents.md')
    const pmAgentsContent = fs.readFileSync(pmAgentsPath, 'utf8')
    
    const agentCoordinationPath = path.join(parentDir, 'docs', 'agents', 'agent-coordination.md')
    const agentCoordinationContent = fs.readFileSync(agentCoordinationPath, 'utf8')
    
    const designAgentPath = path.join(parentDir, 'docs', 'agents', 'design-agent.md')
    const designAgentContent = fs.readFileSync(designAgentPath, 'utf8')
    
    // Read templates
    const nextjsTemplatePath = path.join(parentDir, 'docs', 'templates', 'project-setup', 'nextjs-project.md')
    const nextjsTemplateContent = fs.readFileSync(nextjsTemplatePath, 'utf8')
    
    const trpcTemplatePath = path.join(parentDir, 'docs', 'templates', 'code-templates', 'trpc-procedures.md')
    const trpcTemplateContent = fs.readFileSync(trpcTemplatePath, 'utf8')
    
    const featureTicketPath = path.join(parentDir, 'docs', 'templates', 'ticket-templates', 'feature-ticket.md')
    const featureTicketContent = fs.readFileSync(featureTicketPath, 'utf8')
    
    const masterAgentPromptPath = path.join(parentDir, 'docs', 'templates', 'agent-prompts', 'master-agent-prompt.md')
    const masterAgentPromptContent = fs.readFileSync(masterAgentPromptPath, 'utf8')
    
    // Create comprehensive framework guide
    const comprehensiveGuide = `# Blueberry Prompt Kit - Complete Framework

${readmeContent}

---

# .cursorrules

${cursorRulesContent}

---

# Technology Stack

${techStackContent}

---

# Architecture

${architectureContent}

---

# Development Methodology

${methodologyContent}

---

# Code Standards

${codeStandardsContent}

---

# Master Agent

${masterAgentContent}

---

# Development Agents

${developmentAgentsContent}

---

# PM Agents

${pmAgentsContent}

---

# Agent Coordination

${agentCoordinationContent}

---

# Design Agent

${designAgentContent}

---

# Next.js Project Setup Template

${nextjsTemplateContent}

---

# tRPC Procedures Template

${trpcTemplateContent}

---

# Feature Ticket Template

${featureTicketContent}

---

# Master Agent Prompt Template

${masterAgentPromptContent}

---

# Quick Start Commands

## 1. Create New Project
\`\`\`bash
npx create-next-app@latest my-project --typescript --tailwind --app
cd my-project
\`\`\`

## 2. Install Dependencies
\`\`\`bash
npm install @supabase/supabase-js drizzle-orm @trpc/server @trpc/client @trpc/next zod better-auth pino
npm install -D @types/node eslint-config-prettier prettier vitest @testing-library/react @testing-library/jest-dom
\`\`\`

## 3. Copy Framework Files
\`\`\`bash
# Copy .cursorrules to project root
cp path/to/blueberry-prompt-kit/.cursorrules ./

# Copy .cursor directory for detailed rules
cp -r path/to/blueberry-prompt-kit/.cursor ./
\`\`\`

## 4. Set Up Environment
\`\`\`bash
# Create .env.local
touch .env.local

# Add environment variables
echo "NEXT_PUBLIC_SUPABASE_URL=your_supabase_url" >> .env.local
echo "NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key" >> .env.local
echo "SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key" >> .env.local
echo "DATABASE_URL=your_database_url" >> .env.local
echo "NEXTAUTH_SECRET=your_nextauth_secret" >> .env.local
echo "NEXTAUTH_URL=http://localhost:3000" >> .env.local
\`\`\`

## 5. Start Development
\`\`\`bash
npm run dev
\`\`\`

---

# Complete Framework Structure

\`\`\`
blueberry-prompt-kit/
├── .cursorrules                 # Cursor IDE rules
├── .cursor/                     # Detailed Cursor configuration
│   ├── rules/                  # Framework rules
│   └── prompts/                # Agent prompts
├── docs/                       # Complete documentation
│   ├── framework/              # Core framework docs
│   ├── agents/                 # AI agent coordination
│   └── templates/              # Ready-to-use templates
├── showcase/                   # Live demonstration
└── README.md                   # Framework overview
\`\`\`

This is the complete Blueberry Prompt Kit framework - everything you need to build consistent, high-quality web applications with AI agents.
`

    return new NextResponse(comprehensiveGuide, {
      headers: {
        'Content-Type': 'text/plain',
        'Content-Disposition': 'attachment; filename="blueberry-prompt-kit-complete.txt"',
      },
    })
  } catch (error) {
    console.error('Error creating comprehensive framework file:', error)
    return new NextResponse('Error creating comprehensive framework file', { status: 500 })
  }
}
