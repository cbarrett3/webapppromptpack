# webapppromptpack getting started

## Getting Started

### **Step 1: Project Setup (2 Minutes)**
```bash
curl -sSL https://raw.githubusercontent.com/cbarrett3/webapppromptpack/main/templates/setup-script.sh | bash -s my-app
cd my-app && npm run dev
```

### **Step 2: Choose Your Agent**
- **PM Agent** - Writes tickets, manages roadmaps, has design mindset
- **Full-Stack Agent** - Builds complete features from database to UI

## Agent Workflow

### **Simple Two-Agent System**
1. **PM Agent** writes clear, actionable ticket
2. **Full-Stack Agent** receives ticket with requirements
3. **Full-Stack Agent** builds complete feature
4. **Feature complete** and ready for production

### **PM Agent → Full-Stack Agent Handoff**
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

## Quality Gates

### **Feature Completion**
- [ ] All acceptance criteria met
- [ ] Code quality standards followed
- [ ] Tests written and passing
- [ ] Accessibility compliance verified
- [ ] Performance optimized

### **Technology Stack (Non-Negotiable)**
- **Frontend**: Next.js 16 + TypeScript + Tailwind CSS 4+ + shadcn/ui
- **Backend**: Supabase + Drizzle ORM + tRPC + Zod + Better Auth
- **Development**: Vitest + Testing Library + Pino + Vercel

### **Design Standards**
- **Data-First Design** - Information architecture drives visual design
- **Immaculate Clean Style** - Every pixel serves a purpose
- **Sophisticated Dark Themes** - Deep backgrounds with high contrast
- **Generous Whitespace** - Purposeful breathing room
- **Professional Polish** - Interfaces that rival top SaaS products

**Simple, effective coordination between two focused agents.**

## Troubleshooting

### **Setup Issues**
- **Node.js version**: Ensure Node.js 18+ is installed
- **Network issues**: Check internet connection for dependency downloads
- **Permission errors**: Run with proper permissions on your system

### **Development Issues**
- **TypeScript errors**: Run `npm run type-check` to identify issues
- **Lint errors**: Run `npm run lint:fix` to auto-fix issues
- **Build failures**: Check for missing dependencies or configuration issues

### **Agent Coordination**
- **Unclear tickets**: Ask PM Agent to clarify requirements
- **Technical blockers**: Ask Full-Stack Agent to identify dependencies
- **Quality issues**: Use quality gates to ensure standards are met

## Deployment

### **Vercel Deployment**
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy to Vercel
vercel --prod
```

### **Environment Variables**
- Set up Supabase project and add credentials
- Configure authentication providers
- Add external API keys as needed

### **Production Checklist**
- [ ] All tests passing
- [ ] Build successful
- [ ] Environment variables configured
- [ ] Database migrations applied
- [ ] Performance optimized
