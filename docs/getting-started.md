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
